make symlinks
./fish_setup_for_amazon_linux_2.sh
git clone https://scm.l-r.tech/takeuchi/dotfiles-local.git ~/dotfiles-local
sudo yum install the_silver_searcher -y

cd ~/tmp
wget -P ~/tmp https://github.com/sharkdp/bat/releases/download/v0.19.0/bat-v0.19.0-x86_64-unknown-linux-gnu.tar.gz
tar xzvf ~/tmp/bat-v0.19.0-x86_64-unknown-linux-gnu.tar.gz
mv ~/tmp/bat-v0.19.0-x86_64-unknown-linux-gnu/bat ~/bin/bat
rm -rf ~/tmp/bat-v0.19.0-x86_64-unknown-linux-gnu.tar.gz ~/tmp/bat-v0.19.0-x86_64-unknown-linux-gnu
