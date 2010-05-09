# require 'nokogiri'
# 
# class NodeMap  
#   def NodeMap.create_relationships
#     Node.all.each do |node|
#       doc = Nokogiri::HTML( node.html )                
#       doc.search( 'h1' ).each do |h1_tag| 
#         puts title = h1_tag.content 
#         node.add_related_node( 'title', title ) 
#       end
#     end
#     
# 
#   end
# end