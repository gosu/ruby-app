RVM_RUBY         = "ruby-2.3.8"
INTERNAL_VERSION = "2.3.0"
RUBY_DYLIB       = "libruby.#{INTERNAL_VERSION}.dylib"
RUBY_DYLIB_ID    = "@executable_path/../Frameworks/#{RUBY_DYLIB}"
TARGET_ROOT      = "UniversalRuby"
SOURCE_ROOT      = "#{ENV['HOME']}/.rvm/rubies/#{RVM_RUBY}"
GEM_ROOT         = "#{ENV['HOME']}/.rvm/gems/#{RVM_RUBY}/gems"
LIB_KILLLIST     = %w(README irb rake* rdoc* *ubygems* readline* tcltk* tk* tcltklib* rss* *-darwin*)
GEMS             = %w(gosu opengl)
GEMS_WITH_FLAGS  = "#{GEMS.join(' ')} -- --enable-static-homebrew-dependencies"

CURRENT_PLATFORM = `uname -m`.chomp

def merge_lib source_file, target_file
  sh "install_name_tool -change #{SOURCE_ROOT}/lib/#{RUBY_DYLIB} #{RUBY_DYLIB_ID} #{source_file}"
  if File.exist? target_file then
    sh "lipo #{source_file} #{target_file} -create -output #{target_file}"
  else
    sh "cp #{source_file} #{target_file}"
  end
end

task :rebuild_ruby_for_current_platform do
  mkdir_p "#{TARGET_ROOT}/include"
  mkdir_p "#{TARGET_ROOT}/lib"
  
  # Let RVM install the correct Ruby
  sh "env RVM_RUBY=#{RVM_RUBY} RVM_GEMS='#{GEMS_WITH_FLAGS}' " +
     "    bash #{TARGET_ROOT}/install_rvm_ruby.sh"
end

task :merge_current_platform_into_universal_ruby => :rebuild_ruby_for_current_platform do
  # Copy headers
  sh "cp -R #{SOURCE_ROOT}/include/ruby*/* #{TARGET_ROOT}/include/"
  # Copy rbconfig
  sh "cp #{TARGET_ROOT}/rbconfig.rb #{TARGET_ROOT}/lib/rbconfig.rb"
  # Rename platform-specific folder so the Xcode project will find it
  sh "mv #{TARGET_ROOT}/include/*-darwin* #{TARGET_ROOT}/include/#{CURRENT_PLATFORM}"
  
  # Copy Ruby libraries
  sh "cp -R #{SOURCE_ROOT}/lib/ruby/#{INTERNAL_VERSION}/* #{TARGET_ROOT}/lib"
  # Merge libruby with existing platforms
  # (TODO: This will bork the installation in rvm. Should avoid this by using a temporary file...)
  source_file = "#{SOURCE_ROOT}/lib/#{RUBY_DYLIB}"
  target_file = "#{TARGET_ROOT}/#{RUBY_DYLIB}"
  sh "install_name_tool -id #{RUBY_DYLIB_ID} #{source_file}"
  merge_lib source_file, target_file
  
  # Merge binary libraries
  Dir["#{SOURCE_ROOT}/lib/ruby/#{INTERNAL_VERSION}/*-darwin*/**/*.bundle"].each do |source_file|
    target_file = source_file.dup
    target_file["#{SOURCE_ROOT}/lib/ruby/#{INTERNAL_VERSION}/"] = ""
    target_file[/^[^\/]*\//] = ""
    target_file = "#{TARGET_ROOT}/lib/#{target_file}"
    mkdir_p File.dirname(target_file)
    merge_lib source_file, target_file
  end
  
  # Merge gems
  GEMS.each do |gem_name|
    gem_name = gem_name.split(" ").first # strip --pre flag
    gem_lib = Dir["#{GEM_ROOT}/#{gem_name}-*/lib"].first
    Dir["#{gem_lib}/**/*.{rb,frag}"].each do |ruby_file|
      target_file = ruby_file.dup
      target_file[gem_lib] = "#{TARGET_ROOT}/lib"
      mkdir_p File.dirname(target_file)
      sh "cp #{ruby_file} #{target_file}"
    end

    Dir["#{gem_lib}/**/*.bundle"].each do |ext_file|
      target_file = ext_file.dup
      target_file[gem_lib] = "#{TARGET_ROOT}/lib"
      mkdir_p File.dirname(target_file)
      merge_lib ext_file, target_file
    end
  end

  LIB_KILLLIST.each do |item|
    sh "rm -rf #{TARGET_ROOT}/lib/#{item}"
  end
end

task :default => :merge_current_platform_into_universal_ruby

task :clean do
  sh "rm -rf #{TARGET_ROOT}/#{RUBY_DYLIB}"
  sh "rm -rf #{TARGET_ROOT}/lib/*"
  sh "rm -rf #{TARGET_ROOT}/include/*"
end
