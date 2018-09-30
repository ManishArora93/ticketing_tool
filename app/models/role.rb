class Role < ActiveRecord::Base

  # ASSOCIATIONS
  has_and_belongs_to_many :custom_roles

  # CONSTANTS
  USER = 'user'
  ASSOCIATE = 'associate'
  ADMIN = 'admin'

  def self.user
    @user_role ||= Role.where(:title => USER).first
  end

  def self.admin
    @admin_role ||= Role.find_by_title(ADMIN)
  end

  def self.associate
    @associate_role ||= Role.find_by_title(ASSOCIATE)
  end
end
