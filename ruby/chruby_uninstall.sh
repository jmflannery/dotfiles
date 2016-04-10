chruby_version="0.3.9"
ruby_install_version="0.6.0"
source_dir="/Users/jack/sources"

cd $source_dir
cd chruby-${chruby_version} && sudo make uninstall

cd $source_dir
cd ruby-install-${ruby_install_version} && sudo make uninstall

cd $source_dir
rm -rf chruby-${chruby_version}
rm -rf ruby-install-${ruby_install_version}
