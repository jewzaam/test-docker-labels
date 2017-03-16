Why do I want to do this?  I need to know what the repolist was at the time of build.  Instead of having that command in this test I opted for a simple file.  Why write to a file and not just shell out to `yum repolist -v` directly?  I like the idea of having the file on the filesystem of the image as well.  Your needs may be different.

# Build

```
# mount ./ as /hostfs and pass build arg for test #6
sudo docker build -v `pwd`/:/hostfs --build-arg TEST6=works -t jewzaam/test-docker-labels .
```

# Results

```
# grab the test labels only.  requires jq
sudo docker inspect jewzaam/test-docker-labels | jq .[].Config.Labels | grep '"test'
```

# Summary

* You cannot set a label from the contents of an image at build time.
* You can pass build args to set a label.
* If you want to set a label from the image contents you have to inject it as a build arg.

# Image contents into label example

```
# initial build, gets the content available for a second build.
sudo docker build -t jewzaam/test-docker-labels .
# file test.out is now written to root of image
sudo docker build --build-arg TEST6="`sudo docker run -it --rm jewzaam/test-docker-labels cat test.out`" -t jewzaam/test-docker-labels .
# verify
sudo docker inspect jewzaam/test-docker-labels | jq .[].Config.Labels.test6
```

Result should be content of the file written by the docker build:
```
"I was here\r"
```

## ALTERNATIVE
You could write to a file inside the image to a volume mounted from the host then not have to do `docker run` to get it.
