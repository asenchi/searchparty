module Dive
  class Route
    attr_accessor :name, :services

    def initialize(route, urls)
      @name = route
      @services = []

      urls.each do |url|
        svc = ServiceFactory.create(url)
        if svc.respond_to?("send_query")
          @services << svc
        end
      end
    end
  end
end
