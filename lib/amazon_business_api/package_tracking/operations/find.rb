# frozen_string_literal: true

module AmazonBusinessApi
  class PackageTracking
    module Operations
      class Find < AmazonBusinessApi::Operation::Find
        class Contract < LedgerSync::Ledgers::Contract
          params do
            required(:order_id).filled(:string)
            required(:shipment_id).filled(:string)
            required(:package_id).filled(:string)
            required(:region).filled(:string)
          end
        end

        private

        def url
          '/ab-tracking/2025-07-02' \
            "/orders/#{resource.order_id}" \
            "/shipments/#{resource.shipment_id}" \
            "/packages/#{resource.package_id}" \
            "?region=#{resource.region}"
        end

        def opts
          {}
        end

        def hash_to_deserialize
          response.body['packageTrackingDetails'] || {}
        end
      end
    end
  end
end
