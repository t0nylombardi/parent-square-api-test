require 'rails_helper'

RSpec.describe V1::MessageController do
  describe 'index' do
    let(:phone_number) {Faker::PhoneNumber.phone_number}
    let(:message) { Faker::Lorem.sentences(number: 1) }

    it 'create phone message record' do
      post :index, params: {phone_number: phone_number, message: message} 
      expect(PhoneMessage.count).to eq 1
      expect(response).to have_http_status(200)
    end
    
    describe 'when phone number is missing' do 
      it 'should not create phone message record' do
        post :index, params: {phone_number: '', message: message} 
        expect(PhoneMessage.count).to eq 0
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'callback' do
    before :each do
      @phone_message = FactoryBot.create(:phone_message, message_id: 'ea736f97-d49b-40db-8a7b-be8bef9542e8')
    end
    
    let(:params) {
      {
        "status": "delivered", 
        "message_id": "ea736f97-d49b-40db-8a7b-be8bef9542e8",
      }
    }
    

    it 'updates a record matching message_id' do   
      post :callback, params: params 
      expect(PhoneMessage.last.status).not_to be_nil
    end
  end

end
