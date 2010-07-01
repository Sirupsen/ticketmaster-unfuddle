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

      project_properties = {
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
      }

      @testproject = TicketMaster::Provider::Unfuddle::Project.new(project_properties)
      @unfuddler_project = Unfuddler::Project.new(project_properties)

      @ticket_properties = {
        :assignee_id => nil, 
        :component_id => nil, 
        :created_at => "2010-06-16T07:28:04Z", 
        :description => "Hello World",
        :description_format => "markdown",
        :due_on => nil,
        :field1_value_id => nil,
        :field2_value_id => nil,
        :field3_value_id => nil,
        :hours_estimate_current => 0.0,
        :hours_estimate_initial => 0.0,
        :id => 169,
        :milestone_id => nil,
        :number => 112 ,
        :priority => "3",
        :project_id => 2,
        :reporter_id => 2,
        :resolution => nil,
        :resolution_description => nil,
        :resolution_description_format => "markdown",
        :severity_id => nil,
        :status => "new",
        :summary => "Test",
        :updated_at => "2010-06-16T07:28:04Z",
        :version_id => nil,
      }

      stub(Unfuddler::Project).find {[@unfuddler_project]}
      @unfuddle_project = TicketMaster::Provider::Unfuddle::Project

      stub(Unfuddler::Ticket).find {[Unfuddler::Ticket.new(@ticket_properties)]}
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
      should "load and regognize all" do
        project = @ticketmaster.projects.first
        assert_instance_of Array, project.tickets
        assert_instance_of Array, project.tickets(:all)
        assert_instance_of Array, project.tickets(169)

        assert_instance_of TicketMaster::Provider::Unfuddle::Ticket, project.tickets.first
      end
    end
  end
end
