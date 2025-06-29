
return {
    'gelguy/wilder.nvim',
    lazy = false,
    config = function()

        local wilder = require('wilder')
        wilder.setup({ modes = { '/', '?',':', }, })

        -- WIP
        -- I'm unsure by using 'vim' will cause performace issues here. Perhaps it might solve the _wilder_python_search issue.
        -- Python support is not configured in this config yet.
        -- And I'm not sure if this is using python or not; neither if it is already working or not.

        wilder.set_option('pipeline', {
            wilder.branch(
                wilder.cmdline_pipeline({
                    -- sets the language to use, 'vim' and 'python' are supported
                    language = 'vim',
                    -- 0 turns off fuzzy matching
                    -- 1 turns on fuzzy matching
                    -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
                    fuzzy = 1,
                }),
                wilder.python_search_pipeline({
                    -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
                    pattern = wilder.python_fuzzy_pattern(),
                    -- omit to get results in the order they appear in the buffer
                    sorter = wilder.python_difflib_sorter(),
                    -- can be set to 're2' for performance, requires pyre2 to be installed
                    -- see :h wilder#python_search() for more details
                    engine = 're',
                })
            ),
        })

    end 
}
