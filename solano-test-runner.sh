#!/usr/bin/env ruby

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options]"

  opts.on("-d PREFIX", String, "Prefix") do |v|
    options[:prefix] = v
  end
end.parse!

classes = ARGV.map{|f| File.basename(f).split('.')[0]}
cmd = "("
cmd += "cd #{options[:prefix]} && " if options[:prefix]
cmd += "./gradlew testRelease --tests #{classes.join(",")}"
cmd += ")"

puts cmd

system(cmd)
