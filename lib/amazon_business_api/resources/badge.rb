# frozen_string_literal: true

require_relative 'badge_fragment'

module AmazonBusinessApi
  class Badge < AmazonBusinessApi::Resource
    references_one :fragment, to: BadgeFragment
  end
end
