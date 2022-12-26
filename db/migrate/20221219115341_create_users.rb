class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.bigint :external_id, null: false
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :language_code
      t.string :ton_address
      t.string :send_period

      t.timestamps
    end
  end
end
