
class Revista
	#com o uso do ActiveFile não necessita das partes comentadas  
	#mas com method missing precisa
		attr_reader :titulo, :id , :destroyed,:new_record
	#	attr_accessor :valor

		include ActiveFile
		
	#	def initialize(parametrs={})
	#		@id = self.class.next_id
	#		@destroyed = false
	#		@new_record = true
	#		parametrs.each do |key,valor|
	#			instance_variable_set "@#{key}",valor
	#		end 
	#	end
	
end