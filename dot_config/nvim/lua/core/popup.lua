function run_and_exit_on_keypress(command)
  local Popup = require('nui.popup')
  local popup = Popup {
    enter = true,
    relative = "editor",
    position = "50%",
    size = "80%",
    wrap = true,
    border = {
      style = "rounded",
      text = { top = command },
    },
    keep_alive = false
  }

  popup:mount()
  vim.fn.termopen(command)
  vim.cmd('startinsert')
end
