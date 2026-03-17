# frozen_string_literal: true

require_relative '../delivery_information/deserializer'
require_relative '../money/deserializer'

module AmazonBusinessApi
  class Shipment
    class Deserializer < AmazonBusinessApi::Deserializer
      attribute :shipment_id, hash_attribute: :shipmentId
      attribute :shipment_date, hash_attribute: :shipmentDate
      attribute :shipment_status, hash_attribute: :shipmentStatus
      attribute :carrier_tracking, hash_attribute: :carrierTracking
      references_one :delivery_information, deserializer: DeliveryInformation::Deserializer, hash_attribute: :deliveryInformation
      attribute :shipment_quantity, hash_attribute: :shipmentQuantity
      references_one :shipment_sub_total, deserializer: Money::Deserializer, hash_attribute: :shipmentSubTotal
      references_one :shipment_shipping_and_handling, deserializer: Money::Deserializer, hash_attribute: :shipmentShippingAndHandling
      references_one :shipment_promotion, deserializer: Money::Deserializer, hash_attribute: :shipmentPromotion
      references_one :shipment_tax, deserializer: Money::Deserializer, hash_attribute: :shipmentTax
      references_one :shipment_net_total, deserializer: Money::Deserializer, hash_attribute: :shipmentNetTotal
      attribute :carrier_name, hash_attribute: :carrierName
    end
  end
end
