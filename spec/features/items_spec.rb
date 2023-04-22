# frozen-string-literal: true
require 'rails_helper'

RSpec.feature "Products" do
  let!(:items) { create_list(:item, 3) }

  scenario 'index' do
    visit root_path

    items.each do |item|
      expect(page).to have_content(item.title)
    end

    expect(page).to have_content('Refresh')

    expect(page).to have_content(items.map(&:updated_at).max.strftime('%d %B %Y at %I:%M%p'))
  end
end
