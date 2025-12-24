{
  services.logind.settings.Login = {
    # Acción al presionar brevemente el botón de encendido
    HandlePowerKey = "ignore";

    # Acción al mantener presionado el botón de encendido
    HandlePowerKeyLongPress = "poweroff";

    # Acción al cerrar la tapa del portátil
    HandleLidSwitch = "ignore";

    # Acción al cerrar la tapa si hay un monitor externo conectado
    HandleLidSwitchExternalPower = "ignore";

    # Acción al cerrar la tapa si el equipo está "acoplado" (dock station, etc.)
    HandleLidSwitchDocked = "ignore";

    # Permite que los procesos del usuario sigan ejecutándose tras cerrar sesión
    KillUserProcesses = false;
  };
}
