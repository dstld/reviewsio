require "reviewsio/version"
require "httparty"

module ReviewsIO
  class Client
    include HTTParty
    format :json

    class << self
      attr_accessor :store
      attr_accessor :api_key
      attr_accessor :serializer
    end

    attr_accessor :last_response

    API_URL = "https://api.reviews.co.uk"
    base_uri API_URL

    def initialize
      @default_params = default_params
    end

    def serializer
      self.class.serializer
    end

    def default_params
      {
        store: self.class.store,
        api_key: self.class.api_key
      }
    end

    def post(path, data)
      self.class.post(
        path,
        body: @default_params.merge(data)
        )
    end

    def insert_review(line_item_params)
      @last_response = post("/product/review/new", serializer.new(line_item_params).as_json)
    end

    def last_response_success?
      @last_response && @last_response["success"]
    end
  end
end
