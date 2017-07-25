class Changeset < ApplicationRecord
  extend FriendlyId
  friendly_id :key, use: :slugged

  belongs_to :project
  belongs_to :author, class_name: :User, foreign_key: :author_id

  has_many :cookbook_builds
  has_many :stage_builds

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

  # Retyrn StageBuild status
  def stage_info(stage)
    stage_build = StageBuild.find_by(changeset_id: self.id, stage_id: stage.id)

    unless stage_build
      stage_build = StageBuild.new(changeset_id: self.id, stage_id: stage.id, status: Redguide::API::STATUS_NOT_STARTED)
      stage_build.save
    end

    stage_build
  end

  # Returns status of cookbook build stage
  def get_cookbook_stage_status(cookbook_build,step_name)
    res = nil

    JSON.parse(cookbook_build.build_job.stages).each do |stage|
      res = stage['status'] if stage['name'] == step_name
    end if cookbook_build.build_job && cookbook_build.build_job.stages

    res
  end
end
