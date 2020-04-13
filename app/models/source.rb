class Source < ApplicationModel
  one_to_many :downloads
  add_association_dependencies downloads: :destroy

  dataset_module do
    def by_path(path)
      where(path: path.to_s)
    end
  end
end
