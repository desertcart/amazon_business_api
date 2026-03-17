# frozen_string_literal: true

module AmazonBusinessApi
  class TimeWindow
    class Deserializer < AmazonBusinessApi::Deserializer
      attribute :start_date, hash_attribute: :startDate
      attribute :end_date, hash_attribute: :endDate
    end
  end
end
