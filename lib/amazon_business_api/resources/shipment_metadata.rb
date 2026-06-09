# frozen_string_literal: true

module AmazonBusinessApi
  class ShipmentMetadata < AmazonBusinessApi::Resource
    # https://docs.business.amazon.com/docs/reporting-api-v2025-06-09-reference
    # Nested under each shipmentsReport[] entry as `shipmentMetadata`.
    attribute :shipment_id, type: LedgerSync::Type::String
    attribute :shipment_date, type: LedgerSync::Type::String
  end
end
