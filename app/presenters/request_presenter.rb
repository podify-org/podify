class RequestPresenter < ApplicationPresenter
  def source
    @source ||= SourcePresenter.wrap(object.source)
  end
end
