# frozen_string_literal: true

module AmazonBusinessApi
  class TimeWindow < AmazonBusinessApi::Resource
    attribute :start_date, type: LedgerSync::Type::String
    attribute :end_date, type: LedgerSync::Type::String
  end
end
