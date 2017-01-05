class Category < ApplicationRecord

  validates :name, presence: true
  belongs_to :project
  has_many :end_points, dependent: :destroy

  default_scope { order(:name) }
end

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  is_deleted :boolean          default(FALSE)
#
