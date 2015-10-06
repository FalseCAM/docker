docker run -p 4422:22 -p 4480:80 -d --hostname git -v /srv/git:/repos -v /srv/svn:/svn-repos --name git falsecam/git
