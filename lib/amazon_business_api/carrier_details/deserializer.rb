# frozen_string_literal: true

module AmazonBusinessApi
  class CarrierDetails
    class Deserializer < AmazonBusinessApi::Deserializer
      attribute :localized_carrier_name, hash_attribute: :localizedCarrierName
      attribute :carrier_tracking_id, hash_attribute: :carrierTrackingId
    end
  end
end
