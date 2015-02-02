# TODO
# => make this cross platform

def run_command(command)
  fixed_command = command
    .gsub(%r"([^ /])/", '\1\\')
    .gsub('//', '/')
  puts "cmd: #{fixed_command}"
  puts `#{fixed_command}`
  puts "\n"
end

base_dir = Dir.pwd
build_dir = "#{base_dir}/target"

puts "Cleaning ..."
run_command "rmdir /S /Q #{build_dir}"
run_command "mkdir #{build_dir}"

# build swf

puts "Building swf"
test_classes = Dir["test/**/*.as"].map { |path|
  path.gsub(/test\/(.*).as/, '\1').gsub("/", ".");
}
includes = "#{test_classes.map { |e| "-includes=#{e}" }.join " "}"
run_command "mxmlc -compiler.source-path=#{base_dir}/src -static-link-runtime-shared-libraries=true #{base_dir}/src/com/hoten/flashunit/Main.as -output #{build_dir}/flash_unit.swf -debug=true -sp #{base_dir}/test #{includes}"
run_command "copy #{base_dir}/bin/expressInstall.swf target"

# build webpage

puts "Building webpage"
run_command "copy #{base_dir}/index.html #{build_dir}"
run_command "xcopy #{base_dir}/js #{build_dir}/js //E //I"
"com.hoten.flashunit.FlashUnitTest"

File.write("#{build_dir}/js/flash_unit.js", "function getClassesToTest(){return \"#{test_classes.join " "}\";}")

# open webpage

link = "file:///#{build_dir}/index.html"
if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
  system "start #{link}"
elsif RbConfig::CONFIG['host_os'] =~ /darwin/
  system "open #{link}"
elsif RbConfig::CONFIG['host_os'] =~ /linux|bsd/
  system "xdg-open #{link}"
end
