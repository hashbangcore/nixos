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
      agentica = "openrouter/agentica-org/deepcoder-14b-preview:free";
      gemini-flash = "gemini/gemini-2.5-flash";
      gemini-lite = "gemini/gemini-2.5-flash-lite";
      gemini-pro = "gemini/gemini-2.5-pro";
      qwen2 = "openrouter/qwen/qwen-2.5-coder-32b-instruct:free";
      qwen3 = "openrouter/qwen/qwen3-coder:free";

      set = name: model: ''
        function! SelectModel${name}()
          lua require("sllm").setup({default_model = "${model}"})
          echo "Select Model: ${name}"
        endfunction

        command! SelectModel${name} call SelectModel${name}()

      '';
    };
    config = ''
      lua require("sllm").setup({ default_model = "${model.gemini-lite}" })

      ${model.set "Agentica" model.agentica}
      ${model.set "GeminiFlash" model.gemini-flash}
      ${model.set "GeminiLite" model.gemini-lite}
      ${model.set "GeminiPro" model.gemini-pro}
      ${model.set "Qwen2" model.qwen2}
      ${model.set "Qwen3" model.qwen3}
    '';
  };

  codestral = ''
    lua <<EOF
    local llm = require('llm')
    llm.setup({
      api_token = "zPNqH1IReAEfyR0IraCoRaIjGnYUfkH8",
      model = "codestral-latest",
      backend = "openai",
      url = "https://codestral.mistral.ai/v1",
      fim = {
        enabled = true,
      },
      request_body = {
        parameters = {
          max_new_tokens = 60,
          temperature = 0.2,
          top_p = 0.95,
        },
      },
    })
    EOF
  '';

  customRC = ''
    "set backupcopy=no
    set number
    set nolist
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

    command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

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
        coc-prettier
        coc-pyright
        coc-rust-analyzer
        coc-sh
        coc-spell-checker
        coc-svelte
        coc-tsserver
        coc-yank
        colorizer
        llm-nvim
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
  environment.systemPackages = with pkgs; [
    llm-ls
  ];
}
