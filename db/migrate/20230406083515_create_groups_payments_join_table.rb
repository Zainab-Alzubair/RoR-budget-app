class CreateGroupsPaymentsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :groups, :payments
  end
end
