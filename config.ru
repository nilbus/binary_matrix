require 'bundler/setup'
Bundler.require
require './app'
use Rack::Static, :urls => ['/stylesheets', '/javascripts'], :root => 'public'
run BinaryMatrix
