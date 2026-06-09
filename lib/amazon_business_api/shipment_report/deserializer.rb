# frozen_string_literal: true

require_relative '../shipment_report_item/deserializer'

module AmazonBusinessApi
  class ShipmentReport
    class Deserializer < AmazonBusinessApi::Deserializer
      references_many :shipments_report, deserializer: ShipmentReportItem::Deserializer,
                                         hash_attribute: :shipmentsReport
      attribute :next_page_token, hash_attribute: :nextPageToken
      attribute :size, hash_attribute: :size
    end
  end
end
