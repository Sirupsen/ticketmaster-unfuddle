require 'helper'
require 'rr'

class TestTicketmasterUnfuddle < Test::Unit::TestCase
  context "TicketMaster::Provider::Unfuddle" do
    setup do
      @authentication = {
        :username    => "simon",
        :password   => "WT00op",
        :subdomain  => "ticketmaster"
      }
      
      @ticketmaster = TicketMaster.new(:unfuddle, @authentication)

      @testproject = TicketMaster::Provider::Unfuddle::Project.new({ 
        :account_id => 1,
        :archived => false,
        :assignee_on_resolve => "reporter",
        :backup_frequency => 0,
        :close_ticket_simultaneously_default => false,
        :created_at => "2010-05-20T17:51:57Z",
        :default_ticket_report_id => nil,
        :description => nil,
        :disk_usage => 0,
        :enable_time_tracking => true,
        :id => 2,
        :s3_access_key_id => nil,
        :s3_backup_enabled => false,
        :s3_bucket_name => nil,
        :short_name => "testproject",
        :theme => "blue",
        :ticket_field1_active => false,
        :ticket_field1_disposition => "text",
        :ticket_field1_title => "Field 1",
        :ticket_field2_active => false,
        :ticket_field2_disposition => "text",
        :ticket_field2_title => "Field 2",
        :ticket_field3_active => false,
        :ticket_field3_disposition => "text",
        :ticket_field3_title => "Field 3",
        :title => "Test",
        :updated_at => "2010-06-16T07:28:04Z" 
      })

      stub(Unfuddler::Project).find {[@testproject]}

      @unfuddle_project = TicketMaster::Provider::Unfuddle::Project
    end

    context "projects" do
      should "instantiate a new instance" do
        assert_instance_of TicketMaster, @ticketmaster
        assert_kind_of TicketMaster::Provider::Unfuddle, @ticketmaster
      end

      should "load" do
        assert_instance_of Array, @ticketmaster.projects
        assert_instance_of @unfuddle_project, @ticketmaster.projects.first
      end

      should "load project with id of 2" do
        assert_instance_of Array, @ticketmaster.projects(:id => 2)
        assert_instance_of @unfuddle_project, @ticketmaster.projects(:id => 2).first
        assert_equal 2, @ticketmaster.projects(:id => 2).first.id
      end
    end

    context "tickets" do
      should "load all" do
        stub(Unfuddler::Ticket).find(:all) {[Unfuddler::Ticket.new]}
        project = @ticketmaster.projects
        assert_instance_of Array, project.tickets
      end
    end

    #should "find projects with #project" do
    #  assert_instance_of @unfuddle_project, @ticketmaster
    #end
  end
end
