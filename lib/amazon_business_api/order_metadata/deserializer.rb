# frozen_string_literal: true

module AmazonBusinessApi
  class OrderMetadata
    class Deserializer < AmazonBusinessApi::Deserializer
      attribute :order_date, hash_attribute: :orderDate
      attribute :order_id, hash_attribute: :orderId
      attribute :region, hash_attribute: :region
    end
  end
end
