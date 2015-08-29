module CategoriesHelper

  def has_items?(category)
    return category.items.present?
  end

  def has_any_category_any_items?
    if (Category.all.blank?)
      return false
    else
      Category.all.each do |c|
        if (c.items.present?)
          return true
        end
      end
      return false
    end
  end

end
