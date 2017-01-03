class Project < ApplicationRecord
  extend FriendlyId
  friendly_id :key, use: :slugged

  validates :key,
            presence: true,
            format: {
              with: /\A[\w\-]+\z/,
              message: 'supports only letters, digits, "-" and "_"'
            },
            length: { maximum: 10 },
            uniqueness: { message: 'already exists' }

  validates :environment_build_job,
            format: {
                with: /\A[\w]*\z/,
                message: 'supports only letters, digits and "_"'
            }

  validates :cookbook_build_job,
            presence: true,
            format: {
                with: /\A[\w\-]+\z/,
                message: 'supports only letters, digits and "_"'
            }

  validates :jenkins_user,
            presence: true

  validates :jenkins_password,
            presence: true

  validates :jenkins_host,
            presence: true,
            format: URI::regexp(%w(http https))

  validates :vcs_server,
            presence: true,
            format: URI::regexp(%w(http https))

  validates :vcs_server_user,
            presence: true

  validates :vcs_server_user_password,
            presence: true

  has_many :cookbooks
  has_many :changesets
end
