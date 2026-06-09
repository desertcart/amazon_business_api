# frozen_string_literal: true

module AmazonBusinessApi
  class OrderMetadata < AmazonBusinessApi::Resource
    # https://docs.business.amazon.com/docs/reporting-api-v2025-06-09-reference
    # Nested under each shipmentsReport[] entry as `orderMetadata`.
    attribute :order_date, type: LedgerSync::Type::String
    attribute :order_id, type: LedgerSync::Type::String
    attribute :region, type: LedgerSync::Type::String
  end
end
