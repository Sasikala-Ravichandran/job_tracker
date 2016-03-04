class Position < ActiveRecord::Base
  
  belongs_to :user

  validates_presence_of :employer, :open_date, :close_date, :applied_date
  validates_length_of :employer, { minimum: 2, maximum: 40}

  has_many :applieds
  has_many :documents, through: :applieds

  def self.remainding_mail
    User.all.each do |user|
      user.positions.each do |position|
        if(position.close_date-Date.today).to_i <= 3
          RemainderMailer.remainder(position).deliver_now!
        end
      end
    end
  end

end
