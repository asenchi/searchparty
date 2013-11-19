require "rest_client"

require "searchparty/client"
require "searchparty/route"
require "searchparty/service"
require "searchparty/version"

require "searchparty/services/failure"
require "searchparty/services/splunk"


module SearchParty
  def self.instrument_with(logger)
    @logger = logger
  end

  def self.mock!
    @mock = true
  end

  def self.mocking?
    !!@mock
  end

  def self.queried
    @queried ||= []
  end

  def self.reset!
    @queried = []
  end

  def self.logger
    @logger || STDOUT.method(:puts)
  end

  def self.log(data, &blk)
    logger.call({:lib => :searchparty}.merge(data), &blk)
  end
end
