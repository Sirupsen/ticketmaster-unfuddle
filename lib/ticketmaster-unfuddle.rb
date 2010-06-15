require 'unfuddler'
%w{project ticket}.each {|lib| require "provider/#{lib}"}
