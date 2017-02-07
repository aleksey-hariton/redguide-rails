class Environment < ApplicationRecord
  belongs_to :organization

  has_many :nodes
end
