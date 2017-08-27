class String
  def to_snake
    if self.chars.index(' ').nil?
      underscore
    else
      parameterize.underscore
    end
  end
end
