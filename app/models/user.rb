class User < ApplicationRecord
  has_many :elections #Now has elections
  has_many :comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_initialize :default_values

private
  def default_values
    self.name = "User"
  end
end
