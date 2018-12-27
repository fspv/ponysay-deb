== How to build

Setup your PPA repo and GPG key.

Change DEBEMAIL and PPA in upload.sh.

Run it with 3 params like this:
```
./upload.sh 3.0.2 1 ""
```

First param is release version from here https://github.com/erkin/ponysay/releases

Second is build number

Leave third param empty or put `bash` there to debug build
