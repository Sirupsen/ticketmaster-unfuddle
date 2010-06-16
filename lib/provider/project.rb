module TicketMasterMod
  module Unfuddle
    class Project < TicketMasterMod::Project
      class << self
        def find(query, options = {})
          Unfuddler.authenticate(options[:authentication].to_hash)
          projects = Unfuddler::Project.find
          formatted_projects = []

          unless projects.empty?
            projects.each do |project|
              formatted_projects << TicketMasterMod::Project.new({
                :name => project.short_name,
                :description => project.description,
                :system => "unfuddle",
                :authentication => options[:authentication],
                :id => project.id,
              })
            end
          end

          formatted_projects
        end

        def tickets(project_instance)
          Unfuddler.authenticate(project_instance.authentication.to_hash)
          project = Unfuddler::Project.find(project_instance.name)
          formatted_tickets = []

          unless project.tickets.empty?
            project.tickets.each do |ticket|
              formatted_tickets << TicketMasterMod::Ticket.new({
                :summary => ticket.summary,
                :id => ticket.number,
                :status => ticket.status,
                :description => ticket.description,

                :resolution => ticket.resolution,
                :resolution_description => ticket.resolution_description,

                :created_at => ticket.created_at,

                :system => "unfuddle",
                :ticket => ticket,
                :project => project_instance
              })
            end
          end

          formatted_tickets
        end
      end
    end
  end
end
