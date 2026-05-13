def intercept [] {
    let input_data = $in
    let temp_file = (mktemp -t intercept.XXXXXX)
    
    # Write input to temp file
    $input_data | save -f $temp_file
    
    # Open in Helix
    hx $temp_file
    
    # Read modified content and clean up
    let output = (open --raw $temp_file)
    rm $temp_file
    
    $output
}
