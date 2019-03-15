class AddSearchTermToTweet < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :search_term, :string
  end
end
