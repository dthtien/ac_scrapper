class AirConditionersScraper
  BASE_URL = 'https://www.airwaresales.com.au/shop/'

  def call
    data = []
    [
      "#{BASE_URL}?pwb-brand=fujitsu",
      "#{BASE_URL}?pwb-brand=mitsubishi-air-conditioner",
      "#{BASE_URL}?pwb-brand=kelvinator"
    ].each do |url|
      data += build_data(url)
    end

    data.sort_by { |d| d[:kwc] }
  end

  private

  def build_data(base_url)
    html = fetch_page(base_url)
    data = []
    html.css('.item').each do |item|
      data << parse_data(item)
    end
    next_url = html.css('.page-numbers .next.page-numbers')&.attr('href')&.value

    while next_url
      html = fetch_page(next_url)
      html.css('.item').each do |item|
        data << parse_data(item)
      end
      next_url = html.css('.page-numbers .next.page-numbers')&.attr('href')&.value
    end

    data.compact
  end

  def fetch_page(url)
    response = Faraday.get(url)
    Nokogiri::HTML(response.body)
  end

  def parse_kw(text)
    kwc = text.find { |t| t.include?('kW(C)') } || text.find { |t| t.include?('kw') }
    return kwc if kwc.present?

    kw_index = text.index('KW')

    if kw_index.nil?
      kwc = text.find { |t| t.downcase.include?('kw') }
    else
      kwc = text[kw_index - 1]
    end

    return kwc if kwc

    0
  end

  def parse_data(item)
    text = item.css('.mk-shop-item-detail').text.split
    text.pop(10)

    kwc = parse_kw(text)&.downcase&.gsub('kW(C)', '')&.gsub('kw', '').to_f
    return if kwc >= 10

    price = item.css('.price ins').text
    price = item.css('.price .amount').text if price.blank?
    price = price.gsub('$', '').gsub(',', '').to_f

    title = %{
      #{text.join(' ')}
      <span style=' color: red; font-weight: bold;'>$#{price}</span>
      <span style=' color: blue; font-weight: bold;'>$#{(price * 0.895).round(2)}</span>
    }
    downcase_title = title.downcase
    return if !downcase_title.include?('srk') && !downcase_title.include?('astg') && !downcase_title.include?('ksd')

    {
      title: title,
      kwc: kwc,
      price: price
    }
  end
end
