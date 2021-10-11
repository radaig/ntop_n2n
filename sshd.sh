#!/bin/bash
if [[ -z "$NPC_TOKEN" ]]; then
  echo "Please set 'NPC_TOKEN'"
  exit 2
fi
if [[ -z "$SSH_PASSWORD" ]]; then
  echo "Please set 'SSH_PASSWORD' for user: $USER"
  exit 3
fi
wget -q https://github.com/ehang-io/nps/releases/download/v0.26.10/linux_386_client.tar.gz
tar -zxvf linux_386_client.tar.gz
chmod +x ./npc
echo -e "$SSH_PASSWORD\n$SSH_PASSWORD" | sudo passwd "$USER"
./npc -server=42.192.5.73:8024 -vkey="$NPC_TOKEN" -type=tcp &
sleep 10
