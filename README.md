### Deploy Ubuntu Core To U Disk

Related Reference:<p>
[*Offical Information*](https://wiki.ubuntu.com/Core)

Download Path:<p>
[*Download*](http://cdimage.ubuntu.com/ubuntu-core/releases/)

##### Precondition
Platform: Ubuntu 14.04 64bit<p>
Hardware: 16G U Disk<p>

##### Procedure
+ Processed U Disk<p>
*PS: Suppose its path is /dev/sda, and has only one partition.*<p>
`fdisk /dev/sda`<p>
`mkfs.ext4 /dev/sda1`<p>

+ Download Ubuntu Core Image<p>
*PS: Suppose the download folder is 'tmp' folder.*<p>

+ Run Shell Script<p>
*PS: Go into 'tmp' folder, copy 'deploy.sh' here and run it.*<p>

##### Notice
*I'm not very clear about Grub program's behavior, so when everything's done, and I put the U disk into a PC, it will halt at the beginning, base on the screen's output, I edited some files under the U disk's '/boot/grub/' folder.*<p>
