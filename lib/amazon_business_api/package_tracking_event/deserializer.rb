# frozen_string_literal: true

require_relative '../event_location/deserializer'

module AmazonBusinessApi
  class PackageTrackingEvent
    class Deserializer < AmazonBusinessApi::Deserializer
      attribute :localized_description, hash_attribute: :localizedDescription
      attribute :localized_event_date, hash_attribute: :localizedEventDate
      attribute :localized_event_time, hash_attribute: :localizedEventTime
      references_one :event_location,
                     deserializer: EventLocation::Deserializer,
                     hash_attribute: :eventLocation
    end
  end
end
