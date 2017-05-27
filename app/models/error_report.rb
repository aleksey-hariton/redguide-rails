class ErrorReport < ApplicationRecord
  belongs_to :node
  belongs_to :environment
end
