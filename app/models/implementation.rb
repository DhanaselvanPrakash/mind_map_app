class Implementation
  include Mongoid::Document
  include Mongoid::Timestamps
  field :details, type: String
  field :step_id, type: String

  belongs_to :step

  validates :details, presence: true, uniqueness: true
end
