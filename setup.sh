# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo Updating Package Index
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential

echo Ruby Version Manager (RVM)
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

echo Installing Ruby
rvm install 1.9.3
rvm use 1.9.3 --default

echo Installing Bundler
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler -N >/dev/null 2>&1

install Git git
install SQLite sqlite3 libsqlite3-dev
install memcached memcached
install Redis redis-server
install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev
install 'ExecJS runtime' nodejs
install Nginx nginx
install ImageMagick imagemagick
install Monit monit
install 'OpenJDK Runtime Env 7' openjdk-7-jre-headless

# update language to UTF-8
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

echo 'Done'
