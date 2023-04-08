class CreateJoinTableGroupPayment < ActiveRecord::Migration[7.0]
  def change
    create_join_table :groups, :payments do |t|
      t.index :group_id
      t.index :payment_id
    end
    add_foreign_key :groups, :users
    add_foreign_key :payments, :users, column: 'author_id'
  end
end
