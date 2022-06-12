read -p 'insert number of CPU cores: ' core_number
read -p 'insert allocated disk space (ie 10G): ' disk_space
read -p 'insert allocated ram memory (ie 2G): ' ram_memory 
read -p 'insert multipass virtual disk name: ' instance_name

multipass launch -v -c $core_number -d $disk_space -m $ram_memory -n $instance_name 

multipass exec $instance_name -- /bin/bash -c '
    sudo apt update
    read -p "Enter github email : " email
    echo "Using email $email"
    ssh-keygen -t rsa -b 4096 -C "$email"
    read -s -p "Enter github token for user $githubuser: " github_multipass_token
    read -p "Enter multipass instance name again: " instance_name
    curl -i -H "Authorization: token $github_multipass_token" --data "{\"title\":\"Multipass_$instance_name_`date +%Y%m%d%H%M%S`\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" https://api.github.com/user/keys
    cd
    curl -u gabelon:jjQDX9DRkZSJwMYTpcBQ -X POST -H "Content-Type: application/json" -d  "{\"label\":\"Multipass_$instance_name_`date +%Y%m%d%H%M%S`\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" https://api.bitbucket.org/2.0/users/gabelon/ssh-keys
    git clone git@github.com:gabeLon/dotfiles.git
    cd dotfiles/
    . install.sh ~ 
'

multipass shell $instance_name
