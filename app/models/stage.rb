class Stage < ApplicationRecord
  belongs_to :project
  has_many :steps

  def build_status(changeset)
    StageBuild.find_by(changeset_id: changeset.id, stage_id: self.id)
  end
end
