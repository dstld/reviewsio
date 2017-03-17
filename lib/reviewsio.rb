require "reviewsio/version"
require "httparty"

module Reviewsio
  class Client
    include HTTParty
    format :json

    class << self
      attr_accessor :store
      attr_accessor :api_key
      attr_accessor :serializer
    end

    API_URL = "https://api.reviews.co.uk"

    def serializer
      self.class.serializer
    end

    def post(path, data)
      self.class.post(
        path,
        body: data
        )
    end

    def insert_review(line_item)
      post("/product/review/new", serializer.new(line_item))
    end

  end
end
