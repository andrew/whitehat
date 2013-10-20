class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :nickname
      t.string :email
      t.string :gravatar_id
      t.string :token

      t.timestamps
    end
  end
end
