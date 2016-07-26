class Painting
  include Mongoid::Document

  field :gallery_id
  field :name, type: String, default:''
  field :image, type: String, default:''
  field :remote_image_url

  belongs_to :book
  mount_uploader :image, ImageUploader
  
end
