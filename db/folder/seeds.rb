require "active_file"
class Revista
	attr_reader :titulo,:id ,:destroyed,:new_record
	include ActiveFile
	
end
Revista.new(titulo: "Veja", valor: 10.90).save
Revista.new(titulo: "Época", valor: 12.90).save
