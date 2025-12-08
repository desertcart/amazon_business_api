# frozen_string_literal: true

require_relative 'merchant'
require_relative 'price'
require_relative 'shipping_option'
require_relative 'condition'
require_relative 'quantity_limits'
require_relative 'quantity_price_tier'
require_relative 'buying_restriction'
require_relative 'tax_exclusive_price'
require_relative 'badge'
require_relative '../types/array'

module AmazonBusinessApi
  class Offer < AmazonBusinessApi::Resource
    # https://developer-docs.amazon.com/amazon-business/docs/product-search-api-v1-reference#offer
    attribute :availability, type: LedgerSync::Type::String
    attribute :buying_guidance, type: LedgerSync::Type::String # enum: PREFERRED NEGOTIATED RESTRICTED BLOCKED NONE UNKNOWN
    attribute :fulfillment_type, type: LedgerSync::Type::String # enum: AMAZON_FULFILLMENT MERCHANT_FULFILLMENT OTHER
    attribute :offer_id, type: LedgerSync::Type::String
    attribute :product_condition, type: LedgerSync::Type::String
    attribute :product_condition_note, type: LedgerSync::Type::String
    attribute :delivery_information, type: LedgerSync::Type::String
    references_one :merchant, to: Merchant
    references_one :price, to: Price
    references_one :list_price, to: Price
    references_many :shipping_options, to: ShippingOption
    references_one :condition, to: Condition
    references_one :quantity_limits, to: QuantityLimits
    references_many :quantity_price_tiers, to: QuantityPriceTier
    references_one :tax_exclusive_price, to: TaxExclusivePrice
    references_many :badges, to: Badge
    references_many :buying_restrictions, to: BuyingRestriction
  end
end
