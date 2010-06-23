require 'helper'
require 'mocha'

class TestTicketmasterUnfuddle < Test::Unit::TestCase
  context "TicketMaster::Unfuddle" do
    setup do
      @authentication = {
        :account    => "John",
        :password   => "seekrit!!1!eleven!",
        :subdomain  => "ticketmaster"
      }
      
      @ticketmaster = TicketMaster.new(:unfuddle, @authentication)
    end

    should "instantiate a new instance" do
      assert_instance_of TicketMaster, @ticketmaster
      assert_kind_of TicketMaster::Provider::Unfuddle, @ticketmaster
    end

    should "load projects" do
      assert_instance_of Array, @ticketmaster.projects
      assert_instance_of TicketMaster::Provider::Unfuddle::Project, @ticketmaster.projects.first
    end
  end
end
