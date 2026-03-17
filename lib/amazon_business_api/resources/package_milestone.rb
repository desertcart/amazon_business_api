# frozen_string_literal: true

require_relative 'time_window'

module AmazonBusinessApi
  class PackageMilestone < AmazonBusinessApi::Resource
    attribute :milestone_type, type: LedgerSync::Type::String
    references_one :milestone_window, to: TimeWindow
  end
end
