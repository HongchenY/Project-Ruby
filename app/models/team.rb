class Team < ApplicationRecord
    has_many :members
    has_many :users
    # the has_many relationship has to come before the has_many through relationship
end
