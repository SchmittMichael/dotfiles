return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- TODO: think about lazy loading
  -- event = { "BufReadPre", "BufNewFile" },
  config = function()
    local harpoon = require("harpoon")
    local extensions = require("harpoon.extensions")

    harpoon:extend(extensions.builtins.navigate_with_number())
    harpoon:setup()

    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
      vim.notify("   Marked file", vim.log.levels.INFO, { title = "Harpoon" })
    end, { desc = "Harpoon | Add Mark" })

    -- vim.keymap.set("n", "<leader>A", function() harpoon:list():prepend() end)
    -- vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    -- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set(
      "n",
      "<leader>hh",
      function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Harpoon | Menu" }
    )

    vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end, { desc = "Harpoon | Select buffer 1" })
    vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end, { desc = "Harpoon | Select buffer 2" })
    vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end, { desc = "Harpoon | Select buffer 3" })
    vim.keymap.set("n", "<M-4>", function() harpoon:list():select(4) end, { desc = "Harpoon | Select buffer 4" })
    vim.keymap.set("n", "<M-5>", function() harpoon:list():select(5) end, { desc = "Harpoon | Select buffer 5" })

    -- replacing
    vim.keymap.set(
      "n",
      "<leader><M-1>",
      function() harpoon:list():replace_at(1) end,
      { desc = "Harpoon | Replace buffer at 1" }
    )
    vim.keymap.set(
      "n",
      "<leader><M-2>",
      function() harpoon:list():replace_at(2) end,
      { desc = "Harpoon | Replace buffer at 2" }
    )
    vim.keymap.set(
      "n",
      "<leader><M-3>",
      function() harpoon:list():replace_at(3) end,
      { desc = "Harpoon | Replace buffer at 3" }
    )
    vim.keymap.set(
      "n",
      "<leader><M-4>",
      function() harpoon:list():replace_at(4) end,
      { desc = "Harpoon | Replace buffer at 4" }
    )
    vim.keymap.set(
      "n",
      "<leader><M-5>",
      function() harpoon:list():replace_at(5) end,
      { desc = "Harpoon | Replace buffer at 5" }
    )

    -- traverse
    vim.keymap.set("n", "<leader>hn", function() require("harpoon"):list():next() end, { desc = "Harpoon | Next" })
    vim.keymap.set("n", "<leader>hp", function() require("harpoon"):list():prev() end, { desc = "Harpoon | Previous" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
  end,
}