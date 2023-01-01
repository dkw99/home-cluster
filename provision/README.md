# LAPTOP Configurations

## Switch off the screen after 5 mins

1. Edit `/etc/default/grub`

```
GRUB_CMDLINE_LINUX="consoleblank=300"
```

2. Update grub

```
update-grub
```

## Prevent the laptop from sleeping when closing the lid

1. To switch off the screen (regardless of whether the lid is open or closed) modify `/etc/systemd/logind.conf` and add/edit following lines:

```
HandleLidSwitch=ignore
HandleLidSwitchDocked=ignore
```

3. Save the file and restart the service.

```
systemctl restart systemd-logind.service
```
