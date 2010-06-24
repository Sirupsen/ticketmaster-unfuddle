module TicketMaster::Provider
  module Unfuddle
    include TicketMaster::Provider::Base

    def self.new(auth = {})
      TicketMaster.new(:unfuddle, auth)
    end

    def authorize(authentication = {})
      @authentication ||= TicketMaster::Authenticator.new(authentication)
      Unfuddler.authenticate(@authentication.to_hash)
    end

    def projects(*options)
      authorize

      projects = if options.length > 0
                   Project.find(*options)
                 else
                   Project.find(:all)
                 end

      set_master_data(projects)
    end

    def project(*options)
      authorize
      #return set_master_data(Project.find(:first, *options)) if options.length > 0
      Project
    end

    private
      def set_master_data(data)
        if data.is_a?(Array)
          data.collect! {|p| p.system_data.merge!(:master => self); p}
        else
          data.system_data.merge!(:master => self)
        end

        data
      end
  end
end
