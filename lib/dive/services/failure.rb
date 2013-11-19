module Dive
  class Failure < Service::Base
    def send_query(payload)
      raise "Failure"
    end

    def parse_results(results={})
      results
    end
  end
end
