# frozen_string_literal: true

require_relative 'shipment_report_item'

module AmazonBusinessApi
  class ShipmentReport < AmazonBusinessApi::Resource
    # https://docs.business.amazon.com/docs/reporting-api-v2025-06-09-reference
    # getShipmentReports — request params double as the resource attributes
    # (mirrors the Reconciliation pattern), and the response collection is
    # deserialized into `shipments_report`.
    attribute :order_start_date, type: LedgerSync::Type::String
    attribute :order_end_date, type: LedgerSync::Type::String
    # Single order id, or comma-separated ids (max 30). NOTE: batching multiple
    # ids in one call is unverified — current consumer queries one order.
    attribute :order_ids, type: LedgerSync::Type::String
    attribute :region, type: LedgerSync::Type::String
    attribute :shipment_statuses, type: LedgerSync::Type::String
    attribute :next_page_token, type: LedgerSync::Type::String
    attribute :size, type: LedgerSync::Type::Integer

    references_many :shipments_report, to: ShipmentReportItem
  end
end
