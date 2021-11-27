-- Copyright 2021 Michael Adler
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
local cmp = require("cmp")

local source = {}

source.new = function()
	return setmetatable({}, { __index = source })
end

source.is_available = function()
	return vim.bo.filetype == "mail"
end

source.get_trigger_characters = function()
	return { "@", "." }
end

source.get_keyword_pattern = function()
	return "[^[:blank:]]*"
end

local function candidates(search_term)
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

source.complete = function(self, request, callback)
	-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/context.lua
	if request.context.cursor.line <= 3 then
		local input = string.sub(request.context.cursor_before_line, request.offset)
		callback({ items = candidates(input), isIncomplete = true })
		return
	end
	callback()
end

return source
