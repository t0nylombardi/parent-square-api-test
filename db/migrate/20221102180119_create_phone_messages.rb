class CreatePhoneMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :phone_messages do |t|
      t.string :phone_number
      t.string :message
      t.boolean :invailid

      t.timestamps
    end
  end
end
