class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :custom_roles, class_name: 'Role'
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # CALLBACKS
  after_commit :assign_role_user, on: :create
  # has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  #   validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Public: This method overrides role attribute for the user object
  #
  # Returns instance of UserRoles class
  def role
    UserRoles.new(self)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def assign_role_user
    custom_roles << [Role.send(:user)]
    self.update_column(:role_id , Role.user.id)
  end

  def make_as_user
    self.custom_roles << [Role.send(:user)]
    self.update_column(:role_id , Role.user.id)
  end

  def make_as_admin
    self.custom_roles << [Role.send(:admin)]
    self.update_column(:role_id , Role.admin.id)
  end

  def make_as_associate
    self.custom_roles << [Role.send(:associate)]
    self.update_column(:role_id , Role.associate.id)
  end

  def admin?
    self.custom_roles.pluck(:title).include?('admin')
  end

  def associate?
    self.custom_roles.pluck(:title).include?('associate')
  end

  def user?
    self.custom_roles.pluck(:title).include?('user')
  end
end
