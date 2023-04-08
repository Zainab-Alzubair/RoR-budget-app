class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :name
      t.decimal "amount", precision: 8, scale: 2
      t.references :author, null: false, foriegn_key: true, index: true
      t.timestamps
    end
  end
end
