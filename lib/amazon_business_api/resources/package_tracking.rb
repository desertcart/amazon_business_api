# frozen_string_literal: true

require_relative 'time_window'
require_relative 'carrier_details'
require_relative 'package_tracking_event'
require_relative 'package_milestone'

module AmazonBusinessApi
  class PackageTracking < AmazonBusinessApi::Resource
    attribute :order_id, type: LedgerSync::Type::String
    attribute :shipment_id, type: LedgerSync::Type::String
    attribute :package_id, type: LedgerSync::Type::String
    attribute :region, type: LedgerSync::Type::String
    attribute :tracking_status, type: LedgerSync::Type::String
    attribute :localized_delivery_promise, type: LedgerSync::Type::String
    references_one :delivery_window, to: TimeWindow
    references_one :carrier_details, to: CarrierDetails
    references_many :package_tracking_events, to: PackageTrackingEvent
    references_many :package_milestones, to: PackageMilestone
  end
end
