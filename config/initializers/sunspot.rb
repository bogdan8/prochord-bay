require "sunspot/queue/sidekiq"
backend = Sunspot::Queue::Sidekiq::Backend.new
Sunspot.session = Sunspot::Queue::SessionProxy.new(Sunspot.session, backend)

module Sunspot
  module Type
    class TimeType < AbstractType
      def indexed_name(name) #:nodoc:
        "#{name}_dt"
      end
    end
    register TimeType
  end
end
