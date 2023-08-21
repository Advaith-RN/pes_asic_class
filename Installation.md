# Installation of tools

Install Dependencies and assign a variable current_dir to your working directory 
```bash
sudo apt-get install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev git libexpat1-dev gtkwave -y
current_dir=$(pwd)
```
Create Directory
```bash
mkdir riscv_toolchain
cd riscv_toolchain
```
Download tar file and extract
```bash
wget "https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14.tar.gz"
tar -xvzf riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14.tar.gz
```
Add toolchain to path
```bash
export PATH=$current_dir/riscv_toolchain/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/bin:$PATH
```
Download SPIKE tool and dependencies
```bash
sudo apt-get install device-tree-compiler -y
git clone https://github.com/riscv/riscv-isa-sim.git
```
Configuring and installing spike
```bash
cd riscv-isa-sim/
mkdir build
cd build
```
This command runs the configure script present in the file
```bash
../configure --prefix=$current_dir/riscv_toolchain/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14
```
Make and install Spike
```bash
make
sudo make install  
```
Go back to the risc_v_toolchain directory and clone the risc V proxy kernel and bootloader
```bash
git clone https://github.com/riscv/riscv-pk.git
cd riscv-pk/
```
Make a build directory and run the configure file
```bash
mkdir build
cd build
../configure --prefix=$current_dir/riscv_toolchain/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14 --host=riscv64-unknown-elf
make -j 4
sudo make install
```
Add it to Path
```bash
export PATH=$current_dir/riscv_toolchain/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/riscv64-unknown-elf/bin:$PATH
```
Go back to the riscv main directory and clone into the iverilog repository
```bash
cd $current_dir/riscv_toolchain
git clone https://github.com/steveicarus/iverilog.git 
```
Switch to the v10 branch and pull from the repo again
```bash
cd iverilog/
git checkout --track -b v10-branch origin/v10-branch 
git pull 
```
Install Icarus iverilog 
```bash
chmod 777 autoconf.sh #chmod - command to change permissions ; 777 - owner,group,others - read,write,execute permission enabled
./autoconf.sh
./configure
make -j 4
sudo make install
```
Add to PATH and refresh the bashrc
```bash
echo 'export PATH=~/riscv_toolchain/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/bin:$PATH' >> ~/.bashrc
echo 'export PATH=~/riscv_toolchain/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/riscv64-unknown-elf/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```


