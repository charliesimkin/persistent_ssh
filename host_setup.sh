#parameters
    relay_name=mac.macbuntu.io
    relay_port=8929
    reverse_port=4567
    local_port=22

sudo apt install autossh
# create ssh keypair in /etc/sshtunnel
if [ ! -f /etc/sshtunnel/id_ssh.pub ]; then
    sudo mkdir -p /etc/sshtunnel
    sudo ssh-keygen -t ed25519 -qN "" -f /etc/sshtunnel/id_ssh
fi

# create sshtunnel.service file
sudo rm -rf /etc/systemd/system/sshtunnel.service
sudo cat << EOF >> sshtunnel.service
[Unit]
Description=Service to maintain an ssh reverse tunnel
Wants=network-online.target
After=network-online.target
StartLimitIntervalSec=0

[Service]
Type=simple
ExecStart=/usr/bin/autossh -M 0 -N \\
    -R $reverse_port:localhost:$local_port \\
    -i /etc/sshtunnel/id_ssh \\
    -o ServerAliveInterval=30 \\
    -o ServerAliveCountMax=3 \\
    -o StrictHostKeyChecking=no \\
    sshtunnel@$relay_name -p $relay_port
Restart=always
RestartSec=60

[Install]
WantedBy=multi-user.target
EOF
sudo chown root sshtunnel.service
sudo mv sshtunnel.service /etc/systemd/system/sshtunnel.service

# Start the service
sudo systemctl daemon-reload
sudo systemctl enable --now sshtunnel
sudo systemctl restart sshtunnel
# View the ssh public key generated earlier
echo 
echo "Copy the following into the relay machine /home/sshtunnel/.ssh/authorized keys file"
echo 
cat /etc/sshtunnel/id_ssh.pub
echo 
echo

