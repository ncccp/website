source_dir      = "source"    # source file directory
# Settings for Cloud9
server_host     = ENV['IP'] ||= '0.0.0.0'     # server bind address for preview serve
server_port     = ENV['PORT'] ||= "4000"      # port for preview server eg. localhost:4000

desc "preview the site in a web browser"
task :preview do
  raise "### You haven't set anything up yet. First run `rake install` to set up an Octopress theme." unless File.directory?(source_dir)
  puts "Starting to watch source with Jekyll and Compass. Starting Rack on port #{server_port}"
  system "compass compile --css-dir #{source_dir}/stylesheets"
  jekyllPid = Process.spawn("jekyll --auto")
  compassPid = Process.spawn("compass watch")
  rackupPid = Process.spawn("rackup --host #{server_host} --port #{server_port}")

  trap("INT") {
    [jekyllPid, compassPid, rackupPid].each { |pid| Process.kill(9, pid) rescue Errno::ESRCH }
    exit 0
  }

  [jekyllPid, compassPid, rackupPid].each { |pid| Process.wait(pid) }
end