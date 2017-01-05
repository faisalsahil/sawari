require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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
