# Usage:
#   readelf -S <PATH> | elf sections
#   readelf -l <PATH> | elf segments

def "elf sections" []: string -> table {
    let raw = $in

    # Print header offset line
    $raw | lines | first | parse "There are {_} section headers, starting at offset {offset}:" | print $"Section Header Table Offset: ($in.offset.0)"

    # Print flags key in ascending order on one line
    let flags_line = (
        $raw | lines
        | where { |l| $l =~ '^\s+[A-Z] \(' }
        | each { |l|
            $l | split row ','
            | each { str trim }
        }
        | flatten
        | where { ($in | str length) > 0 }
        | sort
        | str join ', '
    )
    print $"Key to Flags: \n($flags_line)\n"

    # Collect lines that look like section data rows.
    let data_lines = (
        $raw | lines | where { |l|
            ($l | str trim | parse --regex '^\[\s*\d+\]' | is-not-empty) or ($l | str trim | parse --regex '^[0-9a-f]{16}' | is-not-empty)
        }
    )

    $data_lines
    | chunks 2
    | where { |pair| ($pair | length) == 2 }
    | each { |pair|
        let h = $pair.0 | str trim
        let s = $pair.1 | str trim

        let hparts = $h | parse --regex '\[\s*(?P<nr>\d+)\]\s+(?P<name>\S*)\s+(?P<type>\S+)\s+(?P<addr>[0-9a-f]+)\s+(?P<offset>[0-9a-f]+)'
        if ($hparts | is-empty) { return null }
        let hp = $hparts.0

        let sparts = $s | parse --regex '(?P<size>[0-9a-f]+)\s+(?P<entsize>[0-9a-f]+)\s+(?P<flags>\S*)\s+(?P<link>\d+)\s+(?P<info>\d+)\s+(?P<align>\d+)'
        if ($sparts | is-empty) { return null }
        let sp = $sparts.0

        {
            name:    (if ($hp.name | str length) == 0 { "(null)" } else { $hp.name })
            type:    $hp.type
            address: $hp.addr
            offset:  $hp.offset
            size_b:  ("0x" + $sp.size | into int)
            entsize: $sp.entsize
            flags:   $sp.flags
            link:    ($sp.link | into int)
            info:    ($sp.info | into int)
            align:   ($sp.align | into int)
        }
    }
    | where { |r| $r != null }
}

def "elf segments" []: string -> table {
    let lines = $in | lines

    # Locate block boundaries
    let ph_start = ($lines
        | enumerate
        | where { |it| $it.item | str starts-with "Program Headers:" }
        | get 0.index)

    let ss_start = ($lines
        | enumerate
        | where { |it| ($it.item | str trim) | str starts-with "Section to Segment mapping:" }
        | get 0.index)

    # Parse ELF file metadata from the preamble (lines before Program Headers)
    let preamble = $lines | slice 0..$ph_start
    let elf_type = ($preamble
        | where { |l| $l | str contains "Elf file type is" }
        | first
        | str replace --regex '.*Elf file type is\s+' '')
    let entry_point = ($preamble
        | where { |l| $l | str contains "Entry point" }
        | first
        | str replace --regex '.*Entry point\s+' '')
    let ph_offset = ($preamble
        | where { |l| $l | str contains "starting at offset" }
        | first
        | str replace --regex '.*starting at offset\s+' ''
        | str trim)

    print $"ELF File Type: ($elf_type)"
    print $"Entry Point: ($entry_point)"
    print $"Program Header Table Offset: ($ph_offset)"

    # "Program Headers:"      → ph_start
    # Two-line column header  → ph_start+1, ph_start+2
    # Data starts             → ph_start+3
    let ph_lines = $lines
        | slice ($ph_start + 3)..<($ss_start - 1)
        | where { |l| not ($l | str trim | is-empty) }

    # "Section to Segment mapping:" → ss_start
    # "Segment Sections..."         → ss_start+1
    # Data starts                   → ss_start+2
    let ss_lines = $lines | slice ($ss_start + 2)..<($lines | length)

    # Parse Section-to-Segment mapping
    let section_map = $ss_lines | each { |line|
        let trimmed = $line | str trim
        if ($trimmed | is-empty) { null } else {
            let parts = $trimmed | split row --regex '\s+'
            let idx   = $parts | first | into int
            let sects = if ($parts | length) > 1 {
                $parts | slice 1..($parts | length | $in - 1)
            } else {
                []
            }
            { index: $idx, sections: $sects }
        }
    } | compact

    # Parse Program Headers
    # Line A : <TYPE>  <Offset>  <VirtAddr>  <PhysAddr>
    # Line B : <FileSiz>  <MemSiz>  <Flags...>  <Align>
    #          tokens: [0]=FileSiz [1]=MemSiz [2..len-2]=Flags [len-1]=Align
    let result = $ph_lines | reduce --fold { rows: [], buf: null } { |line, acc|
        let trimmed = $line | str trim

        if ($trimmed | str starts-with "[Requesting program interpreter:") {
            # Print interpreter path as a comment
            let interp_path = ($trimmed | str trim
                | str replace "[Requesting program interpreter: " ""
                | str replace "]" "")
            print $"Interpreter Path: ($interp_path)"
            $acc
        } else {
            let parts = $trimmed | split row --regex '\s+'

            if ($parts | first | str starts-with "0x") {
                # Line B
                let len     = $parts | length
                let file_sz = $parts | get 0
                let mem_sz  = $parts | get 1
                let flags   = $parts | slice 2..($len - 2) | str join " "
                let align   = $parts | last

                let completed = $acc.buf | merge {
                    file_size: $file_sz,
                    mem_size:  $mem_sz,
                    flags:     $flags,
                    align:     $align,
                }
                { rows: ($acc.rows | append $completed), buf: null }
            } else {
                # Line A
                let new_buf = {
                    type:      ($parts | get 0),
                    offset:    ($parts | get 1),
                    virt_addr: ($parts | get 2),
                    phys_addr: ($parts | get 3),
                    file_size: null,
                    mem_size:  null,
                    flags:     null,
                    align:     null,
                }
                if $acc.buf != null {
                    { rows: ($acc.rows | append $acc.buf), buf: $new_buf }
                } else {
                    { rows: $acc.rows, buf: $new_buf }
                }
            }
        }
    }

    print ""

    # Join section lists by segment index while building the table
    $result.rows
    | (if $result.buf != null { append $result.buf } else { $in })
    | enumerate | each { |it|
        let idx = $it.index
        let seg   = $section_map | where { |s| $s.index == $idx }
        let sects = if ($seg | is-empty) { [] } else { $seg | first | get sections }
        $it.item | merge { segment_sections: $sects }
    }
}
