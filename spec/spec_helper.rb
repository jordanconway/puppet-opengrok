require 'simplecov'
require 'simplecov-console'

SimpleCov.start do
  add_filter '/spec'
  add_filter '/vendor'
  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console
  ])
end

require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'

include RspecPuppetFacts

base_dir = File.dirname(File.expand_path(__FILE__))

RSpec.configure do |c|
  c.hiera_config = File.expand_path(File.join(__FILE__, '../fixtures/hiera.yaml'))
  c.module_path     = File.join(base_dir, 'fixtures', 'modules')
  c.manifest_dir    = File.join(base_dir, 'fixtures', 'manifests')
  c.manifest        = File.join(base_dir, 'fixtures', 'manifests', 'site.pp')
  c.environmentpath = File.join(Dir.pwd, 'spec')
  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end
