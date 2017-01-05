class UserProject < ApplicationRecord

  belongs_to :project
  belongs_to :user
end

# == Schema Information
#
# Table name: user_projects
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  project_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  access_status :string(255)
#
