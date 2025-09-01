{ pkgs, ... }:

let
  packages = with pkgs; [
    nushell
    oils-for-unix
    xonsh
  ];
in
{
  environment = {
    shells = packages;
    systemPackages = packages;
  };
  programs.bash = {
    promptInit = ''
      # Ignora comandos que comienzan con espacio
      HISTCONTROL=ignorespace

      # Comandos que no se guardan en historial
      #HISTIGNORE='age*:ssh*:gocryptfs*'

      # Formato de fecha/hora en historial (día-mes hora:minuto)
      HISTTIMEFORMAT="%d-%m %H:%M "

      # Autocorrección para rutas en 'cd'
      shopt -s cdspell

      # Autocorrección en autocompletado de directorios
      shopt -s dirspell

      # Autocompletado insensible a mayúsculas
      shopt -s nocaseglob

      # Desactiva colores en listados de autocompletado
      #bind 'set colored-stats off'

      # Desactiva resaltado de prefijos al autocompletar
      #bind 'set colored-completion-prefix off'

      # Muestra opciones con un solo TAB
      bind 'set show-all-if-ambiguous on'

      # Autocompletado que ignora mayúsculas/minúsculas
      bind 'set completion-ignore-case on'



      if [ "$(id -u)" -eq 0 ]; then
        PS1='\[\e[31m\]#!  \[\e[0m\]'
      else
        PS1='#!  '
      fi

    '';
  };
}
