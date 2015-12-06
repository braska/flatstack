class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :trackable, :validatable, :lockable, :confirmable

  has_and_belongs_to_many :roles

  def role?(role)
    !!self.roles.find_by_name(role.to_s)
  end
end
