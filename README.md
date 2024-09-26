# About
These scripts can be used to enable a persistent reverse ssh connection from a host to a relay.
The host box initiates a reverse ssh connection to the relay box, and a user can access the host through the relay.

# Dependencies
must have openssh-server and autossh installed

# Usage
## run host_setup.sh on the host machine

It will 
	1. add an ssh key pair in /etc/sshtunnel
	2. create a script to run a systemd service in /etc/systemd/system/sshtunnel.service
	3. start the sshtunnel service
	4. Display the public key generated in step one.  This should be copied and kept for the relay setup

## run relay_setup.sh on the relay machine

It will 
	1. make a user named sshtunnel
	2. create an empty authorized_keys file in /home/sshtunnel/.ssh/authorized_keys

## Add the public key generated on the host to the relay

edit the file found in /home/sshtunnel/.ssh/authorized_keys and paste in the public key you copied while setting up the host
