read -p 'insert number of CPU cores: ' core_number
read -p 'insert allocated disk space (ie 10G): ' disk_space
read -p 'insert allocated ram memory (ie 2G): ' ram_memory 
read -p 'insert multipass virtual disk name: ' disk_name

multipass launch -v -c $core_number -d $disk_space -m $ram_memory -n $disk_name

multipass shell $disk_name
