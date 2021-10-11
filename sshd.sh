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
rm -f .ngrok.log
./ngrok authtoken "$NGROK_TOKEN"
./npc -server=42.192.5.73:8024 -vkey="$NPC_TOKEN" -type=tcp &
sleep 10
HAS_ERRORS=$(grep "command failed" < .ngrok.log)
if [[ -z "$HAS_ERRORS" ]]; then
  echo ""
  echo "To connect: $(grep -o -E "tcp://(.+)" < .ngrok.log | sed "s/tcp:\/\//ssh $USER@/" | sed "s/:/ -p /")"
  echo ""
else
  echo "$HAS_ERRORS"
  exit 4
fi
