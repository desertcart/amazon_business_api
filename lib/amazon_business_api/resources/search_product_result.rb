# frozen_string_literal: true
#
require_relative '../types/array'
require_relative 'editorial_review'
require_relative 'offer'
require_relative 'taxonomy'

module AmazonBusinessApi
  class SearchProductResult < AmazonBusinessApi::Resource
    # https://developer-docs.amazon.com/amazon-business/docs/product-search-api-v1-reference#productsresult
    attribute :asin, type: LedgerSync::Type::String
    attribute :asin_type, type: LedgerSync::Type::String # One of STANDARD, VARIATION_PARENT, VARIATION_CHILD
    attribute :signed_product_id, type: LedgerSync::Type::String
    references_many :offers, to: Offer
    attribute :features, type: Type::Array
    references_many :editorial_reviews, to: EditorialReview
    references_many :taxonomies, to: Taxonomy
    attribute :title, type: LedgerSync::Type::String
    attribute :url, type: LedgerSync::Type::String
    attribute :format, type: LedgerSync::Type::String
    # attribute :bookInformation, type: LedgerSync::Type::String
    # attribute :byLine, type: LedgerSync::Type::String
    # attribute :mediaInformation, type: LedgerSync::Type::String
    # attribute :productOverview, type: LedgerSync::Type::String
    # attribute :productDetails, type: LedgerSync::Type::String
    # attribute :productVariations, type: LedgerSync::Type::String
    # attribute :customerReviewsSummary, type: LedgerSync::Type::String
    attribute :product_description, type: LedgerSync::Type::String
    attribute :upc_values, type: Type::Array
    attribute :ean_values, type: Type::Array
    attribute :is_bundled_asin, type: LedgerSync::Type::Boolean
  end
end
