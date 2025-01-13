class Step
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :mind_map_id, type: String

  has_many :implementations, dependent: :destroy

  validates :title, presence: true, uniqueness: true
end
