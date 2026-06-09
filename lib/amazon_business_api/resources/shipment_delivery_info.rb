# frozen_string_literal: true

module AmazonBusinessApi
  class ShipmentDeliveryInfo < AmazonBusinessApi::Resource
    # https://docs.business.amazon.com/docs/reporting-api-v2025-06-09-reference
    # Nested under each shipmentsReport[] entry as `deliveryInfo`.
    # NOTE: distinct from DeliveryInformation (Reporting API v1) — this one
    # uses `status` rather than `deliveryStatus`.
    attribute :expected_delivery_date, type: LedgerSync::Type::String
    attribute :status, type: LedgerSync::Type::String
  end
end
