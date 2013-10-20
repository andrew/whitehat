class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.integer :github_user_id
      t.integer :issue_id

      t.timestamps
    end
  end
end
