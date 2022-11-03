class PhoneMessage < ApplicationRecord
  validates :phone_number, presence: true
end
