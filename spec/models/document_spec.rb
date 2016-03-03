require 'rails_helper'

RSpec.describe Document, type: :model do
 
  it { should validate_presence_of(:name) } 
  it { should validate_length_of(:name).is_at_least(5).is_at_most(30) }
  it { should belong_to(:user) }
  it { should have_many(:applieds) }
  it { should have_many(:positions).through(:applieds) }
end