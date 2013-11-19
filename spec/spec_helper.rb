require 'scrolls'
require 'stringio'

Scrolls.stream = StringIO.new

$: << File.expand_path("../../lib", __FILE__)
require 'searchparty'

module TestLogger
  def self.log(data, &blk)
    Scrolls.log(data, &blk)
  end
end

SearchParty.instrument_with(TestLogger.method(:log))

RSpec.configure do |c|
  c.before(:all) do
    SearchParty.mock!
  end

  c.before(:each) do
    SearchParty.reset!
  end
end
