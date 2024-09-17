return {
    "hrsh7th/nvim-cmp",
    ft = "markdown",
    config = function()
        local cmp = require('cmp')
        cmp.setup({
            sources = cmp.config.sources({
                { name = 'buffer' },
            }),
            mapping = cmp.mapping.preset.insert(),
        })
    end,
}
