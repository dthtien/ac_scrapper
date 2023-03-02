class AirConditionersScraper
  BASE_URL = 'https://www.airwaresales.com.au/shop/'.freeze

  def call
    Item.delete_all
    login
    [
      "#{BASE_URL}?pwb-brand=fujitsu",
      "#{BASE_URL}?pwb-brand=mitsubishi-air-conditioner",
      "#{BASE_URL}?pwb-brand=kelvinator",
      "#{BASE_URL}?pwb-brand=bonaire"
    ].each do |url|
      build_data(url)
    end
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
  end

  def fetch_page(url)
    response = agent.get(url)
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

    0.to_s
  end

  def parse_data(item)
    text = item.css('.mk-shop-item-detail').text.split
    text.pop(10)

    title = text.join(' ')
    return unless valid_title?(title.downcase)

    kwc = parse_kw(text)&.downcase&.gsub('kW(C)', '')&.gsub('kw', '').to_f
    return if kwc >= 10

    price = item.css('.price ins').text
    price = item.css('.price .amount').text if price.blank?
    price = price.gsub('$', '').gsub(',', '').to_f
    original_price = item.css('.mk-shop-item-detail i').text


    Item.create(
      original_price_details: original_price,
      title: title,
      kwc: kwc,
      price: price
    )
  end

  def login
    page = agent.get(BASE_URL)
    form = page.form_with(name: 'mk_login_form')
    form.field_with(name: 'log').value = ENV['UN']
    form.field_with(name: 'pwd').value = ENV['PW']

    agent.submit(form, form.button_with(name: 'submit_button'))
  end

  def valid_title?(title)
    title.include?('srk') || title.include?('astg') || title.include?('ksd') || title.include?('optima')
  end

  def agent
    @agent ||= Mechanize.new
  end
end
