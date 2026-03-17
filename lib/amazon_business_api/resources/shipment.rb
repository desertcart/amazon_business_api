# frozen_string_literal: true

require_relative 'money'
require_relative 'delivery_information'

module AmazonBusinessApi
  class Shipment < AmazonBusinessApi::Resource
    # https://developer-docs.amazon.com/amazon-business/docs/reporting-api-v1-reference-1
    attribute :shipment_id, type: LedgerSync::Type::String
    attribute :shipment_date, type: LedgerSync::Type::String
    attribute :shipment_status, type: LedgerSync::Type::String # maybe SHIPPED
    attribute :carrier_tracking, type: LedgerSync::Type::String
    references_one :delivery_information, to: DeliveryInformation
    attribute :shipment_quantity, type: LedgerSync::Type::Integer
    references_one :shipment_sub_total, to: Money
    references_one :shipment_shipping_and_handling, to: Money
    references_one :shipment_promotion, to: Money
    references_one :shipment_tax, to: Money
    references_one :shipment_net_total, to: Money
    attribute :carrier_name, type: LedgerSync::Type::String
  end
end
