local M = {}

M.eslint = {
	prefix = "eslint_d",
	lintSource = "efm/eslint_d",
	lintCommand = 'eslint_d --no-color --format visualstudio --stdin-filename "${INPUT}" --stdin',
	lintStdin = true,
	lintFormats = { "%f(%l,%c): %trror %m", "%f(%l,%c): %tarning %m" },
	lintIgnoreExitCode = true,
	formatCommand = "eslint_d --fix-to-stdout --stdin-filename '${INPUT}' --stdin",
	formatStdin = false,
	rootMarkers = {
		".eslintrc",
		".eslintrc.cjs",
		".eslintrc.js",
		".eslintrc.json",
		".eslintrc.yaml",
		".eslintrc.yml",
		"package.json",
	},
}

M.prettier = {
	formatCanRange = true,
	formatCommand = "prettier --stdin --stdin-filepath '${INPUT}' ${--range-start:charStart} "
		.. "${--range-end:charEnd} ${--tab-width:tabSize} ${--use-tabs:!insertSpaces}",
	formatStdin = true,
	rootMarkers = {
		".prettierrc",
		".prettierrc.json",
		".prettierrc.js",
		".prettierrc.yml",
		".prettierrc.yaml",
		".prettierrc.json5",
		".prettierrc.mjs",
		".prettierrc.cjs",
		".prettierrc.toml",
	},
}

M.stylua = {
	formatCanRange = true,
	formatCommand = "stylua --color Never ${--range-start:charStart} ${--range-end:charEnd} -",
	formatStdin = true,
	rootMarkers = { "stylua.toml", ".stylua.toml" },
}

M.markdownlint = {
	prefix = "markdownlint",
	lintSource = "efm/markdownlint",
	lintCommand = "markdownlint --stdin",
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = { "%f:%l:%c %m", "%f:%l %m", "%f: %l: %m" },
}

M.luacheck = {
	prefix = "luacheck",
	lintSource = "efm/luacheck",
	lintCommand = "luacheck --codes --no-color --quiet -",
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = { "%.%#:%l:%c: (%t%n) %m" },
	rootMarkers = { ".luacheckrc" },
}

return M
