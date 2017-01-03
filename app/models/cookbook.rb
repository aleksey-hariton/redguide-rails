class Cookbook < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :project
  has_many :cookbook_builds


  validates :name,
            presence: true,
            format: {
                with: /\A[\w]+\z/,
                message: 'supports only letters, digits and "_"'
            },
            uniqueness: {
                scope: :project,
                message: 'already exists'
            }

  validates :vcs_url,
            presence: true,
            format: {
                with: URI::regexp,
                message: 'should be valid URL'
            },
            uniqueness: {
                scope: :project,
                message: 'already exists'
            }

end
