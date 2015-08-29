class Item < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :ordered_items, dependent: :restrict_with_exception
  #accepts_nested_attributes_for :categories

  has_attached_file :photo,
    :styles =>  { :medium     => "400x400>",
                  :small  => "100x100>"
                },
    #:default_url => "/images/:style/no_image_available.png"
    :default_url => "/images/:style/missing.png"
    validates_attachment_size :photo, :less_than => 512.kilobytes
    validates_attachment_file_name :photo, :matches => [/png\Z/, /jpe?g\Z/]
    validates_attachment_content_type :photo, :content_type => /\Aimage/

    #do_not_validate_attachment_file_type :photo

end
