class User < ApplicationModel
  one_to_many :requests
  many_to_many :sources, join_table: :requests
end
