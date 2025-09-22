{ unstable, ... }:

let
  plugins = with unstable.python3Packages; [
    llm-cmd
    llm-docs
    llm-gemini
    llm-gguf
    llm-git
    llm-grok
    llm-jq
    llm-ollama
    llm-openrouter
  ];
in
{
  environment.systemPackages = [
    (unstable.python3.withPackages (ps: [ ps.llm ] ++ plugins))
  ];
}
