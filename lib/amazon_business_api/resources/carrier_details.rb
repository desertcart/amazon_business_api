# frozen_string_literal: true

module AmazonBusinessApi
  class CarrierDetails < AmazonBusinessApi::Resource
    attribute :localized_carrier_name, type: LedgerSync::Type::String
    attribute :carrier_tracking_id, type: LedgerSync::Type::String
  end
end
