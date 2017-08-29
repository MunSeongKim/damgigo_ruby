class Post < ActiveRecord::Base
    # User authority apply to model
    resourcify
    
    has_many :comments, dependent: :destroy
    
    # Set up relation between models
    belongs_to :user, :foreign_key => "user_id"
    
    
    # Apply for image
    has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
    validates_attachment :image, :content_type => { :content_type => ["image/jpg", "image/png", "image/jpeg"] }
end
