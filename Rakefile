require 'rake'

desc "Hook our dotfiles into system-standard positions."
task :install do
  linkables = Dir.glob('*/**{.symlink}')
  inner_linkables = Dir.glob('*{.link-content}')

  skip_all = false
  overwrite_all = false
  backup_all = false

  inner_linkables.each do |directory|
    inner_links = Dir.glob("#{directory}/**/*")
    inner_links.each do |inner_link|
      source = "#{`pwd`.chomp}/#{inner_link}".chomp
      path = inner_link.gsub('.link-content', '')
      target = "#{ENV["HOME"]}/.#{path}"
      if File.file?(source) && !File.exists?(target)
        `ln -s "#{source}" "#{target}"` if !skip_all
      elsif File.directory?(source) && !File.exists?(target)
        FileUtils.mkdir(target)
      end
    end
  end

  linkables.each do |linkable|
    overwrite = false
    backup = false

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        when 's' then next
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
    end
    `ln -s "$PWD/#{linkable}" "#{target}"` if !skip_all
  end
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

task :install_oh_my_zsh_custom do
  linkables = Dir.glob('zsh/oh-my-zsh/custom/**')
  target = "#{ENV["HOME"]}/.oh-my-zsh/custom"
  linkables.each do |linkable|
    puts `ln -s "$PWD/#{linkable}" "#{target}/#{linkable.split("/").last}"`
  end
end

task :uninstall do

  Dir.glob('**/*.symlink').each do |linkable|

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    # Remove all symlinks created during installation
    if File.symlink?(target)
      FileUtils.rm(target)
    end

    # Replace any backups made during installation
    if File.exists?("#{ENV["HOME"]}/.#{file}.backup")
      `mv "$HOME/.#{file}.backup" "$HOME/.#{file}"`
    end

  end
end

task :default => 'install'
