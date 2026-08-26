# AmazonBusinessApi

A gem to interact with Amazon Business API using LedgerSync operations.

## Requirements

To start you need to have your amazon credentials handy, along with a way to store and retrieve your access token (to avoid issuing a new one on each request).

## Setting up the client

You can set up the client using the following code:
```ruby
client = AmazonBusinessApi::Client.new(
  region: 'us',
  refresh_token: 'your_refresh_token',
  client_id: 'your_client_id',
  client_secret: 'your_client_secret',
  email: 'your_email',
  # if you skip setting the following lambdas, the client will request a new token before each API call
  get_access_token: ->(access_token_key) { Rails.cache.read("AMAZON_BUSINESS_API_TOKEN-#{access_token_key}") },
  save_access_token: ->(access_token_key, token) { Rails.cache.write(
    "AMAZON_BUSINESS_API_TOKEN-#{access_token_key}",
    token[:access_token],
    expires_in: token[:expires_in] - 60
  ) }
)
```

Supported regions are `us`, `uk`, `de`, `fr`, `it`, `es`, and `in`. European marketplaces use
the European API endpoint with their own product region.

During development of this gem you may opt to use these directly from your `.env` file using our helper method:
```ruby
client = AmazonBusinessApi::Client.new_from_env
```
The access token is persisted in your .env file and refreshed when it expires.

## Reporting API
Fetch details of a single order:
```ruby
resource = AmazonBusinessApi::Order.new(
  order_id: '123-45678912-3445567'
)

operation = AmazonBusinessApi::Order::Operations::Find.new(
  client: client,
  resource: resource
)

operation.perform
```

## Search API
Search products by ASINS:
```ruby
resource = AmazonBusinessApi::SearchProductsByAsins.new(
  product_ids: ['B0BV16GZSC'],
  shipping_postal_code: '08844',
  quantity: 2,
  facets: ['OFFERS']
)

operation = AmazonBusinessApi::SearchProductsByAsins::Operations::Search.new(
  client: client,
  resource: resource
)

operation.perform
```

Search products by keywords:
```ruby
resource = AmazonBusinessApi::SearchProductsByKeyword.new(
  keywords: 'iphone 14 pro',
)

operation = AmazonBusinessApi::SearchProductsByKeyword::Operations::Search.new(
  client: client,
  resource: resource
)

operation.perform
```

## Ordering API
Fetch an order (not used, prefer `ReportingAPI fetch`):
```ruby
resource = AmazonBusinessApi::PlaceOrder.new(external_id: '...')

operation = AmazonBusinessApi::PlaceOrder::Operations::Find.new(
  client: client,
  resource: resource
)

operation.perform
```

Create an order:
```ruby
resource = AmazonBusinessApi::PlaceOrder.new(
  external_id: '...',
  line_items: [
    AmazonBusinessApi::RequestLineItem.new(
      external_id: 5,
      quantity: 1,
      place_order_attributes: [
        AmazonBusinessApi::PlaceOrderAttribute.new(
          attribute_type: 'SelectedProductReference',
          product_reference: AmazonBusinessApi::ProductReference.new(
            id: 'B07WJ5D3H4',
            product_reference_type: 'ProductIdentifier'
          )
        ),
        AmazonBusinessApi::PlaceOrderAttribute.new(
          attribute_type: 'SelectedBuyingOptionReference',
          buying_option_reference: AmazonBusinessApi::BuyingOptionReference.new(
            id: '9rdygu2kOGsBrFGh...',
            buying_option_reference_type: 'BuyingOptionIdentifier'
          )
        )
      ],
      place_order_expectations: [
        AmazonBusinessApi::PlaceOrderExpectation.new(
          expectation_type: 'ExpectedUnitPrice',
          amount: AmazonBusinessApi::Amount.new(
            currency_code: 'USD',
            amount: 240
          )
        ),
        AmazonBusinessApi::PlaceOrderExpectation.new(
          expectation_type: 'ExpectedCharge',
          amount: AmazonBusinessApi::Amount.new(
            currency_code: 'USD',
            amount: 500
          ),
          source: 'SUBTOTAL'
        ),
        AmazonBusinessApi::PlaceOrderExpectation.new(
          expectation_type: 'ExpectedCharge',
          amount: AmazonBusinessApi::Amount.new(
            currency_code: 'USD',
            amount: 20
          ),
          source: 'TAX'
        ),
        AmazonBusinessApi::PlaceOrderExpectation.new(
          expectation_type: 'ExpectedCharge',
          amount: AmazonBusinessApi::Amount.new(
            currency_code: 'USD',
            amount: 100
          ),
          source: 'SHIPPING'
        )
      ]
    )
  ],
  place_order_attributes: [
    AmazonBusinessApi::PlaceOrderAttribute.new(
      attribute_type: 'PurchaseOrderNumber',
      purchase_order_number: 'Direct Order test 1'
    ),
    AmazonBusinessApi::PlaceOrderAttribute.new(
      attribute_type: 'BuyerReference',
      user_reference: AmazonBusinessApi::UserReference.new(
        user_reference_type: 'UserEmail',
        email_address: 'your_email' # Should be present in the group below
      )
    ),
    AmazonBusinessApi::PlaceOrderAttribute.new(
      attribute_type: 'BuyingGroupReference',
      group_reference: AmazonBusinessApi::GroupReference.new(
        group_reference_type: 'GroupIdentity',
        identifier: 'your_group_id' # Should be created on AMZ Business Interface
      )
    ),
    AmazonBusinessApi::PlaceOrderAttribute.new(
      attribute_type: 'Region',
      region: 'US' # ['US', 'UK']
    ),
    AmazonBusinessApi::PlaceOrderAttribute.new(
      attribute_type: 'SelectedPaymentMethodReference',
      payment_method_reference: AmazonBusinessApi::PaymentMethodReference.new(
        payment_method_reference_type: 'StoredPaymentMethod'
      )
    ),
    AmazonBusinessApi::PlaceOrderAttribute.new(
      attribute_type: 'ShippingAddress',
      address: AmazonBusinessApi::Address.new(
        address_type: 'PhysicalAddress',
        full_name: 'Test User',
        phone_number: '2066461000',
        company_name: '',
        address_line1: '325 9th Avenue North',
        address_line2: '',
        city: 'Seattle',
        state_or_region: 'WA',
        postal_code: '98109',
        country_code: 'US'
      )
    ),
    AmazonBusinessApi::PlaceOrderAttribute.new(
      attribute_type: 'TrialMode' # Sandbox mode
    )
  ]
)

operation = AmazonBusinessApi::PlaceOrder::Operations::Create.new(
  client: client,
  resource: resource
)

operation.perform
```

## Reconciliation API
Returns a paginated list of business transactions with feed dates that fall within the date range that you specify:
```ruby
resource = AmazonBusinessApi::Reconciliation.new(
  feed_start_date: '2020-05-01T00:00:00Z',
  feed_end_date: '2022-03-30T00:00:00Z'
)


operation = AmazonBusinessApi::Reconciliation::Operations::Find.new(
  client: client,
  resource: resource
)

operation.perform
```

Returns the invoice details for the order line items provided in the request:
```ruby
resource = AmazonBusinessApi::ReconciliationDetail.new(
  external_id: 1,
  order_line_items: [
    AmazonBusinessApi::OrderLineItem.new(
      order_id: '113-0175041-7862644',
      order_line_item_id: '54679693733441',
      shipment_id: 'TvhKHw7fc'
    )
  ]
)

operation = AmazonBusinessApi::ReconciliationDetail::Operations::Find.new(
  client: client,
  resource: resource
)

operation.perform
```
