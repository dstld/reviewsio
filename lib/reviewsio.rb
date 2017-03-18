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

    API_URL = "https://api.reviews.co.uk"
    base_uri API_URL

    def serializer
      self.class.serializer
    end

    def post(path, data)
      self.class.post(
        path,
        body: data
        )
    end

    def insert_review(line_item_params)
      post("/product/review/new", serializer.new(line_item_params).to_json)
    end

  end
end
