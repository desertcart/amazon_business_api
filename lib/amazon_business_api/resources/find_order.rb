# frozen_string_literal: true

require_relative 'order'

module AmazonBusinessApi
  class FindOrder < AmazonBusinessApi::Resource
    # https://developer-docs.amazon.com/amazon-business/docs/reporting-api-v1-reference-1

    attribute :order_id, type: LedgerSync::Type::String # Amazon auto-generated identifier for the order.
    references_many :orders, to: Order
  end
end
