{
  services.logind = {
    # Acción al presionar brevemente el botón de encendido
    powerKey = "ignore";

    # Acción al mantener presionado el botón de encendido
    powerKeyLongPress = "poweroff";

    # Acción al cerrar la tapa del portátil
    lidSwitch = "ignore";

    # Acción al cerrar la tapa si hay un monitor externo conectado
    lidSwitchExternalPower = "ignore";

    # Acción al cerrar la tapa si el equipo está "acoplado" (dock station, etc.)
    lidSwitchDocked = "ignore";

    # Permite que los procesos del usuario sigan ejecutándose tras cerrar sesión
    killUserProcesses = false;

    # Configuración adicional para logind.conf (opcional)
    extraConfig = ''
      # Aquí puedes añadir líneas personalizadas si las necesitas
    '';
  };
}
