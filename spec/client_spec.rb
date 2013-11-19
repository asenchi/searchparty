require "spec_helper"

describe Dive::Client do
  subject { described_class.new }
  let(:failure_svc) { "failure://X:X@failure.com" }
  let(:splunk_svc) { "splunk://user:pass@splunk.githubapp.com" }

  describe "#routes" do
    it "has zero routes configured by default" do
      subject.routes.should be_empty
    end
  end

  describe "#create_route" do
    describe "specify query" do
      before do
        subject.create_route("test_route", [failure_svc, splunk_svc])
      end

      it "should register a route with base class" do
        subject.routes.should_not be_empty
      end

      it "should create a route" do
        subject.routes.first.name.should == "test_route"
      end

      it "should have a splunk service initiated" do
        subject.routes.first.services.first.class.should == Dive::Failure
      end
    end
  end
end
