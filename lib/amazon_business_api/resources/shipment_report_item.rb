# frozen_string_literal: true

require_relative 'order_metadata'
require_relative 'shipment_metadata'
require_relative 'shipment_delivery_info'
require_relative 'address'

module AmazonBusinessApi
  class ShipmentReportItem < AmazonBusinessApi::Resource
    # https://docs.business.amazon.com/docs/reporting-api-v2025-06-09-reference
    # A single entry of the getShipmentReports `shipmentsReport[]` array.
    references_one :order_metadata, to: OrderMetadata
    references_one :shipment_metadata, to: ShipmentMetadata
    references_one :delivery_info, to: ShipmentDeliveryInfo
    # NOTE: uses Address (snake_case attrs) rather than PhysicalAddress, whose
    # resource attributes are camelCase and don't match its snake_case
    # deserializer (pre-existing bug in that class).
    references_one :shipping_address, to: Address
    attribute :purchase_order_number, type: LedgerSync::Type::String
    attribute :shipment_status, type: LedgerSync::Type::String
    # NOTE: `charges[]` is also present in the payload but omitted here — not
    # needed by current consumers (each charge is { type, amount }).
  end
end
