# docker-ubuntu-svn-ssl-iF.SvnAdmin
a docker container, base on latest ubuntu docker (20.04), with subversion (svn-server) 1.13, with https support (no certificat management) and interface for management iF.SvnAdmin 

I use docker container with jwilder/nginx-proxy with the jrcs/letsencrypt-nginx-proxy-companion/ to manage letsencrypt certificat.
https://registry.hub.docker.com/r/jwilder/nginx-proxy/
https://registry.hub.docker.com/r/jrcs/letsencrypt-nginx-proxy-companion/

inspire from https://github.com/MarvAmBass/docker-subversion but limited to svn 1.9 so I decided to restart from 0 to be able to make update




