# Grab webcam picture on failed login

To take pictures from the webcam upon failed login attempts you need a webcam
and ```ffmpeg``` installed.

1. Copy the ```grabpicture``` script to e.g. ```/usr/local/bin/grabpicture```.
1. Modify the ```/etc/pam.d/common-auth``` file to include a call to
   ```grabpicture``` when a wrong password is given on login or `sudo`.

Example:

```
auth    [default=ignore]    pam_exec.so     seteuid     /usr/local/bin/grabpicture
```

The `grabpicture` script uses ffmpeg to store three webcam pictures from the
first video device:

```sh
#!/bin/bash
ts=`date +%s`
ffmpeg -f video4linux2 -s vga -i /dev/video0 -vframes 3
/tmp/failed-login-attempt-$ts.%01d.jpg
exit 0
```

You may need to adjust the video device or directory to put the images into.
