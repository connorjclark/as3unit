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

cur_dir_name = File.basename(Dir.getwd)
if cur_dir_name != "flash-unit-release"
  Dir.chdir "flash-unit-release"
end

test_classes = Dir["../test/**/*.as"].map { |path|
  path.gsub(/..\/test\/(.*).as/, '\1').gsub("/", ".");
}
includes = "#{test_classes.map { |e| "-includes=#{e}" }.join " "}"
run_command "mxmlc -sp src ../test -static-link-runtime-shared-libraries=true src/com/hoten/flashunit/Main.as -output flash_unit.swf -debug=true #{includes}"

js = "function getClassesToTest(){return \"#{test_classes.join " "}\";}"
File.write("js/flash_unit.js", js)

# open webpage

link = "file:///#{Dir.pwd}/index.html"
if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
  system "start #{link}"
elsif RbConfig::CONFIG['host_os'] =~ /darwin/
  system "open #{link}"
elsif RbConfig::CONFIG['host_os'] =~ /linux|bsd/
  system "xdg-open #{link}"
end
