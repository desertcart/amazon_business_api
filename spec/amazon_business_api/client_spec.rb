# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AmazonBusinessApi::Client do
  describe 'Spain region' do
    subject(:client) do
      described_class.new(
        region: :es,
        client_id: 'client-id',
        client_secret: 'client-secret',
        email: 'admin@example.com',
        refresh_token: 'refresh-token',
        save_access_token: nil,
        get_access_token: nil
      )
    end

    it 'uses the European endpoint and ES product region' do
      expect(client.region).to eq(
        endpoint: 'https://eu.business-api.amazon.com',
        product_region: 'ES',
        aws_region: 'eu-west-1'
      )
    end
  end
end
