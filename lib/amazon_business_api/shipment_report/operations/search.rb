# frozen_string_literal: true

require 'cgi'

module AmazonBusinessApi
  class ShipmentReport
    module Operations
      # GET /reports/2025-06-09/shipmentReports
      # Returns shipments (with shipmentId) for the given order(s) within a date
      # range. orderStartDate/orderEndDate are required; the end date cannot be
      # in the future and the range cannot exceed 366 days.
      class Search < AmazonBusinessApi::Operation::Search
        # Resource attribute => query parameter name.
        QUERY_PARAMS = {
          order_start_date: 'orderStartDate',
          order_end_date: 'orderEndDate',
          order_ids: 'orderIds',
          region: 'region',
          shipment_statuses: 'shipmentStatuses',
          next_page_token: 'nextPageToken'
        }.freeze

        class Contract < LedgerSync::Ledgers::Contract
          params do
            required(:order_start_date).filled(:string)
            required(:order_end_date).filled(:string)
            optional(:order_ids).maybe(:string)
            optional(:region).maybe(:string)
            optional(:shipment_statuses).maybe(:string)
            optional(:next_page_token).maybe(:string)
          end
        end

        private

        def request_method
          :get
        end

        def url
          "/reports/2025-06-09/shipmentReports?#{query_string}"
        end

        def query_string
          QUERY_PARAMS.filter_map do |attr, key|
            value = resource.public_send(attr)
            next if value.nil? || value.to_s.empty?

            "#{key}=#{CGI.escape(value.to_s)}"
          end.join('&')
        end

        def opts
          {}
        end
      end
    end
  end
end
