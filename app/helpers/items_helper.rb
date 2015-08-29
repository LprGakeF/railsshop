module ItemsHelper

  def has_photo?(item)
    return item.photo.present?
  end

end
