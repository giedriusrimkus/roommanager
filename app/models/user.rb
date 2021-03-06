class User < ActiveRecord::Base
	has_many :products, dependent: :destroy
	has_many :memberships, dependent: :destroy
	has_many :rooms, through: :memberships

	attr_accessor :remember_token, :activation_token, :reset_token
	
	before_save :downcase_email
	before_create :create_activation_digest

	validates :name,  presence: true, length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email,
	presence: true, 
	length: { maximum: 255 }, 
	format: { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }

	has_secure_password

	validates :password, presence: true, length: {minimum: 5, maximum: 120}, on: :create
	validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true

	extend FriendlyId
  	friendly_id :slug_candidates, use: :slugged

  	def slug_candidates
  		[:name] + Array.new(6) {|index| [:name, index+2]}
	end
	
	# Returns the hash digest of the given string.
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
	                                                  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Returns a random token.
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest.
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def activate
	    update_attribute(:activated,    true)
	    update_attribute(:activated_at, Time.zone.now)
  	end

  	def deactivate
	    update_attribute(:activated,    false)
	    update_attribute(:activated_at, nil)
  	end

  	def send_activation_email
   		UserMailer.account_activation(self).deliver_now
  	end


	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest,  User.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end


	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	 def resend_activation_email
	     self.send(:create_activation_digest)
	     self.send_activation_email
	     self.save
  	end

  	def join(room)
    	memberships.create!(room_id: room.id)
    	# current_user.rooms << @room
	end

	def leave(room)
		rooms.delete(room)
	end

	# Returns true if the current user is member of the room
	def member?(room)
		rooms.include?(room)
	end

	def member_since?(room)
		memberships.first.created_at if rooms.include?(room)
	end

	private

	    # lowercases email
	    def downcase_email
	      self.email = email.downcase
	    end

	    # Creates and assigns the activation token and digest.
	    def create_activation_digest
	      self.activation_token  = User.new_token
	      self.activation_digest = User.digest(activation_token)
	    end

end
