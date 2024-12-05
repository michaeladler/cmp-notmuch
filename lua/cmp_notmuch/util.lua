-- SPDX-FileCopyrightText: 2024 Michael Adler
-- SPDX-License-Identifier: Apache-2.0
--
-- Author: Michael Adler <therisen06@gmail.com>

local M = {}

M.candidates = function(search_term)
    local cmd = string.format("notmuch address --format=json --deduplicate=address '%s'", search_term)
    local response = vim.fn.system(cmd)

    local items = {}

    local process_data = function(ok, parsed)
        if not ok then
            vim.notify("Failed to parse api result")
            return
        end

        for _, item in ipairs(parsed) do
            local name_addr = item["name-addr"]
            table.insert(items, {
                word = name_addr,
                label = name_addr,
                insertText = name_addr,
                kind = vim.lsp.protocol.CompletionItemKind.Text,
                insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
            })
        end
    end

    if vim.json and vim.json.decode then
        local ok, parsed = pcall(vim.json.decode, response)
        process_data(ok, parsed)
    else
        vim.schedule(function()
            local ok, parsed = pcall(vim.fn.json_decode, response)
            process_data(ok, parsed)
        end)
    end

    return items
end

return M
