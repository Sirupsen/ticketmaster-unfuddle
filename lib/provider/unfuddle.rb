module TicketMaster::Provider
  module Unfuddle
    include TicketMaster::Provider::Base

    PROJECT_API = Unfuddler::Project
    TICKET_API = Unfuddler::Ticket

    def self.new(auth = {})
      TicketMaster.new(:unfuddle, auth)
    end

    def authorize(authentication = {})
      @authentication ||= TicketMaster::Authenticator.new(authentication)
      Unfuddler.authenticate(@authentication.to_hash)
    end

    def projects(*options)
      authorize
      super(*options)
    end

    def project(*options)
      authorize
      super(*options)
    end

    def tickets
      authorize
      super(*options)
    end

    def ticket
      authorize
      super(*options)
    end
  end
end
