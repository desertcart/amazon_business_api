# frozen_string_literal: true

require_relative '../badge_fragment/deserializer'

module AmazonBusinessApi
  class Badge
    class Deserializer < AmazonBusinessApi::Deserializer
      references_one :fragment, deserializer: BadgeFragment::Deserializer
    end
  end
end
