# frozen_string_literal: true

module AmazonBusinessApi
  class ShipmentMetadata
    class Deserializer < AmazonBusinessApi::Deserializer
      attribute :shipment_id, hash_attribute: :shipmentId
      attribute :shipment_date, hash_attribute: :shipmentDate
    end
  end
end
