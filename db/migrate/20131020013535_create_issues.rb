class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :repository
      t.string :title
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
end
