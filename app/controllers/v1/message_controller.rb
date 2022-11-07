# frozen_string_literal: true
class V1::MessageController < ApplicationController
  before_action :set_phone_number, only: [:index]
  before_action :set_message, only: [:index]
  before_action :set_phone_message, only: [:callback]

  def index
    if params[:phone_number].empty?
      return render json: { message: 'phone number or message is empty ' }, status: :bad_request
    end

    res = MessageService.call(@phone_number, @message)
    if res.result.key?(:error)
      render json: res.result, status: :bad_request
    else
      PhoneMessage.create({
                            phone_number: @phone_number,
                            message: @message,
                            message_id: res.result['message_id'],
                          })
    end

    render json: res.result, status: :ok
  end

  def callback
    if @phone_message.update({ status: params['status'] })
      render json: @phone_message, status: :accepted
    else
      render json: { errors: @phone_message.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def set_phone_message
    @phone_message = PhoneMessage.where(message_id: params['message_id'])
  end

  def set_phone_number
    @phone_number = params[:phone_number]
  end

  def set_message
    @message = params['message']
  end
end
