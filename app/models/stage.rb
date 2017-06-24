class Stage < ApplicationRecord
  belongs_to :project
  has_many :steps

  def build_status(changeset)
    stage_build = StageBuild.find_by(changeset_id: changeset.id, stage_id: self.id)

    unless stage_build
      stage_build = StageBuild.new(changeset_id: changeset.id, stage_id: self.id, status: Redguide::API::STATUS_NOT_STARTED)
      stage_build.save
    end

    stage_build
  end
end
