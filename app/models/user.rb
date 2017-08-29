class User < ActiveRecord::Base
  # Set up to relation between User Model and Post Model -> 1:N = User:Posts
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  # Applicate user's role
  rolify
  
  validates :email, :password, presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
