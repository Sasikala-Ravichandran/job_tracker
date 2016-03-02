class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  VALID_FORMAT =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates_presence_of :first_name, :last_name, :email
  validates :email, uniqueness: { case_sensitive: false },
                    format: { with: VALID_FORMAT}

  has_one :payment
  accepts_nested_attributes_for :payment
end
