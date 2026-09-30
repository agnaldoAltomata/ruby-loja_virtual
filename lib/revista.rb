require 'yaml'
require 'FileUtils'

class Revista
	attr_reader :titulo, :id , :destroyed,:new_record
	attr_accessor :valor
	
	def initialize(titulo,valor)
		@titulo = titulo
		@valor = valor
		@id = self.class.next_id
		@destroyed = false
		@new_record = true
	end
	def save
		## não trata erros
		#def save
		#	File.open("db/revistas/#{@id}.yml", "w") do |file|
		#	file.puts serialize
		#	end
		#end
		@new_record = false
		Dir.mkdir("db") unless Dir.exist?("db")
		Dir.mkdir("db/revistas") unless Dir.exist?("db/revistas")
			File.open("db/revistas/#{@id}.yml","w") do |file|
				file.puts serialize
		end
	end
	def destroy
		unless @destroyed or @new_record
			@destroyed = true
			FileUtils.rm "db/revistas/#{@id}.yml"
		end
	end
	# forma não segura, gera erro na verção 4
	#def self.find(id)
	#	YAML.load File.open("db/revistas/#{id}.yml", "r")
	#end
	def self.find(id)
		path = "db/revistas/#{id}.yml"

		unless File.exist?(path)
			raise DocumentNotFound,"Arquivo db/revistas/#{id} não encontrado.",caller
		end
		obj = File.read(path)
		YAML.safe_load(obj,permitted_classes:[Revista,Symbol])
	end
	private
	def serialize
		YAML.dump self
	end
	def self.next_id
		
		# Gera erros se apagar o arquivo manualmente
		#def self.next_id
		#	Dir.glob("db/revistas/*.yml").size + 1
		#end
		arq = Dir.glob("db/revistas/*.yml")
		return 1 if arq.empty?
		id_exitentes = arq.map {|arq| File.basename(arq,'yml').to_i}
		id_exitentes.max + 1
	end
	
end