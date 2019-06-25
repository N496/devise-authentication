class User < ApplicationRecord
 ## Devise Gem Authentication
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :auth_tokens, dependent: :destroy
  has_many :books, dependent: :destroy

  ## Generate Auth token when user login
  def generate_auth_token
       begin
         token = SecureRandom.hex
       end while AuthToken.exists?(auth_token: token)
       self.auth_tokens.create(auth_token: token)
       token
  end
end
