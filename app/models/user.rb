class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  belongs_to :branch, optional: true
  belongs_to :cooperative, optional: true
  belongs_to :department, optional: true
  belongs_to :role, optional: true
end
