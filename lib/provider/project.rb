module TicketMaster::Provider
  module Unfuddle
    class Project < TicketMaster::Provider::Base::Project
      def self.find(*options)
        first = options.shift

        if first.nil? or first == :all
          Unfuddler::Project.find.collect { |p| self.new p }
        elsif first == :first
          self.new self.search(options.shift || {}, 1).first
        elsif first.is_a?(Hash)
          self.search(first).collect { |p| self.new p }
        end
      end

      def self.search(options = {}, limit = 1000)
        projects = Unfuddler::Project.find

        projects.each do |p|
          options.keys.reduce(true) do |memo, key|
            p.send(key) == options[key] and (limit -= 1) >= 0
          end
        end
      end

      def initialize(*options)
        first = options.shift
        @system = :unfuddle
        @system_data = {}

        if first.is_a?(Unfuddler::Project)
          @system_data[:client] = first
          super(first.to_hash)
        else
          super(first)
        end
      end

      def tickets(*options)
        if options.length == 0
          Ticket.find({:project_name => self.short_name})
        else
          puts "OHAI"
        end
      end
    end
  end
end
