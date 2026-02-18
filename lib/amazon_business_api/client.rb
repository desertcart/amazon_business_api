# frozen_string_literal: true

require 'typhoeus'
require_relative './errors/auth_error'

module AmazonBusinessApi
  class Client
    include LedgerSync::Ledgers::Client::Mixin
    attr_reader :region, :debug, :client_id, :client_secret, :email, :refresh_token, :save_access_token, :get_access_token

    DEFAULT_HEADERS = { 'Accept' => 'application/json',
                        'Content-Type' => 'application/json' }.freeze

    AUTHENTICATION_ENDPOINT = 'https://api.amazon.com/auth/O2/token'

    REGIONS = {
      us: {
        endpoint: 'https://na.business-api.amazon.com',
        product_region: 'US',
        aws_region: 'us-east-1'
      },
      uk: {
        endpoint: 'https://eu.business-api.amazon.com',
        product_region: 'UK',
        aws_region: 'eu-west-1'
      },
      in: {
        endpoint: 'https://eu.business-api.amazon.com',
        product_region: 'IN',
        aws_region: 'eu-west-1'
      }
    }.freeze

    def initialize(client_id:, client_secret:, email:, refresh_token:, save_access_token:, # rubocop:disable Metrics/ParameterLists
                   get_access_token:, trace_response: nil, region: :us, debug: false)
      @region = REGIONS.fetch(region.to_sym)
      @client_id = client_id
      @client_secret = client_secret
      @email = email
      @refresh_token = refresh_token
      @save_access_token = save_access_token
      @get_access_token = get_access_token
      @trace_response = trace_response
      @debug = debug
    end

    def access_token_key
      Digest::MD5.hexdigest("#{client_id} #{refresh_token}")
    end

    def trace_response(response)
      return if @trace_response.nil?

      @trace_response.call(response)
    end

    def access_token
      return request_access_token[:access_token] unless get_access_token

      stored_token = get_access_token.call(access_token_key)
      return stored_token if stored_token

      new_token = request_access_token
      save_access_token&.call(access_token_key, new_token)
      new_token[:access_token]
    end

    def request_access_token # rubocop:disable Metrics/MethodLength
      form_params = {
        'grant_type' => 'refresh_token',
        'client_id' => client_id,
        'client_secret' => client_secret,
        'refresh_token' => refresh_token
      }

      response = Typhoeus::Request.new(AUTHENTICATION_ENDPOINT, {
                                         method: :post,
                                         headers: {
                                           'Content-Type' => 'application/x-www-form-urlencoded',
                                           'Accept' => 'application/json'
                                         },
                                         body: form_params
                                       }).run

      data = JSON.parse("[#{response.body}]", symbolize_names: true)[0]
      unless data && data[:access_token]
        raise StandardError, { code: response.code,
                               response_headers: response.headers,
                               response_body: data }.to_s
      end
      data
    end

    def headers
      {
        'x-amz-access-token' => access_token,
        'x-amz-user-email' => email
      }
    end

    def api(http_method, path, opts = {})
      request = LedgerSync::Ledgers::Request.new(
        body: opts.fetch(:body, nil),
        headers:  DEFAULT_HEADERS.merge(headers)
                                 .merge(opts[:header_params] || {}),
        method: http_method,
        url: region[:endpoint] + path,
        params: opts.fetch(:form_params, {})
      )

      request.perform
    end

    def request(method:, url:, body: nil, headers: {})
      LedgerSync::Ledgers::Request.new(
        client: self,
        body:,
        headers:,
        method:,
        url:
      ).perform
    end

    def exchange_auth_code_for_refresh_token(auth_code:) # rubocop:disable Metrics/MethodLength
      data, status_code, headers = Typhoeus::Request.new(AUTHENTICATION_ENDPOINT, {
        method: :post,
        headers: {
          'Content-Type' => 'application/x-www-form-urlencoded',
          'Accept' => 'application/json'
        },
        body: {
          grant_type: 'authorization_code',
          code: auth_code,
          client_id:,
          client_secret:
        }
      }).run

      unless data && data[:refresh_token]
        raise AmazonBusinessApi::Errors::AuthError.new(code: status_code, response_headers: headers,
                                                           response_body: data)
      end

      data[:refresh_token]
    end

    def self.new_from_env # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      new(
        client_id: ENV.fetch('AMAZON_BUSINESS_API_CLIENT_ID'),
        client_secret: ENV.fetch('AMAZON_BUSINESS_API_CLIENT_SECRET'),
        email: ENV.fetch('AMAZON_BUSINESS_API_EMAIL'),
        refresh_token: ENV.fetch('AMAZON_BUSINESS_API_REFRESH_TOKEN'),
        save_access_token: lambda { |_key, token|
          File.open('.env', 'w') do |file|
            ENV.each do |k, v|
              unless k.start_with?('AMAZON_BUSINESS_API_') &&
                     k != 'AMAZON_BUSINESS_API_ACCESS_TOKEN'
                next
              end

              file.puts "#{k}=#{v}"
            end
            token[:expires_at] = Time.now.to_i + token[:expires_in] - 60
            file.puts "AMAZON_BUSINESS_API_ACCESS_TOKEN=#{token.to_json}"
          end
        },
        get_access_token: lambda { |_key|
          Dotenv.load('.env', overwrite: true)
          return nil unless ENV['AMAZON_BUSINESS_API_ACCESS_TOKEN'].present?

          token = JSON.parse(ENV['AMAZON_BUSINESS_API_ACCESS_TOKEN'], symbolize_names: true)
          return nil if Time.now.to_i > token[:expires_at]

          token[:access_token]
        },
        region: ENV.fetch('AMAZON_BUSINESS_API_REGION', 'us')
      )
    end
  end
end
