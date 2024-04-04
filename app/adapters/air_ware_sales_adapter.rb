# frozen-string-literal: true

class AirWareSalesAdapter < ApplicationAdapter
  BASE_URL = 'https://www.airwaresales.com.au/shop/'
  LOGIN_URL = 'https://www.airwaresales.com.au/my-account/'
  BRAND_URLS = [
    "#{BASE_URL}?pwb-brand=fujitsu",
    "#{BASE_URL}?pwb-brand=mitsubishi-air-conditioner",
    "#{BASE_URL}?pwb-brand=kelvinator",
    "#{BASE_URL}?pwb-brand=bonaire"
  ].freeze

  def get_items(url)
    response = agent.get(url)
    Nokogiri::HTML(response.body)
  end

  def login
    page = agent.get(LOGIN_URL)
    form = page.forms.first
    form.field_with(name: 'username').value = ENV['UN']
    form.field_with(name: 'password').value = ENV['PW']

    agent.submit(form, form.button_with(name: 'login'))
  end
end
