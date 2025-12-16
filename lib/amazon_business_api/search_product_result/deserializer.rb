# frozen_string_literal: true

require_relative '../offer/deserializer'

module AmazonBusinessApi
  class SearchProductResult
    class Deserializer < AmazonBusinessApi::Deserializer
      attribute :asin
      attribute :asin_type, hash_attribute: :asinType
      attribute :signed_product_id, hash_attribute: :signedProductId
      references_many :offers, deserializer: Offer::Deserializer, hash_attribute: 'includedDataTypes.OFFERS'
      attribute :features
      # references_many :editorialReviews, deserializer: EditorialReview::Deserializer
      # references_many :taxonomies, deserializer: Taxonomy::Deserializer
      attribute :title
      attribute :url
      attribute :format
      attribute :product_description, hash_attribute: :productDescription
      attribute :upc_values, hash_attribute: :upcValues
      attribute :ean_values, hash_attribute: :eanValues
      attribute :is_bundled_asin, hash_attribute: :isBundledAsin
    end
  end
end
