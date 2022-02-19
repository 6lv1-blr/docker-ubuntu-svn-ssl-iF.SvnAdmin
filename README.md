# docker-ubuntu-svn-ssl-iF.SvnAdmin
a docker container, base on latest ubuntu docker (20.04), with subversion (svn-server) 1.13, with https support (no certificat management) and interface for management iF.SvnAdmin 



download and extract in ./build/iF.SvnAdmin/     https://svnadmin.insanefactory.com/

http://sourceforge.net/projects/ifsvnadmin/files/svnadmin-1.6.2.zip/download


I use docker container with jwilder/nginx-proxy with the jrcs/letsencrypt-nginx-proxy-companion/ to manage letsencrypt certificat.
https://registry.hub.docker.com/r/jwilder/nginx-proxy/
https://registry.hub.docker.com/r/jrcs/letsencrypt-nginx-proxy-companion/

inspire from https://github.com/MarvAmBass/docker-subversion but limited to svn 1.9 so I decided to restart from 0 to be able to make update

for configuration exemple, follow the screen capture from this webpage
https://kb.synology.com/en-my/DSM/tutorial/How_to_launch_an_SVN_server_based_on_Docker_on_your_Synology_NAS

https://kb.synology.com/_images/autogen/How_to_launch_an_SVN_server_based_on_Docker_on_your_Synology_NAS/3.png




#Install tips
//Copy everything in one folder
cd build
//svn-server will be the name of the image from wich you can launch several containers if needed
docker build -t svn-server .
