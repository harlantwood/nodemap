require 'java'
import org.baseparadigm.RepoFs
import org.baseparadigm.ContentId
import java.math.BigInteger

class HexNamer
  include RepoFs::Namer

  # accepts a java byte array. returns a string file name
  def name(cid)
    BigInteger.new(cid).toString(16)
  end

  #accepts a string file name, returns a byte array
  def reverse(cid)
    BigInteger.new(cid, 16).toByteArray()
  end
end

class Node

  @@repo_fs = RepoFs.new(java.io.File.new('./tmp/repo'), HexNamer.new)

  def self.recent( max_nodes )
    raise 'implement me'
  end

  def self.custom_find_or_create( content )
    content_id = @@repo_fs.put( content.to_java_bytes )
  end

  def self.find_by_key( content_id_string )
    ContentId.new(@@repo_fs, BigInteger.new(content_id_string, 16)).resolve()
  end

end
