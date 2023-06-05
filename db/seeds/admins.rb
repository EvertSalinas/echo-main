AdminUser::ROLES.each do |role|
  AdminUser.create! do |user|
    user.email = "admin+#{role}@example.com"
    user.role = role
    user.password = 'testing'
    user.password_confirmation = 'testing'
    prefix = [*'A'..'Z'].sample
    while AdminUser.exists?(prefix: prefix)
      prefix = [*'A'..'Z'].sample
    end
    user.prefix = prefix
  end
end
