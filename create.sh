dest=/toast
iso=debian-9.4.0-i386-netinst.iso
isoStock=/home/isofiles
dirIso=/home

#Mount and copy iso fil

mount $dirIso/$iso $isoStock/stock
cp -a $isoStock/stock $isoStock/isoCp/stock
umount $isoStock/stock

#Change initrd

chmod +w -R $isoStock/isoCp/stock/install.386/
gunzip $isoStock/isoCp/stock/install.386/initrd.gz
echo preseed.cfg | cpio -H newc -o -A -F $isoStock/isoCp/stock/install.386/initrd
gzip $isoStock/isoCp/stock/install.386/initrd
chmod -w -R $isoStock/isoCp/stock/install.386/

#Fix md5sum

cd $isoStock/isoCp/stock
md5sum `find -follow -type f` > md5sum.txt
cd ../../

#Creating Iso

genisoimage -r -J -b $isoStock/isoCp/stock/isolinux/isolinux.bin -c $isoStock/isoCp/stockisolinux/boot.cat -no-emul-boot -load-size 4 -boot-info-table -o -preseed-$iso $isoStock
