class User < ActiveRecord::Base
  # ����ɾ��Microposts
  has_many :microposts, dependent: :destroy
  
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness:{ case_sensitive:false }
  
  has_secure_password
  
  validates :password, length: { minimum: 6 }
  
  def new 
    @user = User.new
  end
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def feed
    # 会防止SQL注入
    Micropost.where("user_id = ?", id)
  end
  
  private 
  
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
  
end
