# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  has_secure_password
  has_many :projects
  has_many :project_categories

  before_save do |user|
  	user.email = email.downcase
  end

  before_save  :create_remember_token 

  after_create :create_default_project_category

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 } , on: :create
  validates :password_confirmation, presence: true, on: :create

  
  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def create_default_project_category
      self.project_categories.build(name: "None", description: "None")
    end

    def password_required
      self.new_record?
    end
end
