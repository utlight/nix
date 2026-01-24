do
	local builtin = require("telescope.builtin")

	--search
	vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
	vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
	vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
	vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
	vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
	vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

	--lsp
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			map("<leader>r", vim.lsp.buf.rename, "Rename")
			map("<leader>lD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			map("<leader>la", vim.lsp.buf.code_action, "[G]oto Code [A]ction")
			vmap("<leader>lq", vim.diagnostic.setloclist, "Open [Q]uickfix list")

			map("<leader>ld", builtin.lsp_definitions, "[G]oto [D]efinition")
			map("<leader>lr", builtin.lsp_references, "[G]oto [R]eferences")
			map("<leader>li", builtin.lsp_implementations, "[G]oto [I]mplementation")
			map("<leader>lt", builtin.lsp_type_definitions, "[G]oto [T]ype Definition")
			map("<leader>lsd", builtin.lsp_document_symbols, "[G]oto [S]ymbols in [D]ocument")
			map("<leader>lsw", builtin.lsp_dynamic_workspace_symbols, "[G]oto [S]ymbols in [W]orkspace")
		end,
	})
end
