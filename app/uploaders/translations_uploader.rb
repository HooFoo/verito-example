class TranslationsUploader < CarrierWave::Uploader::Base

  # Tempotary storage. Dispose after redepoyment
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(yml)
  end

end
