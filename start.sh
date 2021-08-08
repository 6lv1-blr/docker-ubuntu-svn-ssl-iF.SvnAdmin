#!/bin/sh
SVN_ROOT_PATH=/volume1/docker/SvnRepository
REPO_PATH="$SVN_ROOT_PATH"
DAV_SVN_CONF=/volume1/docker/SvnDav_svn

mkdir -p "$REPO_PATH" "$DAV_SVN_CONF"
touch "$DAV_SVN_CONF"/dav_svn.authz "$DAV_SVN_CONF"/dav_svn.passwd
chmod 666 "$DAV_SVN_CONF"/dav_svn.authz "$DAV_SVN_CONF"/dav_svn.passwd

docker run \
-d \
-v "$REPO_PATH":/var/local/svn \
-v "$DAV_SVN_CONF":/etc/apache2/dav_svn/ \
-p 10080:80 \
-p 10443:443 \
--name ubuntu-svn-if-ssl svn-server-ubuntu \
