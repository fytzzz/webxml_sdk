# Webxml-sdk
require "#{File.dirname(__FILE__)}/webxml"
Dir["#{File.dirname(__FILE__)+'/webxml/*.rb'}"].sort.each {|file| require file }