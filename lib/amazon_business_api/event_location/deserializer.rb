# frozen_string_literal: true

module AmazonBusinessApi
  class EventLocation
    class Deserializer < AmazonBusinessApi::Deserializer
      attribute :city
      attribute :state
      attribute :country
    end
  end
end
