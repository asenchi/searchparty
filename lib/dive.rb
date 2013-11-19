require "rest_client"

require "dive/client"
require "dive/route"
require "dive/service"
require "dive/version"

require "dive/services/failure"
require "dive/services/splunk"


module Dive
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
    logger.call({:lib => :dive}.merge(data), &blk)
  end
end
