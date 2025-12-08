# frozen_string_literal: true

module AmazonBusinessApi
  class BadgeFragment
    class Deserializer < AmazonBusinessApi::Deserializer
      attribute :title
      attribute :message
      attribute :link
      attribute :type
      attribute :fragments
    end
  end
end
