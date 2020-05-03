class RequestPresenter < ApplicationPresenter
  def source
    @source ||= SourcePresenter.new(object.source)
  end
end
