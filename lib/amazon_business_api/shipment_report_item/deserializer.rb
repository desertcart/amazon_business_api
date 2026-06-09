# frozen_string_literal: true

require_relative '../order_metadata/deserializer'
require_relative '../shipment_metadata/deserializer'
require_relative '../shipment_delivery_info/deserializer'
require_relative '../address/deserializer'

module AmazonBusinessApi
  class ShipmentReportItem
    class Deserializer < AmazonBusinessApi::Deserializer
      references_one :order_metadata, deserializer: OrderMetadata::Deserializer,
                                      hash_attribute: :orderMetadata
      references_one :shipment_metadata, deserializer: ShipmentMetadata::Deserializer,
                                         hash_attribute: :shipmentMetadata
      references_one :delivery_info, deserializer: ShipmentDeliveryInfo::Deserializer,
                                     hash_attribute: :deliveryInfo
      references_one :shipping_address, deserializer: Address::Deserializer,
                                        hash_attribute: :shippingAddress
      attribute :purchase_order_number, hash_attribute: :purchaseOrderNumber
      attribute :shipment_status, hash_attribute: :shipmentStatus
    end
  end
end
