class HistoryClient < ApplicationRecord
  belongs_to :email_history
  belongs_to :client
end
