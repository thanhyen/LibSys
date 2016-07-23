class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  
  # fields belongs to book model: ISBN, title, description, authors, status (checkout || available)
  field :ISBN, type: String, default: ''
  field :title, type: String, default: ''
  field :description, type: String, default: ''
  field :authors, type: String, default: ''
  field :status, type: String, default: 'available'
  field :image, type: String

  mount_uploader :image, ImageUploader

  belongs_to :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  # ## Database authenticatable
  # field :email,              type: String, default: ""
  # field :encrypted_password, type: String, default: ""

  # ## Recoverable
  # field :reset_password_token,   type: String
  # field :reset_password_sent_at, type: Time

  # ## Rememberable
  # field :remember_created_at, type: Time

  # ## Trackable
  # field :sign_in_count,      type: Integer, default: 0
  # field :current_sign_in_at, type: Time
  # field :last_sign_in_at,    type: Time
  # field :current_sign_in_ip, type: String
  # field :last_sign_in_ip,    type: String

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
