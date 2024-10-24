# frozen_string_literal: true

require_relative '../order/deserializer'

module AmazonBusinessApi
  class FindOrder
    class Deserializer < AmazonBusinessApi::Deserializer
      references_many :orders, deserializer: Order::Deserializer
    end
  end
end
