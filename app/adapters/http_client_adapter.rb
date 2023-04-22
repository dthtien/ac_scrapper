# frozen-string-literal: true

class HttpClientAdapter < ApplicationAdapter
  delegate :get, :submit, to: :agent

  def agent
    @agent ||= Mechanize.new
  end
end
