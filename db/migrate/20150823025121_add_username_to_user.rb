class AddUsernameToUser < ActiveRecord::Migration
  change_table :users do |t|
    t.string :username
  end
end
