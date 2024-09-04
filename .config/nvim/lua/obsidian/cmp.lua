return {
    "hrsh7th/nvim-cmp",
    config = function()
        local cmp = require('cmp')
        -- cmp.setup({
        --     sources = {},
        -- })
        cmp.setup({
            sources = cmp.config.sources({
                { name = 'buffer' },
            }),
            mapping = cmp.mapping.preset.insert(),
        })
    end,
}
