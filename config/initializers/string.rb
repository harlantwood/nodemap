class String

  def sha512
    Digest::SHA512.hexdigest( self )
  end

end
