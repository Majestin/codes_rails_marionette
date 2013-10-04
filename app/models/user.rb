# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)      not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  avatar                 :string(255)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  include Authority::UserAbilities

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :email, :password, :password_confirmation, :presence => true

  mount_uploader :avatar, AvatarUploader

  has_many :categories, dependent: :destroy
  has_many :snippets, dependent: :destroy
  has_many :sources, dependent: :destroy



  def owned_my_tag_counts
    # items.tag_counts 은 Rails 4 의 relation 상에서 오류가남
    # acts_as_taggable_on 이 업데이트 되기 전까지 다음과 같이 사용
    Snippet.where(user_id: self.id).tag_counts
  end
end
