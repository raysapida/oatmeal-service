require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it 'factory is valid' do
    tweet = build(:tweet)
    expect(tweet).to be_valid
  end
end
