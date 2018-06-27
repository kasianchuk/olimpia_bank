class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :accounts, dependent: :destroy
  has_secure_token
  has_secure_token :token

  before_destroy :nope

  private

  def nope
    raise "nope!"
  end
end
