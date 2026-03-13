# frozen_string_literal: true

require_relative 'event_location'

module AmazonBusinessApi
  class PackageTrackingEvent < AmazonBusinessApi::Resource
    attribute :localized_description, type: LedgerSync::Type::String
    attribute :localized_event_date, type: LedgerSync::Type::String
    attribute :localized_event_time, type: LedgerSync::Type::String
    references_one :event_location, to: EventLocation
  end
end
