class FilePresenter < ApplicationPresenter
  SIZE_UNITS = [
    { unit:  :B, exp: 0 },
    { unit: :KB, exp: 1 },
    { unit: :MB, exp: 2 },
    { unit: :GB, exp: 3 },
    { unit: :TB, exp: 4 },
  ]

  def extension
    object.extension
  end

  def human_size(units = %i[KB MB GB], decimals: 1)
    conv = SIZE_UNITS.reverse.find { |unit:, exp:| units.include?(unit) && object.size.fdiv(1024 ** exp) >= 1 }
    conv ||= SIZE_UNITS.last

    "#{object.size.fdiv(1024 ** conv[:exp]).round(decimals)} #{conv[:unit]}"
  end
end
