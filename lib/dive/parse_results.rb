module Dive
  class ParseResult
    def initialize(results={})
      @results = results

      @results.each do |svc, result|
        svc.send(:parse_results, result)
      end
    end
  end
end
