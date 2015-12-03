class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable, :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_and_belongs_to_many :roles

  def role?(role)
    !!self.roles.find_by_name(role.to_s)
  end
end
