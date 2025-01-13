class MindMap
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :moto, type: String
  field :user_id, type: String
  field :shared_with, type: Array, default: []
  
  validates :title, presence: true, uniqueness: true
  validates :moto,  presence: true

  belongs_to :user
  has_many :steps, dependent: :destroy
end
