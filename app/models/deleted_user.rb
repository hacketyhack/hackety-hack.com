class DeletedUser
  def username
    'Deleted User'
  end

  def email
    'none'
  end

  def to_param
    'deleted_user'
  end
end