if [ -z "$1" ]
  then
    echo "eg: flash.sh application.bin"
    exit
fi
echo "Creating file"
dd if=/dev/zero bs=1M count=4 of=./flash.bin
echo "Writing bootloader"
dd if=./bootloader.bin bs=1 count=$(stat -c%s ./bootloader.bin) seek=$((16#1000)) conv=notrunc of=./flash.bin
echo "Writing partitions"
dd if=./partitions.bin bs=1 count=$(stat -c%s ./partitions.bin) seek=$((16#8000)) conv=notrunc of=./flash.bin
echo "Finishing file"
dd if=$1 bs=1 count=$(stat -c%s $1) seek=$((16#10000)) conv=notrunc of=./flash.bin
echo "Finished file"