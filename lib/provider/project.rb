module TicketMaster::Provider
  module Unfuddle
    class Project < TicketMaster::Provider::Base::Project
      API = Unfuddler::Project
    end
  end
end
