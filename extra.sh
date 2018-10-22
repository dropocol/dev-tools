
# https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes
# https://forums.docker.com/t/how-to-delete-cache/5753

#/var/lib/docker/
#/etc/docker/daemon.json
#sudo vi /lib/systemd/system/docker.service
#systemctl daemon-reload
#ps aux | grep -i docker | grep -v grep
#sudo service docker status
# docker rm $(docker ps --filter=status=exited --filter=status=created -q)



