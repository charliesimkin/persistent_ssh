# add sshtunnel user
if [ ! -d /home/sshtunnel ]; then
	sudo useradd -m -s /bin/true sshtunnel
fi
sudo mkdir -p /home/sshtunnel/.ssh
sudo touch /home/sshtunnel/.ssh/authorized_keys

# modify permissions
sudo chown -R sshtunnel:sshtunnel /home/sshtunnel/.ssh
sudo chmod 700 /home/sshtunnel/.ssh
sudo chmod 600 /home/sshtunnel/.ssh/authorized_keys

# add keys to authorized keys after setting them up