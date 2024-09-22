# Enable all recommended configuration for System76 systems
hardware.system76.enableAll = true;

## Disable other power-profile to let system76-power start
services.power-profiles-daemon.enable = false;

## User must take part of the 'adm' group for system76 hardware
users.users.quantum.extraGroups = [ "adm" ];
