# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe AmazonBusinessApi::Client do
  describe 'European marketplace regions' do
    subject(:client) do
      described_class.new(
        region:,
        client_id: 'client-id',
        client_secret: 'client-secret',
        email: 'admin@example.com',
        refresh_token: 'refresh-token',
        save_access_token: nil,
        get_access_token: nil
      )
    end

    %i[uk de fr it es].each do |marketplace|
      context "with the #{marketplace.to_s.upcase} marketplace" do
        let(:region) { marketplace }

        it 'uses the European endpoint and marketplace product region' do
          expect(client.region).to eq(
            endpoint: 'https://eu.business-api.amazon.com',
            product_region: marketplace.to_s.upcase,
            aws_region: 'eu-west-1'
          )
        end
      end
    end
  end
end
