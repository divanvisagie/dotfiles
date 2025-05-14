return {
  "RaafatTurki/hex.nvim",
  config = function()
    require 'hex'.setup {
      dump_cmd = 'xxd -g 1 -u',
      assemble_cmd = 'xxd -r',
      is_buf_binary_pre_read = function()
        -- logic that determines if a buffer contains binary data or not
        -- must return a bool
      end,
      is_buf_binary_post_read = function()
        -- logic that determines if a buffer contains binary data or not
        -- must return a bool
      end,
    }
  end
} 
