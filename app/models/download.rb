class Download < ApplicationModel
  include Downloads::FileUploader::Attachment(:file)

  many_to_one :source

  dataset_module do
    def by_path(path)
      where(path: path.to_s)
    end
  end
end
