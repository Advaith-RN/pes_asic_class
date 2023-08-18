Install Dependencies and assign a variable current_dir to your working directory 
```
sudo apt-get install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev git libexpat1-dev gtkwave -y
current_dir=$(pwd)
```
Create Directory
```
mkdir riscv_toolchain
cd riscv_toolchain
```
Download tar file and extract
```
wget "https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14.tar.gz"
tar -xvzf riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14.tar.gz
```
Add toolchain to path
```
export PATH=$current_dir/riscv_toolchain/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/bin:$PATH
```
Download SPIKE tool and dependencies
```
sudo apt-get install device-tree-compiler -y
git clone https://github.com/riscv/riscv-isa-sim.git
```
Configuring and installing spike
```
cd riscv-isa-sim/
mkdir build
cd build
```
This command runs the configure script present in the file
```
../configure --prefix=$current_dir/riscv_toolchain/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14
```
Make and install Spike
```
make
sudo make install  
```
Go back to the risc_v_toolchain directory and clone the risc V proxy kernel and bootloader
```
git clone https://github.com/riscv/riscv-pk.git
cd riscv-pk/
```
Make a build directory and run the configure file
```
mkdir build
cd build
../configure --prefix=$current_dir/riscv_toolchain/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14 --host=riscv64-unknown-elf
```
b

