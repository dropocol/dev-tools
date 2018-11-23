
sudo apt-get update
sudo apt-get upgrade

sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev

sudo apt install -y vim

# Update expired Keys
sudo apt-key list | \
 grep "expired: " | \
 sed -ne 's|pub .*/\([^ ]*\) .*|\1|gp' | \
 xargs -n1 sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys


sudo apt-get install -y curl


#------------------------------------------------------
if [ ! -d ~/tools ]; then
    mkdir ~/tools
fi



#------------------------------------------------------
if [ ! -d ~/zk-scripts ]; then
    mkdir ~/zk-scripts
fi



#------------------------------------------------------
echo "installing git"
sudo apt-get install -y git
echo "done"



#------------------------------------------------------
echo "installing ssh"
sudo apt install -y openssh-server
sudo ufw allow 22
echo "done"



#------------------------------------------------------
if [ ! -d ~/.rbenv ]; then
    echo "installing rbenv"
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
    . ~/.bashrc
    echo "installing Ruby 2.5.1"
    rbenv install 2.5.1
    echo "done"
else 
   echo "rbenv is already installed"
fi



#------------------------------------------------------
if [ ! -d ~/.pyenv ]; then
    echo "installing pyenv"
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc
    . ~/.bashrc
    echo "installing Python 2.5.1"
    pyenv install 3.6.6
    pyenv install 2.7.15
    mkdir -p "$(rbenv root)"/plugins
    echo "done"
else 
   echo "pyenv is already installed"
fi



#------------------------------------------------------
if [ ! -d ~/.nvm ]; then
    echo "installing nvm"
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
    export NVM_DIR="${XDG_CONFIG_HOME/:-$HOME/.}nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    . ~/.nvm/nvm.sh
    . ~/.bashrc
    echo "installing node.js"
    nvm install node
    nvm install --lts
    echo "done"
else 
   echo "nvm is already installed"
fi



#------------------------------------------------------
echo "installing gmv"
if [ ! -d ~/.gvm ]; then
    sudo apt-get install curl mercurial make binutils bison gcc
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    . ~/.bashrc
    . ~/.gvm/scripts/gvm
    gvm install go1.4 -B
    gvm use go1.4
    export GOROOT_BOOTSTRAP=$GOROOT
    gvm install go1.10 -B
    gvm use go1.10 --default
    echo "done"
else 
   echo "gvm is already installed"
fi



#------------------------------------------------------
echo "installing mongodb"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org



#------------------------------------------------------
echo "installing redis"
sudo apt-get install redis-server



#------------------------------------------------------
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code # or code-insiders



#------------------------------------------------------
echo "installing robo3T"
robo3TDir="/opt/robo3t-1.2.1-linux-x86_64-3e50a65"
if [ ! -d $robo3TDir ]; then
    cd ~/tools
    wget https://download.robomongo.org/1.2.1/linux/robo3t-1.2.1-linux-x86_64-3e50a65.tar.gz
    sudo tar -zxvf robo3t-1.2.1-linux-x86_64-3e50a65.tar.gz -C /opt
    sudo ln -s /opt/robo3t-1.2.1-linux-x86_64-3e50a65/bin/robo3t /usr/bin/robo3t
    rm robo3t-1.2.1-linux-x86_64-3e50a65.tar.gz
else
    echo "robo3T already installed"
fi


#------------------------------------------------------
echo "installing docker"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
sudo service docker stop
sudo echo "{ \"graph\" : \"/home/zeeshankhan/docker\"  }" | sudo tee --append /etc/docker/daemon.json > /dev/null
sudo ystemctl daemon-reload
echo "done"



#------------------------------------------------------
echo "installing bash aliases from dev-profile"
cd ~/zk-scripts
if [ ! -d ~/zk-scripts/dev-profile ]; then
    git clone https://github.com/dropocol/dev-profile.git
    cd ~/zk-scripts/dev-profile
else
    cd ~/zk-scripts/dev-profile
    git stash
    git stash clear
    git pull
fi

if ! grep -F "source ~/zk-scripts/dev-profile/.dev-profile" ~/.bashrc ; then
 echo 'source ~/zk-scripts/dev-profile/.dev-profile' >> ~/.bashrc
fi
. ~/.bashrc


#------------------------------------------------------

cd ~/tools/
echo "done"