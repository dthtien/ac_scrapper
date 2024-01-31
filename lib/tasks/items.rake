namespace :items do
  desc 'Update data'
  task update_data: :environment do
    Scrapers::AirConditionersScraper.new.call
  end
end
