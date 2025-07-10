class CreateEventComments < ActiveRecord::Migration[7.1]
  def change
    create_table :event_comments do |t|
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
