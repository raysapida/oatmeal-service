class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.text :full_text
      t.string :screen_name
      t.datetime :created_at

      t.timestamps
    end
  end
end
