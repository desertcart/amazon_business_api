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
          '/products/2020-08-26/products/getProductsByAsins?inclusionsForProducts=isBundledAsin'
        end

        def opts
          {
            body: serializer.serialize(resource:).merge(
              'productRegion' => client.region[:product_region],
              'locale' => 'en_US'
            )
          }
        end

      end
    end
  end
end
