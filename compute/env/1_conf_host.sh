#!/bin/bash

source ../../services.sh

config_hosts() {
  echo "======================================================="
  echo "[OSTACK] Configure controller hosts"
  echo "======================================================="

  if [[ -f /etc/hosts.ori ]]; then
    echo "[OSTACK] Configuring openstack controller hosts.."

  else
    echo "[OSTACK] Backup original configuration.."
    sudo cp /etc/hosts /etc/hosts.ori

    echo "[OSTACK] Configuring openstack controller hosts.."
    sudo cp ../config/hosts /etc/hosts
  fi

  echo "[OSTACK] Done."
  config_hostname
}

config_hostname() {
  echo "======================================================="
  echo "[OSTACK] Configure controller hostname"
  echo "======================================================="

  read -p "Enter hostname (Compute1,2,... n): " NAME

  if [[ -f /etc/hostname.ori ]]; then
    echo "[OSTACK] Configuring openstack controller hostname.."
    echo ${NAME} > /etc/hostname
  else
    echo "[OSTACK] Backup original configuration.."
    sudo cp /etc/hostname /etc/hostname.ori

    echo "[OSTACK] Configuring openstack controller hosts.."
    sudo echo ${NAME} > /etc/hostname
  fi

  echo "[OSTACK] Done."
  do_reboot
}

do_reboot() {
  read -n1 -r -p "Reboot to apply all changes. Press ENTER to reboot!" ENTER

  if [[ $ENTER=\n ]]; then
    sudo reboot
  else
    echo "[OSTACK] This server need to reboot. Please reboot to apply all changes!"
    echo "[OSTACK] Finish."
  fi
}

config_hosts
