class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :team, optional: true
  # the has_many relationship has to come before the has_many through relationship
  # otherwise: Cannot have a has_many :through association 'User#teams' which goes through 'User#team_memberships' before the through association is defined
end
