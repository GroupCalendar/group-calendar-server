class Group < ApplicationRecord

  include PgSearch::Model
  pg_search_scope :search_by_name, against: :name

  has_many :memberships
  has_many :users, through: :memberships

  enum visibility_type: {
    visible: 0,
    hidden: 1
  }

  enum join_type: {
    open: 0,
    need_approval: 1,
    need_passcode: 2,
    forbidden: 3
  }

  def visibility_type_title
    case visibility_type
    when "visible"
      "Visible"
    when "hidden"
      "Hidden"
    else
      ""
    end
  end

  def join_type_title
    case join_type
    when "open"
      "Open"
    when "need_approval"
      "Need approval"
    when "need_passcode"
      "Need passcode"
    when "forbidden"
      "Forbidden"
    else
      ""
    end
  end

  def can_be_deleted(source_user_id)
    membership(source_user_id).access_level == 'owner'
  end

  def membership(source_user_id)
    memberships.where(memberships: { user_id: source_user_id, group_id: id }).first!
  end

end
