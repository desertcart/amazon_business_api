# frozen_string_literal: true

module AmazonBusinessApi
  class SearchProductsByAsins
    module Operations
      class Search < AmazonBusinessApi::Operation::Search
        class Contract < LedgerSync::Ledgers::Contract
          params do
            required(:orderId).filled(:string)
          end
        end

        private

        def url
          # Request product data + facets for OFFERS/IMAGES + extra product inclusions
          facets = 'OFFERS,IMAGES'
          inclusions = 'isBundledAsin,title,productDescription,features'
          "/products/2020-08-26/products/getProductsByAsins?facets=#{facets}&inclusionsForProducts=#{inclusions}"
        end

        def opts
          body = serializer.serialize(resource:).merge(
            'productRegion' => client.region[:product_region],
            'locale' => 'en_US'
          )
          { body: }
        end
      end
    end
  end
end
