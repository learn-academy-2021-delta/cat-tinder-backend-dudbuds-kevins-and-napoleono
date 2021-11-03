class Dud < ApplicationRecord
    validates :name, :age, :hobbies, presence: true
    validates :hobbies, length: {minimum: 10}
end
