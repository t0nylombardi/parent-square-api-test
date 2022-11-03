require 'rails_helper'

RSpec.describe PhoneMessage, type: :model do
  describe 'validations' do 
    
    context 'when phone message is valid' do
      let(:phone_message) { FactoryBot.build(:phone_message) }
      
      it 'should be valid' do
        expect(phone_message.valid?).to be_truthy
      end
  
      it 'should have phone number field' do 
        expect(phone_message.phone_number).not_to be_nil
      end
    end

    context 'when phone message is not valid' do 
      let(:phone_message) { FactoryBot.build(:phone_message, phone_number: nil) }

      it 'should not be valid' do 
        expect(phone_message.valid?).to be_falsey
        expect(phone_message.errors.generate_message(:phone_number)).to be_truthy
      end
    end
  end
end
