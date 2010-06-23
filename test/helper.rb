require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'rr'

require 'ticketmaster'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'ticketmaster-unfuddle'

class Test::Unit::TestCase
  include RR::Adapters::TestUnit
end
