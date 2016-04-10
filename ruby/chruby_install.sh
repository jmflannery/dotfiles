chruby_version="0.3.9"
ruby_install_version="0.6.0"
home_dir="/Users/jack"
dir="sources"
source_dir="${home_dir}/${dir}"

if [ ! -d "$source_dir" ]; then
  mkdir -p $source_dir
fi

cd $source_dir

# chruby
wget -O chruby-${chruby_version}.tar.gz https://github.com/postmodern/chruby/archive/v${chruby_version}.tar.gz
tar -xzvf chruby-${chruby_version}.tar.gz
cd chruby-${chruby_version} && sudo make install

cd $source_dir
rm chruby-${chruby_version}.tar.gz

# ruby-install
wget -O ruby-install-${ruby_install_version}.tar.gz https://github.com/postmodern/ruby-install/archive/v${ruby_install_version}.tar.gz
tar -xzvf ruby-install-${ruby_install_version}.tar.gz
cd ruby-install-${ruby_install_version} && sudo make install

cd $source_dir
rm ruby-install-${ruby_install_version}.tar.gz
