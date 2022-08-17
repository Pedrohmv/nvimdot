local nmap = require("ph.keymap").nmap

require("flutter-tools").setup{
  fvm = true,
}

nmap { "<leader>fr", "<cmd>FlutterRun<CR>" }
nmap { "<leader>fe", "<cmd>FlutterEmulators<CR>" }
nmap { "<leader>mk", "<cmd>!make pub-get && make gen<CR>" }
