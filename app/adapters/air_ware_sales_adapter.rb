# frozen-string-literal: true

class AirWareSalesAdapter < ApplicationAdapter
  BASE_URL = 'https://www.airwaresales.com.au/shop/'
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
    page = agent.get(BASE_URL)
    form = page.form_with(name: 'mk_login_form')
    form.field_with(name: 'log').value = ENV['UN']
    form.field_with(name: 'pwd').value = ENV['PW']

    agent.submit(form, form.button_with(name: 'submit_button'))
  end
end
