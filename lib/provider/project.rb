module TicketMaster::Provider
  module Unfuddle
    class Project < TicketMaster::Provider::Base::Project
      attr_accessor :prefix_options

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
        @system = :unfuddle
        @system_data = {}

        first = options.shift
        super(first)
      end

    end
  end
end
