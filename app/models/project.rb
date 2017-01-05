class Project < ApplicationRecord
  has_many :categories, dependent: :destroy

  has_many :user_projects
  has_many :users, through: :user_projects

  validates_presence_of :name, presence: true

  default_scope { order(:name) }
end

# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  project_status :string(255)
#  is_deleted     :boolean          default(FALSE)
#
