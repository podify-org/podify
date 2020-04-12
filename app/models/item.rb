class Item < ApplicationModel
  dataset_module do
    def by_path(path)
      where(path: path.to_s)
    end
  end
end
