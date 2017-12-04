class CategoryIconUploader < BaseImageUploader

  process :resize_to_fill => [256, 256]

  def extension_whitelist
    %w(svg)
  end

end
