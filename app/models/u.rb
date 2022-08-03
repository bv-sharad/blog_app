class U < ApplicationRecord
	has_many :articles, dependent: :destroy
	#has_many :comments, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
				 :omniauthable

	def self.from_omniauth(auth)
    where(email: auth.email).first_or_create do |u|
			
      u.email = auth.info.email
      u.password = Devise.friendly_token[0, 20]
   end
		u = U.find_by "email = ?", auth.info.email if !u
  end
end
