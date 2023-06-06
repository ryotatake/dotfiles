make symlinks
git clone https://scm.l-r.tech/takeuchi/dotfiles-local.git ~/dotfiles-local

git clone https://scm.l-r.tech/takeuchi/lrms-update-er-template.git ~/lrms-update-er-template
cd ~/lrms-update-er-template
sudo make install

sudo yum install the_silver_searcher -y

mkdir -p ~/tmp
mkdir -p ~/bin

cd ~/tmp
wget -P ~/tmp https://github.com/sharkdp/bat/releases/download/v0.19.0/bat-v0.19.0-x86_64-unknown-linux-gnu.tar.gz
tar xzvf ~/tmp/bat-v0.19.0-x86_64-unknown-linux-gnu.tar.gz
mv ~/tmp/bat-v0.19.0-x86_64-unknown-linux-gnu/bat ~/bin/bat
rm -rf ~/tmp/bat-v0.19.0-x86_64-unknown-linux-gnu*

wget -P ~/tmp https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
tar xzvf ~/tmp/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
mv ~/tmp/ripgrep-13.0.0-x86_64-unknown-linux-musl/rg ~/bin/rg
rm -rf ~/tmp/ripgrep-13.0.0-x86_64-unknown-linux-musl*

wget -P ~/tmp https://github.com/dandavison/delta/releases/download/0.12.1/delta-0.12.1-x86_64-unknown-linux-musl.tar.gz
tar xzvf ~/tmp/delta-0.12.1-x86_64-unknown-linux-musl.tar.gz
mv ~/tmp/delta-0.12.1-x86_64-unknown-linux-musl/delta ~/bin/delta
rm -rf ~/tmp/delta-*
