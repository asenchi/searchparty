module SearchParty
  module Service
    class Base
      def initialize(url)
        @url  = url
      end

      def search(query)
      end

      def http_post(url, payload, headers={}, &blk)
        retries = 0
        begin
          RestClient.post(url, payload, headers, &blk)
        rescue RestClient::ServerBrokeConnection => e
          retries += 1
          raise if retries >= 3
          SearchParty.log(:fn => :http_post, :at => :exception, :error => e.class, :retry => retries)
          retry
        rescue RestClient::RequestTimeout
          raise
        end
      end

      def http_get(url, headers={}, &blk)
        retries = 0
        begin
          RestClient.get(url, headers, &blk)
        rescue RestClient::ServerBrokeConnection => e
          retries += 1
          raise if retries >= 3
          SearchParty.log(:fn => :http_get, :at => :exception, :error => e.class, :retry => retries)
          retry
        rescue RestClient::RequestTimeout
          raise
        end
      end
    end
  end

  class ServiceFactory
    def self.create(url)
      svc_name = URI.parse(url).scheme
      if SearchParty.const_defined?(svc_name.capitalize)
        svc = SearchParty.const_get(svc_name.capitalize)
        svc.new(url)
      end
    end
  end
end
