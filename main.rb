
require File.expand_path('lib/loja_virtual.rb')



mundo_p = Revista.new "Mundo j",10.9

mundo_p = Revista.find 1
puts "id #{mundo_p.id}"
puts "valor #{mundo_p.valor}"
