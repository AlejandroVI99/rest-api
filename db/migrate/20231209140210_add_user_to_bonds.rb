class AddUserToBonds < ActiveRecord::Migration[7.1]
  def change
    add_reference :bonds, :user, foreign_key: true
  end
end
