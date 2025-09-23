{
  pkgs,
  colorscheme,
  ...
}:
let
  theme = colorscheme.neovim;

  sllm = rec {
    plugin = pkgs.vimUtils.buildVimPlugin {
      pname = "sllm";
      version = "0.2.2";
      src = pkgs.fetchFromGitHub {
        owner = "mozanunal";
        repo = "sllm.nvim";
        rev = "v0.2.0";
        sha256 = "0prlabhc6qxmfkz193r6lmh9kjvyfvrg4x3p0vgy1y5rq13k9mpy";
      };
    };

    model = {
      qwen2 = "openrouter/qwen/qwen-2.5-coder-32b-instruct:free";
      qwen3 = "openrouter/qwen/qwen3-coder:free";
      agentica = "openrouter/agentica-org/deepcoder-14b-preview:free";
      set =
        name: model: ''command! Select${name} lua require("sllm").setup({default_model = "${model}"})'';
    };
    config = ''
      lua require("sllm").setup({ default_model = "${model.qwen2}" })

      ${model.set "Qwen2" model.qwen2}
      ${model.set "Qwen3" model.qwen3}
      ${model.set "Agentica" model.agentica}

    '';
  };

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
    ${sllm.config}
  '';

  packages = {
    default = with pkgs.vimPlugins; {
      start = [
        sllm.plugin
      ]
      ++ [
        #coc-ultisnips
        #codesnap-nvim
        #llm-nvim
        #nvchad
        #telescope-nvim
        coc-css
        coc-emmet
        coc-explorer
        coc-go
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
        colorizer
        lush-nvim
        melange-nvim
        nerdcommenter
        ollama-nvim
        srcery-vim
        vim-colorschemes
        vim-just
        vim-nix
      ];
    };
  };

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
      inherit customRC packages;
    };
  };
}
