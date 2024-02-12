return {
  "lukas-reineke/headlines.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = {
    markdown = {
      headline_highlights = {
        "Headline1",
        "Headline2",
        "Headline3",
        "Headline4",
        "Headline5",
        "Headline6",
      },
      codeblock_highlight = "CodeBlock",
      dash_highlight = "Dash",
      quote_highlight = "Quote",
      bullet_highlights = {
        -- "@text.title.1.marker.markdown",
        -- "@text.title.2.marker.markdown",
        -- "@text.title.3.marker.markdown",
        -- "@text.title.4.marker.markdown",
        -- "@text.title.5.marker.markdown",
        -- "@text.title.6.marker.markdown",
      },
      bullets = {},
      -- bullets = { "◉", "○", "✸", "✿" },
      dash_string = "-",
      quote_string = "┃",
      fat_headlines = false,
      fat_headline_upper_string = "▃",
      fat_headline_lower_string = "🬂",
    },
  },
}
