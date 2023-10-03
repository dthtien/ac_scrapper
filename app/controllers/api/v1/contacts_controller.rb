module Api
  module V1
    class ContactsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        ContactMailer.notify_owner(
          params[:email],
          params[:name],
          params[:message]
        ).deliver_now
        ContactMailer.notify_sender(
          params[:email],
          params[:name]
        ).deliver_now

        render json: { success: true }
      end
    end
  end
end
