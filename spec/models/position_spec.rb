require 'rails_helper'

RSpec.describe Position, type: :model do

  it { should validate_presence_of(:employer) } 
  it { should validate_length_of(:employer).is_at_least(2).is_at_most(40) }
  it { should validate_presence_of(:open_date) } 
  it { should validate_presence_of(:close_date) } 
  it { should validate_presence_of(:applied_date) } 
  it { should belong_to(:user) }
  it { should have_many(:applieds) }
  it { should have_many(:documents).through(:applieds) }
end
