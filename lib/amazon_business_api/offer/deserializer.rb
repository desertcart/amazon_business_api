# frozen_string_literal: true

require_relative '../merchant/deserializer'
require_relative '../condition/deserializer'
require_relative '../quantity_limits/deserializer'
require_relative '../quantity_price_tier/deserializer'
require_relative '../price/deserializer'
require_relative '../buying_restriction/deserializer'
require_relative '../tax_exclusive_price/deserializer'
require_relative '../badge/deserializer'

module AmazonBusinessApi
  class Offer
    class Deserializer < AmazonBusinessApi::Deserializer
      attribute :availability
      attribute :buying_guidance, hash_attribute: :buyingGuidance
      attribute :fulfillment_type, hash_attribute: :fulfillmentType
      attribute :offer_id, hash_attribute: :offerId
      attribute :product_condition, hash_attribute: :productCondition
      attribute :product_condition_note, hash_attribute: :productConditionNote
      attribute :delivery_information, hash_attribute: :deliveryInformation
      references_one :merchant, deserializer: Merchant::Deserializer
      references_one :price, deserializer: Price::Deserializer
      references_one :list_price, deserializer: Price::Deserializer, hash_attribute: :listPrice
      # references_many :shippingOptions, deserializer: ShippingOption::Deserializer
      references_one :condition, deserializer: Condition::Deserializer
      references_one :quantity_limits, deserializer: QuantityLimits::Deserializer, hash_attribute: :quantityLimits
      references_many :quantity_price_tiers, deserializer: QuantityPriceTier::Deserializer, hash_attribute: 'quantityPrice.quantityPriceTiers'
      references_one :tax_exclusive_price, deserializer: TaxExclusivePrice::Deserializer, hash_attribute: :taxExclusivePrice
      references_many :badges, deserializer: Badge::Deserializer
      references_many :buying_restrictions, deserializer: BuyingRestriction::Deserializer, hash_attribute: :buyingRestrictions
    end
  end
end
