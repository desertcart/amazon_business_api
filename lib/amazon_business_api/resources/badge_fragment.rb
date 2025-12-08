# frozen_string_literal: true

require_relative '../types/array'

module AmazonBusinessApi
  class BadgeFragment < AmazonBusinessApi::Resource
    attribute :title, type: LedgerSync::Type::String
    attribute :message, type: LedgerSync::Type::String
    attribute :link, type: LedgerSync::Type::String
    attribute :type, type: LedgerSync::Type::String
    attribute :fragments, type: AmazonBusinessApi::Type::Array
  end
end
