#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), 'vendor/plugins/icy_ruby/lib/icy_ruby.rb')
require 'yaml'
require "erb"
RAILS_ROOT = "#{File.dirname(__FILE__)}/.." unless defined?(RAILS_ROOT)
IcyRuby.start