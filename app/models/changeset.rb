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

  # returns color style for stages according to result status from Jenkins
  def get_step_status_color(stage, step)
    color = 'info-box bg-gray'

    stage_info(stage).build_job.build_steps.each do |build_step|
      if build_step['name'] == step.name
        if build_step['status'] == 'SUCCESS'
          color = 'info-box bg-green'
        elsif build_step['status'] == 'FAILED'
          color = 'info-box bg-red'
        elsif build_step['status'] == 'IN_PROGRESS'
          color = 'info-box bg-blue'
        end
      end
    end
    color
  end

  # returns icon style for stages according to result status from Jenkins
  def get_step_icon(stage, step)
    icon = step.icon
    stage_info(stage).build_job.build_steps.each do |build_step|
      if build_step['name'] == step.name
        icon = 'refresh fa-spin' if build_step['status'] == 'IN_PROGRESS'
      end
    end
    icon
  end

  # returns icon style for stages according to result status from Jenkins
  def get_step_status(stage, step)
    status = 'NOT STARTED'
    stage_info(stage).build_job.build_steps.each do |build_step|
      if build_step['name'] == step.name
        status = build_step['status']
      end
    end
    status
  end
end
