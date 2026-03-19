-- dashboard setup
-- https://github.com/nvim-mini/mini.nvim

return {
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      local header = {
        '             ._,.                               ',
        '           "..-..pf.                            ',
        "          -L   ..#'                             ",
        '        .+_L  ."]#                              ',
        "        ,'j' .+.j`                 -'.__..,.,p. ",
        '       _~ #..<..0.                 .J-.``..._f. ',
        "      .7..#_.. _f.                .....-..,`4'  ",
        "      ;` ,#j.  T'      ..         ..J....,'.j`  ",
        '     .` .."^.,-0.,,,,yMMMMM,.    ,-.J...+`.j@   ',
        "    .'.`...' .yMMMMM0M@^=`\"\"g.. .'..J..\"'.jH   ",
        "    j' .'1`  q'^)@@#\"^\".`\"='BNg_...,]_)'...0-   ",
        "   .T ...I. j\"    .'..+,_.'3#MMM0MggCBf....F.   ",
        '   j/.+\'.{..+       `^~\'-^~~""""\'"""?\'"``\'1`    ',
        '   .... .y.}                  `.._-:`_...jf     ',
        "   g-.  .Lg'                 ..,..'-....,'.     ",
        "  .'.   .Y^                  .....',].._f       ",
        '  ......-f.                 .-,,.,.-:--&`       ',
        "                            .`...'..`_J`        ",
        "                            .~......'#'         ",
        "                            '..,,.,_]`          ",
        '                          .L..`..``.            ',
      }

      local buttons = {
        dashboard.button('f', '  Find file', '<cmd>Telescope find_files<cr>'),
        dashboard.button('r', '  Recent files', '<cmd>Telescope oldfiles<cr>'),
        dashboard.button('g', '  Live grep', '<cmd>Telescope live_grep<cr>'),
        dashboard.button('b', '󰈙  Buffers', '<cmd>Telescope buffers<cr>'),
        dashboard.button('o', '  Oil here', '<cmd>Oil<cr>'),
        dashboard.button('c', '  Config', '<cmd>lua require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })<cr>'),
        dashboard.button('l', '󰒲  Lazy', '<cmd>Lazy<cr>'),
        dashboard.button('q', '  Quit', '<cmd>qa<cr>'),
      }

      for _, button in ipairs(buttons) do
        button.opts.hl = 'Identifier'
        button.opts.hl_shortcut = 'Number'
        button.opts.width = 30
        button.opts.cursor = 3
        button.opts.align_shortcut = 'right'
      end

      local header_group = {
        type = 'text',
        val = header,
        opts = {
          hl = 'Type',
          position = 'center',
        },
      }

      local footer_group = {
        type = 'text',
        val = { '', 'Lights. Camera. Refactor.' },
        opts = {
          hl = 'Comment',
          position = 'center',
        },
      }

      local buttons_group = {
        type = 'group',
        val = buttons,
        opts = {
          spacing = 1,
        },
      }

      local function side_by_side_layout()
        return {
          { type = 'padding', val = 2 },
          {
            type = 'group',
            val = {
              {
                type = 'group',
                val = { header_group },
                opts = {
                  position = 'center',
                },
              },
              {
                type = 'padding',
                val = 2,
              },
              {
                type = 'group',
                val = { buttons_group },
                opts = {
                  position = 'center',
                },
              },
            },
            opts = {
              spacing = 0,
              position = 'center',
              layout = 'horizontal',
            },
          },
          { type = 'padding', val = 2 },
          footer_group,
        }
      end

      local function stacked_layout()
        return {
          { type = 'padding', val = 2 },
          header_group,
          { type = 'padding', val = 2 },
          buttons_group,
          footer_group,
        }
      end

      local function apply_layout()
        if vim.o.columns >= 120 then
          dashboard.config.layout = side_by_side_layout()
        else
          dashboard.config.layout = stacked_layout()
        end
      end

      apply_layout()
      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.config)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'alpha',
        callback = function(args)
          vim.opt_local.mouse = ''
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.cursorline = false
          vim.opt_local.signcolumn = 'no'
          vim.opt_local.wrap = false
          vim.opt_local.scrolloff = 0
          vim.opt_local.sidescrolloff = 0

          local buf = args.buf

          local function lock_view()
            if not vim.api.nvim_buf_is_valid(buf) then
              return
            end

            local wins = vim.fn.win_findbuf(buf)
            for _, win in ipairs(wins) do
              if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_set_cursor(win, { 1, 0 })
                vim.fn.winrestview { topline = 1, leftcol = 0 }
              end
            end
          end

          lock_view()

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'WinScrolled', 'BufEnter' }, {
            buffer = buf,
            callback = lock_view,
          })
        end,
      })

      vim.api.nvim_create_autocmd('VimResized', {
        callback = function()
          apply_layout()
          pcall(alpha.redraw)
        end,
      })
    end,
  },
}
