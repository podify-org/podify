class Source < ApplicationModel
  one_to_many :downloads
  # add_association_dependencies downloads: :destroy

  dataset_module do
    def by_file_path(path)
      by_url("file://#{path.to_s}")
    end

    def by_url(url)
      where(url: url)
    end
  end
end
