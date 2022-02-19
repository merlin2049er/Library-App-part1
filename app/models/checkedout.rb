class Checkedout < ApplicationRecord
  belongs_to :user

  def user_email
    user.try(:email)
  end
end
