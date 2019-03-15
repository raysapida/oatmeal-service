class Tweet < ApplicationRecord
  validates_presence_of :full_text, :screen_name, :created_at, :search_term
  validates :full_text, uniqueness: { scope: :screen_name }
end
