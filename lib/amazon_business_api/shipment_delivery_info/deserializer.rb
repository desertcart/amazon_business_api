# frozen_string_literal: true

module AmazonBusinessApi
  class ShipmentDeliveryInfo
    class Deserializer < AmazonBusinessApi::Deserializer
      attribute :expected_delivery_date, hash_attribute: :expectedDeliveryDate
      attribute :status, hash_attribute: :status
    end
  end
end
