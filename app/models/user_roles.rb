class UserRoles
  def initialize(user)
    @user = user
  end

  # Public: This method checks for permission for a user with
  # multiple roles
  #
  # Returns boolean value for the user with the ability.
  def method_missing(method, *args)
    begin
      @user.custom_roles.any? { |role| role.send(method.to_sym) }
    rescue NoMethodError
      super
    end
  end
end