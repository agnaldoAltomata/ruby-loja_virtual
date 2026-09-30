
class Revista
	attr_reader :titulo, :id , :destroyed,:new_record
	attr_accessor :valor

	include ActiveFile
	
	def initialize(titulo,valor)
		@titulo = titulo
		@valor = valor
		@id = self.class.next_id
		@destroyed = false
		@new_record = true
	end
end