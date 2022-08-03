class Comment < ApplicationRecord
	include Visible
	#has_one :u dependent: :destroy
	belongs_to :article
	#belongs_to :u
end
