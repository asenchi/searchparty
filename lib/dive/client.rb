module SearchParty
  class Client
    def initialize
      @@routes  = []
      @@results = {}
    end

    def routes
      @@routes
    end

    def results
      @@results
    end

    def create_route(route, services)
      start = Time.now
      SearchParty.log(:fn => :create_route, :route => "#{route}", :at => :start)
      unless routes.detect { |r| r.name == route }
        routes << Route.new(route, services)
      end
      SearchParty.log(:fn => :create_route, :route => "#{route}", :at => :finish, :elapsed => Time.now - start)
    end

    def search(route, msg={})
      payload = msg.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      start = Time.now
      SearchParty.log(:fn => :search, :route => route, :at => :start)
      search_route = @@routes.detect { |r| r.name == route } if payload 

      search_route.services.each do |svc|
        SearchParty.log(:fn => :search, :service => svc.class.to_s.downcase)
        begin
          if SearchParty.mocking? && !svc.is_a?(SearchParty::Failure) && !svc.nil?
            SearchParty.queried << { :route => route, :service => svc.class.to_s.downcase, :payload => payload }
            @@results[svc] << { :result_url => "https://failure.com/results", :results => ["test message 1", "test message 2"]}
          else
            @@results[svc] = svc.send(:send_query, payload)
          end
        rescue Exception => e
          SearchParty.log(:fn => :search, :service => svc.class.to_s.downcase, :error => e.class, :message => e.message)
          raise
        end
      end

      ParseResults.new(@@results)
    end
  end
end
