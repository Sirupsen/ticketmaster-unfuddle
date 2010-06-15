module TicketMasterMod
  module Unfuddle
    class Ticket
      class << self
        def create(ticket)
          Unfuddler.authenticate(ticket.project.authentication.to_hash)
          project = Unfuddler::Project.find(ticket.project.name)

          new_ticket = {}
          ticket.to_hash.each_pair do |key, value|
            new_ticket[key] = value if [:summary, :priority, :description].include?(key.to_sym)
            new_ticket[key] = value.to_s if value.is_a?(Integer)
          end

          project.ticket.create(new_ticket)
        end

        def save(ticket)
          Unfuddler.authenticate(ticket.project.authentication.to_hash)
          project = Unfuddler::Project.find(ticket.project.name)
          unfuddle_ticket = project.tickets(:number => ticket.id).first # First because it always returns an array

          # DRY this up!
          status = right_status(ticket.status)
          unfuddle_ticket.status = status if status
          unfuddle_ticket.description = ticket.description
          unfuddle_ticket.summary = ticket.summary

          unfuddle_ticket.save
        end

        def close(ticket, resolution)
          Unfuddler.authenticate(ticket.project.authentication.to_hash)
          project = Unfuddler::Project.find(ticket.project.name)

          ticket = project.tickets(:number => ticket.id).first # First because it always returns an array
          ticket.close!(resolution)
        end

        def right_status(status)
          case status
          when :in_progress
            "accepted"
          when :resolved
            "resolved"
          when :reopen
            "reopen"
          else
            nil
          end
        end
      end
    end
  end
end
