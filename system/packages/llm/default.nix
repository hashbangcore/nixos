{ unstable, ... }:

let
  llm-horde = unstable.python3Packages.buildPythonPackage rec {
    pname = "llm-horde";
    version = "main";
    pyproject = true;

    src = unstable.fetchFromGitHub {
      owner = "spinagon";
      repo = "llm-horde";
      rev = version;
      sha256 = "1w0qli2s8wj2bzzj9vw3slh56i3409zqw9xsak2jnqksfzn6zk2y";
    };

    build-system = [ unstable.python3Packages.setuptools ];
    dependencies = with unstable.python3Packages; [
      llm
      requests
    ];

    pythonImportsCheck = [ "llm_horde" ];
    doCheck = true;
  };

  plugins =
    with unstable.python3Packages;
    [
      llm-horde
    ]
    ++ [
      llm-cmd
      llm-deepseek
      llm-docs
      llm-gemini
      llm-gguf
      llm-git
      llm-grok
      llm-jq
      llm-mistral
      llm-ollama
      llm-openrouter
      llm-tools-sqlite
    ];
in
{
  environment.systemPackages = [
    (unstable.python3.withPackages (ps: [ ps.llm ] ++ plugins))
  ];
}
