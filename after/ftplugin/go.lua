local map = vim.keymap.set
map("n", ",p", [[<cmd>s/\(\s*\)\(.\+\)/\1fmt.Printf("\2: %#v\\n", \2)<cr>]], { desc = "Surround var with fmt.Println" })
map(
	"n",
	",e",
	[[Iif err := <esc>A; err != nil {
}<esc>Opanic(err)<esc>]]
)
