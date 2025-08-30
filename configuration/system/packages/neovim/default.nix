{
  pkgs,
  colorscheme,
  ...
}:
let
  theme = colorscheme.neovim;
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = true;
    configure = {
      customRC = ''
            "set backupcopy=no
            set number
            set list
            "set listchars=tab:␉\ ,trail:⋅,nbsp:⍽
            "set listchars=tab:⭾\ ,trail:¤,nbsp:•
            set listchars=tab:›\ ,trail:·,nbsp:␣
            set expandtab
            set tabstop=2 shiftwidth=2
            set scrolloff=50
            set cursorline
            set signcolumn=yes
            set nowrap
            set termguicolors
            colorscheme ${theme}
            set signcolumn=no
            set mouse=
            inoremap <C-l> <C-o>$
            inoremap <C-h> <C-o>^
            noremap <silent> <leader>e <Cmd>CocCommand explorer<CR>
            noremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>
            "set shada='100

            if has("autocmd")
              autocmd BufReadPost *
              \ if line("'\'") > 0 && line("'\'") <= line("$") |
              \ silent! exe "normal! g`\"" |
              \ endif
            endif


            " Navegar entre sugerencias de autocompletado
          inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
          inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

        " Confirmar con Enter
          inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
      '';

      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          #coc-ultisnips
          #codesnap-nvim
          #nvchad
          vim-colorschemes
          coc-css
          coc-emmet
          coc-explorer
          coc-go
          coc-html
          coc-json
          coc-markdownlint
          coc-nvim
          coc-pairs
          coc-pyright
          coc-rls
          coc-sh
          coc-spell-checker
          coc-svelte
          coc-tsserver
          coc-yank
          #llm-nvim
          lush-nvim
          melange-nvim
          nerdcommenter
          ollama-nvim
          srcery-vim
          #telescope-nvim
          vim-just
          vim-nix
        ];
      };
    };
  };
}
