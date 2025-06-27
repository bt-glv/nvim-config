
--
-- If you need a tutorial, watch this video
-- https://www.youtube.com/watch?v=FuYQ7M73bC0&t=58s
--

return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = false,
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    priority = 100,
    config = function()
        require'nvim-treesitter.configs'.setup {
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',

                        ['ic'] = '@conditional.inner',
                        ['ac'] = '@conditional.outer',

                        ['as'] = '@block.outer',
                        ['is'] = '@block.inner',
                        --["as"] = { query = "@local.scope.inner", query_group = "locals", desc = "Select language scope" },

                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",

                        ["aC"] = "@class.outer",
                        ["iC"] = { query = "@class.inner", desc = "Select inner part of a class region" },

                        --["iz"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V', -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    include_surrounding_whitespace = true,
                },

                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        -- ["]m"] = "@function.outer",
                        -- ["]]"] = { query = "@class.outer", desc = "Next class start" },
                        -- ["]o"] = "@loop.*",
                        -- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },

                        ["[s"] = { query = "@block.outer"},
                        -- ["[s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
                    },
                    goto_next_end = {
                        -- ["]S"] = { query = "@local.scope", query_group = "locals", desc = "Previous scope" },
                        -- ["]f"] = "@function.outer",
                        -- ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["]s"] = { query = "@block.outer"},
                        -- ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Previous scope" },

                        -- ["[f"] = "@function.outer",
                        -- ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        -- ["]S"] = { query = "@local.scope", query_group = "locals", desc = "Previous scope" },
                        -- ["[M"] = "@function.outer",
                        -- ["[]"] = "@class.outer",
                    },
                    goto_next = {
                        ["[f"] = "@function.outer",
                        ["[c"] = "@conditional",
                    },
                    goto_previous = {
                        ["]f"] = "@function.outer",
                        ["]c"] = "@conditional",
                    }
                },

            },



        }
    end
}
