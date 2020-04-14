module Downloads
  class Destroy
    include Dry::Monads[:result, :do]

    def call(download)
      download.destroy
      Success()
    end
  end
end
