class Applied < ActiveRecord::Base
  belongs_to :document
  belongs_to :position
end
