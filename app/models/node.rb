class Node < ApplicationRecord
  belongs_to :environment

  has_many :error_reports

  public
  STATUS_OK = 1
  STATUS_UNKNOWN = 0
  STATUS_NOK = -1
end
