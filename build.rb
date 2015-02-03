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

build_dir = "flash-unit-release"

puts "Cleaning ..."
run_command "rmdir /S /Q #{build_dir}"
run_command "mkdir #{build_dir}"

run_command "xcopy src #{build_dir}/src //E //I"
run_command "xcopy dist #{build_dir}/ //E //I"
run_command "copy README.md #{build_dir}"
run_command "copy \"swfobject - LICENSE.md\" #{build_dir}"

run_command "ruby #{build_dir}/test.rb"
