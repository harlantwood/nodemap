class Node < ActiveRecord::Base
  def to_param
    key
  end
end
