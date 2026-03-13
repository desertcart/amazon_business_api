# frozen_string_literal: true

module AmazonBusinessApi
  class EventLocation < AmazonBusinessApi::Resource
    attribute :city, type: LedgerSync::Type::String
    attribute :state, type: LedgerSync::Type::String
    attribute :country, type: LedgerSync::Type::String
  end
end
