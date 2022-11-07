class CreatePhoneMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :phone_messages do |t|
      t.string :message_id
      t.string :phone_number
      t.string :message
      t.string :status

      t.timestamps
    end
  end
end
