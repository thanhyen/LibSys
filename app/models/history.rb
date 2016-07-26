class History
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :book_id, type: String, default: ''
  field :user_id, type: String, default: ''
  field :action, type: String, default: ''
  field :checkout_date, type: Time, default: ''
  field :return_date, type: Time, default: ''
  field :return_date, type: Time, default: ''

  belongs_to :user
  belongs_to :book

  def self.check_his_book(book_id)
  	History.where(:book_id => book_id)
  	
  end

  def self.check_his_user(user_id)
  	History.where(:user_id => user_id)
  end
end
