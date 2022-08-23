class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum access_level: {
    owner: 0,
    editor: 1,
    member: 2
  }
end
