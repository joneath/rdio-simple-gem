require 'spec_helper'

describe "Rdio::SimpleRdio" do
  let(:consumer) { ["key", "secret"] }
  let(:access_token) { "my_key" }

  describe ".new" do
    it "should take an consumer key, secret pair" do
      rdio = Rdio::SimpleRdio.new(consumer)

      rdio.consumer.should == consumer
    end

    it "should optionally take a user access token" do
      rdio = Rdio::SimpleRdio.new(consumer)
      rdio.token.should be_nil

      rdio = Rdio::SimpleRdio.new(consumer, access_token)
      rdio.token.should == access_token
    end
  end

  describe "#call" do
    let(:rdio) { Rdio::SimpleRdio.new(consumer) }
    let(:search_response) {
      <<-JSON
        {
          "status": "ok",
          "result": {
            "results": []
          }
        }
      JSON
    }

    it "should require a method" do
      expect {
        rdio.call()
      }.to raise_error
    end

    it "should make a request to the Rdio API for the given method" do
      stub_request(:post, "http://api.rdio.com/1/").with(:body => {"method"=>"search"}).to_return(:status => 200, :body => search_response)

      rdio.call("search")

      WebMock.should have_requested(:post, "http://api.rdio.com/1/").with { |req| req.body == "method=search" }
    end

    describe "when given request params" do
      it "should include the params in the API request" do
        stub_request(:post, "http://api.rdio.com/1/").with(:body => {"method"=>"search", "query"=>"Avicii", "types"=>"songs"}).to_return(:status => 200, :body => search_response)

        rdio.call("search", :query => "Avicii", :types => "songs")

        WebMock.should have_requested(:post, "http://api.rdio.com/1/").with { |req| req.body == "query=Avicii&types=songs&method=search" }
      end
    end
  end
end
