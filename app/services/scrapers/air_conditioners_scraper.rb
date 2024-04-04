# frozen-string-literal: true

module Scrapers
  class AirConditionersScraper < ApplicationScraper
    NEXT_URL_SELECTOR = '.page-numbers .next.page-numbers'
    ITEM_SELECTOR = '.mk-shop-item-detail'

    def call
      reset_items
      adapter.login

      Async do
        AirWareSalesAdapter::BRAND_URLS.each do |url|
          Async { build_data(url) }
        end
      end
    end

    private

    def reset_items
      Item.delete_all
    end

    def build_data(base_url)
      next_url = fetch_data(base_url)
      next_url = fetch_data(next_url) while next_url
    end

    def fetch_data(url)
      html = adapter.get_items(url)
      create_items(html)
      html.css(NEXT_URL_SELECTOR)&.attr('href')&.value
    end

    def create_items(html)
      html.css('.product').each { |item| create_item(item) }
    end

    def parse_kw(text)
      kwc = text.find { |t| t.include?('kW(C)') } || text.find { |t| t.include?('kw') }
      return kwc if kwc.present?

      kw_index = text.index('KW')

      kwc = kw_index.nil? ? text.find { |t| t.downcase.include?('kw') } : text[kw_index - 1]

      kwc || 0.to_s
    end

    def create_item(item)
      title = item.css('.woocommerce-loop-product__title').text
      return unless valid_title?(title.downcase)

      kwc = parse_kw(title.split).gsub(/[^0-9\.]/, '').to_f
      return if kwc >= 10

      price = item.css('.price ins').text
      price = item.css('.price .amount').text if price.blank?
      price = price.gsub('$', '').gsub(',', '').to_f
      original_price = item.css(".astra-shop-summary-wrap i").text


      images_selector = item.css('img.attachment-woocommerce_thumbnail')
      image_url = images_selector.attr('src')&.value

      Item.create(
        original_price_details: price,
        title: title,
        kwc: kwc,
        price: 'NA',
        image_url: image_url
      )
    end

    def valid_title?(title)
      title.include?('dxk') || title.include?('astg') || title.include?('ksd') || title.include?('optima')
    end

    def adapter
      @adapter ||= AirWareSalesAdapter.new
    end
  end
end
