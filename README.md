### Deploy Ubuntu Core To U Disk

Related Reference:<p>
[*Offical Information*](https://wiki.ubuntu.com/Core)<p>
[*Related Reference 1*](http://askubuntu.com/questions/67001/what-commands-are-needed-to-install-ubuntu-core)<p>
[*Related Reference 2*](http://unix.stackexchange.com/questions/56004/how-to-stop-update-grub-from-scanning-all-drives)<p>

Download Path:<p>
[*Download*](http://cdimage.ubuntu.com/ubuntu-base/releases/16.04/release/ubuntu-base-16.04-core-amd64.tar.gz)

##### Precondition
Platform: Ubuntu 16.04 64bit<p>
Hardware: 4G U Disk<p>

##### Procedure
+ Processed U Disk<p>
*PS: Suppose its path is /dev/sdb, and has only one partition.*<p>
`fdisk /dev/sdb`<p>
`mkfs.ext4 /dev/sdb1`<p>

+ Download Ubuntu Core Image<p>
*PS: Suppose the download folder is 'tmp' folder.*<p>

+ Run Shell Script<p>
*PS: Go into 'tmp' folder, copy 'deploy.sh' here and run it.*<p>
