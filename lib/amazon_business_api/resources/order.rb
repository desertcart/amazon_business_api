# frozen_string_literal: true

require_relative 'shipment'
require_relative 'charge'
require_relative 'line_item'

module AmazonBusinessApi
  class Order < AmazonBusinessApi::Resource
    # https://developer-docs.amazon.com/amazon-business/docs/reporting-api-v1-reference-1

    attribute :order_date, type: LedgerSync::Type::String # The date when the order was placed.
    attribute :order_id, type: LedgerSync::Type::String # Amazon auto-generated identifier for the order.
    attribute :purchase_order_number, type: LedgerSync::Type::String # The Purchase Order Number assigned to the order.
    attribute :order_quantity, type: LedgerSync::Type::Integer
    attribute :order_status, type: LedgerSync::Type::String # Probably one of: PENDING_APPROVAL PAYMENT_CONFIRMED PENDING_FULFILLMENT PENDING CANCELLED CLOSED
    attribute :last_order_approver_name, type: LedgerSync::Type::String
    references_one :buying_customer, to: BuyingCustomer # The requisitioner or buyer who placed the order.
    attribute :buyer_group_name, type: LedgerSync::Type::String
    attribute :business_order_info, type: LedgerSync::Type::Hash # Additional information provided at checkout.
    references_one :order_sub_total, to: Money # The principal amount on the order. This only includes the price and excludes shipping, taxes, or discounts.
    references_one :order_shipping_and_handling, to: Money # The total shipping charges on the order. This excludes shipment tax and discounts.
    references_one :order_promotion, to: Money # The total discount on the order. This includes discounts on items and shipping. We don't show shipping discounts separately for each individual order.
    references_one :order_tax, to: Money # The total taxes for the order.
    references_one :order_net_total, to: Money # The total amount charged for the order.
    references_many :line_items, to: LineItem
    references_many :shipments, to: Shipment
    references_many :charges, to: Charge
  end
end
