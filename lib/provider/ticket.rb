module TicketMaster::Provider
  module Unfuddle
    class Ticket < TicketMaster::Provider::Base::Project
      API = Unfuddler::Ticket
    end
  end
end
