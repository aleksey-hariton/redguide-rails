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

  def parsed_build_stages(stageId,changesetId)
    stage_build = StageBuild.find_by(stage_id: stageId, changeset_id: changesetId)
    if stage_build && stage_build.build_job && stage_build.build_job.stages
      JSON.parse(stage_build.build_job.stages)
    else
      []
    end
  end

  # returns color style for stages according to result status from Jenkins
  def get_step_status_color(step,stageId,changesetId)
    color = "info-box bg-gray"
    stages = parsed_build_stages(stageId,changesetId)
    stages.each do |stage|
      if stage['name'] == step.name
        if stage['status'] == 'SUCCESS'
          color = "info-box bg-green"
        elsif stage['status'] == 'FAILED'
          color = "info-box bg-red"
        elsif stage['status'] == 'IN_PROGRESS'
          color = "info-box bg-blue"
        end
      end
    end
    color
  end

  # returns icon style for stages according to result status from Jenkins
  def get_step_icon(step,stageId,changesetId)
    icon = step.icon
    stages = parsed_build_stages(stageId,changesetId)
    stages.each do |stage|
      if stage['name'] == step.name
        icon = 'refresh fa-spin' if stage['status'] == 'IN_PROGRESS'
      end
    end
    icon
  end

  # returns icon style for stages according to result status from Jenkins
  def get_step_status(step,stageId,changesetId)
    status = 'NOT STARTED'
    stages = parsed_build_stages(stageId,changesetId)
    stages.each do |stage|
      if stage['name'] == step.name
        status = stage['status']
      end
    end
    status
  end
end
