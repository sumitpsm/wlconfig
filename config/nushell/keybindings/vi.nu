$env.config.keybindings ++= [
  # motions
  {
    name: move_left
    modifier: none
    keycode: char_e
    mode: vi_normal
    event: { send: left }
  }
  {
    name: move_down
    modifier: none
    keycode: char_i
    mode: vi_normal
    event: { send: down }
  }
  {
    name: move_up
    modifier: none
    keycode: char_y
    mode: vi_normal
    event: { send: up }
  }
  {
    name: move_right
    modifier: none
    keycode: char_o
    mode: vi_normal
    event: { send: right }
  }
  {
    name: move_line_start
    modifier: shift
    keycode: char_e
    mode: vi_normal
    event: { edit: movetostart }
  }
  {
    name: move_line_end
    modifier: shift
    keycode: char_o
    mode: vi_normal
    event: { edit: movetoend }
  }
  # {
  #   name: find_next_char
  #   modifier: none
  #   keycode: char_f
  #   mode: vi_normal
  #   event: { edit: moverightuntil }
  # }
  # {
  #   name: find_prev_char
  #   modifier: shift
  #   keycode: char_f
  #   mode: vi_normal
  #   event: { edit: moveleftuntil }
  # }
  # {
  #   name: till_next_char
  #   modifier: none
  #   keycode: char_t
  #   mode: vi_normal
  #   event: { edit: moverightuntil }
  # }
  # {
  #   name: till_prev_char
  #   modifier: shift
  #   keycode: char_t
  #   mode: vi_normal
  #   event: { edit: moveleftuntil }
  # }
  # {
  #   name: enter_insert
  #   modifier: none
  #   keycode: char_n
  #   mode: vi_normal
  #   event: { send: enterviinsert }
  # }
]

# $env.config = {
#   edit_mode: "vi"
#   keybindings: []
# }
