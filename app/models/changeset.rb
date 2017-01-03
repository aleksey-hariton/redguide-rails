class Changeset < ApplicationRecord
  extend FriendlyId
  friendly_id :key, use: :slugged

  belongs_to :project
  belongs_to :author, class_name: :User, foreign_key: :author_id

  has_many :cookbook_builds


  validates :key,
            presence: true,
            format: {
                with: /\A[\w\-]+\z/,
                message: 'supports only letters, digits, "-" and "_"'
            },
            length: { maximum: 10 },
            uniqueness: {
                scope: :project,
                message: 'already exists'
            }


  def add_cookbook(cookbook)
    cookbook_build = CookbookBuild.new
    cookbook_build.cookbook = cookbook
    cookbook_build.changeset = self

    {
        status: cookbook_build.save,
        build: cookbook_build
    }
  end
end
