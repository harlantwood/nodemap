require 'java'
import org.baseparadigm.RepoFs

class HexNamer

  include RepoFs::Namer

  # accepts a java byte array. returns a string file name
  def name(cid)
    new BigInteger(cid).toString(16)
  end

  #accepts a string file name, returns a byte array
  def reverse(cid)
    new BigInteger(cid, 16).toByteArray()
  end
end

class Node

  @@base_paradigm = RepoFs.new(HexNamer.new)

  def Node.recent( max_nodes )
    raise 'implement me'
  end

  def Node.custom_find_or_create( content )
    @@base_paradigm.put( content )
  end

  def to_param
    URI::escape( key )
  end

end
