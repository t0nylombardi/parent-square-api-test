# frozen_string_literal: true
class V1::MessageController < ApplicationController

  def index
    phone_number = params[:phone_number]
    message = params[:message]
    result =  MessageService.call(phone_number, message)
    render json: { message: result }, status: :ok
  end

  def callback
  end

end
