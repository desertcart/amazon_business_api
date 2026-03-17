# frozen_string_literal: true

require_relative '../time_window/deserializer'

module AmazonBusinessApi
  class PackageMilestone
    class Deserializer < AmazonBusinessApi::Deserializer
      attribute :milestone_type, hash_attribute: :milestoneType
      references_one :milestone_window,
                     deserializer: TimeWindow::Deserializer,
                     hash_attribute: :milestoneWindow
    end
  end
end
