# frozen-string-literal: true

module Quotes
  class Create < BaseService
    attr_reader :quote

    def initialize(params)
      super()
      @params = params
    end

    def call
      @quote = Quote.new(quote_params)
      user.assign_attributes(user_params)

      ActiveRecord::Base.transaction do
        user.save!

        @quote.user = user
        @quote.save!
      end

      self
    rescue ActiveRecord::RecordInvalid => e
      @errors << e.message
    end

    private

    attr_reader :params

    def user_params
      params.slice(:name, :email, :phone)
    end

    def user
      @user ||= User.find_or_initialize_by(email: params[:email])
    end

    def quote_params
      params.slice(:division, :storey, :address)
    end
  end
end
