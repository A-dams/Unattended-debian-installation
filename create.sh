isoStock=/home/isofiles
dirIso=/home
iso=debian-9.4.0-i386-netinst
preseedFile=preseed.cfg


#Mount and copy the iso on a file

udevil mount $iso
cp -rT $dirIso/$iso $isoStock

#Adding Preseed file to Initrd

chmod +w -R $isoStock/install.386/
gunzip $isoStock/install.386/initrd.gz
echo $preseedFile | cpio -H newc -o -A -F $isoStock/install.386/initrd
gzip $isoStock/install.386/initrd
chmod -w -R $isoStock/install.386

#Fix md5sum.txt

cd $isoStock
md5sum `find -follow -type f` > md5sum.txt
cd ..

#Creating new iso

genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat \
-no-emul-boot -boot-load-size 4 -boot-ingo-table \
-o pressed-$iso $isoStock

xorriso -as mkisofs -o preseed-$iso \
        -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin \
        -c isolinux/boot.cat -b isolinux/isolinux.bin -no-emul-boot \
        -boot-load-size 4 -boot-info-table $isoStock

chmod +w -R $isoStock
rm -r $isoStock
udevil unmount /media/$iso
