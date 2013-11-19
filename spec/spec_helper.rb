require 'scrolls'
require 'stringio'

Scrolls.stream = StringIO.new

$: << File.expand_path("../../lib", __FILE__)
require 'dive'

module TestLogger
  def self.log(data, &blk)
    Scrolls.log(data, &blk)
  end
end

Dive.instrument_with(TestLogger.method(:log))

RSpec.configure do |c|
  c.before(:all) do
    Dive.mock!
  end

  c.before(:each) do
    Dive.reset!
  end
end
