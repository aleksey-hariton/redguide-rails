class ProjectConfig < ApplicationRecord

  belongs_to :project

  validates :name,  presence: true, :uniqueness => {scope: :project}
  validates :content, presence: true
end
