require 'rails_helper'

RSpec.describe Applied, type: :model do
 
  it { should belong_to(:document) }
  it { should belong_to(:position) } 
  
end