isoStock=/home/isofiles
dirIso=/home
iso=debian-9.4.0-i386-netinst.iso
preseedFile=preseed.cfg
preseedDir=/home/$preseedFile


#Mount and copy the iso on a file

rm -rf $isoStock

#Mount part

mkdir -p $isoStock/loop
mount -o nouuid $dirIso/$iso $isoStock/loop

if [ "$?" -eq 0 ]; then
  echo "Coudn't mount iso on loop directory";
  exit 1;
fi

#Copy part

mkdir -p $isoStock/isoCp
rsync -a -H --exclude=TRANS.TBL $isoStock/loop $isoStock/isoCp
umount $isoStock/loop

#Initrd

mkdir -p $isoStock/irmod
cd $isoStock/irmod
gzip -d < $isoStock/isoCp/install.386/initrd.gz | cpio --extract --make-directories --no-absolute-filenames
cp $preseedDir $isoStock/irmod/$preseedFile
find . | cpio -H newc --create | gzip -9 > $isoStock/isoCp/install.386/initrd.gz

#Fix md5sum

md5sum `find $isoStock/isoCp/ -follow -type f` > $isoStock/isoCp/md5sum.txt

#Create iso

genisoimage -o $preseedDir -r -J -no-emul-boot -boot-load-size 4 -boot-info-table -input-charset utf-8 isolinux/isolinux.bin -c isolinux/boot.cat $isoStock/isoCp/

