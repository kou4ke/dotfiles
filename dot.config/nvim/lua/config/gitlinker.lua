local gitlinker = require('gitlinker')

gitlinker.setup {
  opts = {
    action_callback = function(url)
      print("Generated URL: " .. url)
      require('gitlinker.actions').open_in_browser(url)
    end,
    print_url = true,
    -- action_callback = require('gitlinker.actions').open_in_browser,
    -- print_url = false,
  },
  mappings = '<Leader>go',
}
