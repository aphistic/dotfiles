let-env config = {
	show_banner: false

	table: {
		mode: none
		index_mode: auto
	}

	history: {
		max_size: 100000
		sync_on_enter: true
		file_format: plaintext
	}
}

# source ~/.cache/zoxide/init.nu
source ~/.cache/starship/init.nu