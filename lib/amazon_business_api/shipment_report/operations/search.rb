# frozen_string_literal: true

require 'cgi'
require 'date'

module AmazonBusinessApi
  class ShipmentReport
    module Operations
      # GET /reports/2025-06-09/shipmentReports
      # Returns shipments (with shipmentId) for the given order(s) within a date
      # range. orderStartDate/orderEndDate are required; the end date cannot be
      # in the future and the range cannot exceed 366 days.
      class Search < AmazonBusinessApi::Operation::Search
        # Amazon rejects ranges wider than this (and future end dates).
        MAX_RANGE_DAYS = 366

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

          # Reject invalid date formats client-side before hitting the API.
          rule(:order_start_date) do
            key.failure('must be a valid date') if parse_date(value).nil?
          end

          # End date must parse and cannot be in the future.
          rule(:order_end_date) do
            parsed = parse_date(value)
            if parsed.nil?
              key.failure('must be a valid date')
            elsif parsed > Date.today
              key.failure('cannot be in the future')
            end
          end

          # Inclusive range cannot exceed 366 days.
          rule(:order_start_date, :order_end_date) do
            start_date = parse_date(values[:order_start_date])
            end_date = parse_date(values[:order_end_date])
            next unless start_date && end_date

            inclusive_days = (end_date - start_date).to_i + 1
            if inclusive_days > MAX_RANGE_DAYS
              key(:order_end_date).failure("range cannot exceed #{MAX_RANGE_DAYS} days")
            end
          end

          private

          def parse_date(value)
            Date.parse(value.to_s)
          rescue ArgumentError, TypeError
            nil
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
