class Bond < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  
  def validate_name
    unless self.name.is_a?(String) && self.name.length.between?(3, 40)
      raise ArgumentError, 'Invalid name. It must be a string with 3 to 40 alphanumeric characters.'
    end
  end

  def validate_quantity
    unless self.quantity.is_a?(Integer) && self.quantity.between?(1, 10000)
      raise ArgumentError, 'Invalid quantity. It must be an integer between 1 and 10,000.'
    end
  end

  def validate_selling_price
    unless self.selling_price.is_a?(Numeric) && self.selling_price.between?(0.0000, 100000000)
      raise ArgumentError, 'Invalid selling price. It must be a numeric value between 0.0000 and 100,000,000.0000.'
    end
  end

  def buy_bond
    if self.quantity - 1 < 0
      raise ArgumentError, 'Insufficient quantity of bond.'
    end
    return if self.update(quantity: self.quantity - 1)
  end
end
