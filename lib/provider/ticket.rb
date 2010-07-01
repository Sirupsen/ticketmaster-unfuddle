module TicketMaster::Provider
  module Unfuddle
    class Ticket < TicketMaster::Provider::Base::Project
      def self.find(*options)
        first = options.shift

        if first.is_a?(Hash)
          self.search(first).collect { |t| self.new t }
        end
      end

      def self.search(options, limit = 1000)
        project = Unfuddler::Project.find(options[:project_name])
        options[:project_name] = nil

        p project

        #project.tickets.each do |t|
        #  options.keys.reduce(true) do |memo, key|
        #    t.send(key) == options[key] and (limit -=1) >= 0
        #  end
        #end
      end
    end
  end
end
