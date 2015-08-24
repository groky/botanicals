Dir[File.expand_path(File.join(File.dirname(__FILE__),'..','shop','**','*.rb'))].each { |f| require f }

require 'rspec/mocks'
