class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :rememberable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  include Gravtastic
  gravtastic

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  validates :name, presence: true
  validates :email, uniqueness: true, email: true

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
