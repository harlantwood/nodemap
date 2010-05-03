class Node < ActiveRecord::Base
  def to_param
    URI::escape( key )
  end
end
