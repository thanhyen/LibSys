class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  # field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  # field :username, type:String, default: 'yenlt'
  # # field :password, type: password, default: ''
  # field :password_confirm, type: password, default: ''
  # fields belongs to user obj
  field :username, type:String, default: 'yenlt'
  field :email, type: String, default: 'yenlt@topica.edu.vn'
  field :password, type: String, default: ''
  field :password_confirmation, type: String, default: ''
  field :role, type: String, default: 'user'

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  has_many :books
  has_many :histories, class_name: "History"


def self.search(q)
  User.any_of({:username => /#{q}/i}, {:email => /#{q}/i}, {:role => /#{q}/i})
end

def self.find_user (user_id)
  User.where(:id => user_id).first
end

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
end
