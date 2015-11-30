require 'rake'

desc "Install our dotfiles into the required locations"
task :install do
  symlinks.each do |link, target|

    skip_all = false
    overwrite_all = false
    backup_all = false

    if File.exists?(link) || File.symlink?(link)
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{link}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        when 's' then next
        end
      end
      FileUtils.mv link, "#{link}.backup" if backup || backup_all
      FileUtils.rm_rf link if overwrite || overwrite_all
    end
    FileUtils.ln_s target, link unless skip_all
  end
end

desc "list all system dotfiles with there symlink targets"
task :list do
  symlinks.each do |link, target|
    puts "#{link} -> #{target}"
  end
end

def symlinks
  config = {}
  linkables = Dir.glob('**/symlinks/*')
  linkables.each do |linker|
    _, file_or_dir, *dirs, file = linker.split('/').reject{ |part| part == 'symlinks' }

    link = ".#{file_or_dir}"
    dirs and dirs.each do |dir|
      link += "/#{dir}"
    end
    link += "/#{file}" if file

    target = "#{FileUtils.pwd}/#{linker}"
    link = "#{ENV['HOME']}/#{link}"

    config[link] = target
  end
  config
end

task :install_oh_my_zsh do
  if File.exist?(File.join(ENV['HOME'], ".oh-my-zsh"))
    puts "found ~/.oh-my-zsh"
  else
    print "install oh-my-zsh? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing oh-my-zsh"
      system %Q{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
    when 'q'
      exit
    else
      puts "skipping oh-my-zsh, you will need to change ~/.zshrc"
    end
  end
end

task :uninstall do

  symlinks.each do |link, target|

    # Remove all symlinks created during installation
    if File.symlink?(link)
      puts "Removing #{link}"
      FileUtils.rm(link)
    end
    #
    # # Replace any backups made during installation
    # if File.exists?("#{ENV["HOME"]}/.#{file}.backup")
    #   `mv "$HOME/.#{file}.backup" "$HOME/.#{file}"`
    # end
  end
end

task :default => 'install'
