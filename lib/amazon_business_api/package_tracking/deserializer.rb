# frozen_string_literal: true

require_relative '../time_window/deserializer'
require_relative '../carrier_details/deserializer'
require_relative '../package_tracking_event/deserializer'
require_relative '../package_milestone/deserializer'

module AmazonBusinessApi
  class PackageTracking
    class Deserializer < AmazonBusinessApi::Deserializer
      attribute :tracking_status, hash_attribute: :trackingStatus
      attribute :localized_delivery_promise,
                hash_attribute: :localizedDeliveryPromise
      references_one :delivery_window,
                     deserializer: TimeWindow::Deserializer,
                     hash_attribute: :deliveryWindow
      references_one :carrier_details,
                     deserializer: CarrierDetails::Deserializer,
                     hash_attribute: :carrierDetails
      references_many :package_tracking_events,
                      deserializer: PackageTrackingEvent::Deserializer,
                      hash_attribute: :packageTrackingEvents
      references_many :package_milestones,
                      deserializer: PackageMilestone::Deserializer,
                      hash_attribute: :packageMilestones
    end
  end
end
