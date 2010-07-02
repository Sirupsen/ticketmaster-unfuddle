module TicketMaster::Provider
  module Unfuddle
    class Ticket < TicketMaster::Provider::Base::Project
      def self.find(*options)
        first = options.shift

        if first.nil? or first == :all
          tickets = []
          Unfuddler::Project.find.each do |p|
            tickets << p.tickets
          end
          tickets.collect { |t| self.new t }
        elsif first.is_a?(Fixnum)
          second = options.shift

          if second.is_a?(Fixnum)
            project = Unfuddler::Project.find.each do |p|
                        return project if project.id == options[:project_id]
                      end
            self.new project.tickets(:id => first).first
          end
          # TODO
          #elsif second.is_a?(HasH)
          #end
        elsif first == :first
          self.new self.search(options.shift, 1).first
        elsif first.is_a?(Hash)
          self.search(first).collect { |t| self.new t }
        end
      end

      def self.search(options, limit = 1000)
        project = nil

        Unfuddler::Project.find.each do |pject|
          project = pject if pject.id == options[:project_id]
        end

        options.delete(:project_id)

        project.tickets.each do |t|
          options.keys.reduce(true) do |memo, key|
            t.send(key) == options[key] and (limit -=1) >= 0
          end
        end
      end
    end
  end
end
