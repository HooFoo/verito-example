class PhotoUploader < BaseImageUploader
  process :resize_to_fit => [1500,1500]

  version :thumb do
    process :resize_to_fit => [100,100]
  end

  version :miniature do
    process :resize_to_fill =>  [200, 200]
  end

  version :preview do
    process :resize_to_fill =>  [400, 400]
  end

  version :base do
    process :resize_to_fit => [500,500]
  end

  def default_url(*args)
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end
end
