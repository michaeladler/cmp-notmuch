-- SPDX-FileCopyrightText: 2024 Michael Adler
-- SPDX-License-Identifier: Apache-2.0
--
-- Author: Michael Adler <therisen06@gmail.com>
local notmuch = {}

local util = require("cmp_notmuch.util")

function notmuch.new(opts)
	local self = setmetatable({}, { __index = notmuch })
	self.opts = opts or {}
	return self
end

function notmuch:get_trigger_characters()
	return { "@", "." }
end

function notmuch:get_completions(context, callback)
	if vim.bo.filetype ~= "mail" or context.cursor[1] > 3 then
		-- do not trigger completion for rows > 3
		callback()
		return
	end

	local input = string.sub(context.line, context.bounds.start_col, context.bounds.end_col)
	local candidates = util.candidates(input)

	callback({
		context = context,
		is_incomplete_forward = true,
		is_incomplete_backward = true,
		items = candidates.items or candidates,
	})
end

return notmuch
