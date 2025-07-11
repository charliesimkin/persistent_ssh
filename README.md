# About
These scripts can be used to enable a persistent reverse ssh connection from a host to a relay.
The host box initiates a reverse ssh connection to the relay box, and a user can access the host through the relay.

# Dependencies
must have openssh-server and autossh installed

# Usage
## download and edit the host_setup.sh file
only need to edit the four parameters at the top of the file
## run host_setup.sh on the host machine

It will 
1. add an ssh key pair in /etc/sshtunnel
2. create a script to run a systemd service in /etc/systemd/system/sshtunnel.service
3. start the sshtunnel service
4. Display the public key generated in step one.  This should be copied and kept for the relay setup

## run relay_setup.sh on the relay machine

to use curl try somethig like the following
```bash
curl -o- https://raw.githubusercontent.com/charliesimkin/persistent_ssh/refs/heads/strange/relay_setup.sh | bash
```
It will 
1. make a user named sshtunnel
2. create an empty authorized_keys file in /home/sshtunnel/.ssh/authorized_keys

## Add the public key generated on the host to the relay

open the authorized keys file on the relay machine
```bash
relay-machine $ sudo nano /home/sshtunnel/.ssh/authorized_keys
```
paste in the public key you copied while setting up the host

## Access the host machine from the relay machine
To access the host machine use the following ssh parameters
```
Hostname localhost
Port [reverse port you entered while editing host_setup.sh]
```
