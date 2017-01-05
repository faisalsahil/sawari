require 'test_helper'

class EndPointTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: end_points
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  url         :string(255)
#  method      :string(255)
#  request     :text(65535)
#  response    :text(65535)
#  notes       :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  is_active   :boolean
#  is_deleted  :boolean          default(FALSE)
#
