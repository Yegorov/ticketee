class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :roles

  scope :excluding_archived, ->(){ where(archived_at: nil) }

  def active_for_authentication?
    super && archived_at.nil?
  end
  def inactive_message
    archived_at.nil? ? super : :archived
  end

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end

  def archive
    self.update(archived_at: Time.now)
  end

  def role_on(project)
    roles.find_by(project_id: project).try(:role)
  end
end
