class Prconfig < ApplicationRecord

  belongs_to :project

  validates :name,  presence: true
  validates :content, presence: true
end
