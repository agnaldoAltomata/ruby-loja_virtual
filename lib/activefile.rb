require 'yaml'
require 'fileutils'

module ActiveFile
  #Asim não funciona na versão 4 
  #def included(base)
	def self.included(base)
		base.extend ClassMethods
		base.class_eval do
			attr_reader :id, :destroyed, :new_record
			def initialize
				@id = self.class.next_id
				@destroyed = false
				@new_record = true
			end
		end
	end
	def save
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

	module ClassMethods
		def find(id)
			path = "db/revistas/#{id}.yml"
			unless File.exist?(path)
				raise DocumentNotFound,"Arquivo db/revistas/#{id} não encontrado.",caller
			end
			obj = File.read(path)
			YAML.safe_load(obj,permitted_classes:[Revista,Symbol])
		end	
#    #metodo não funciona na verção 4
    #tambem muito confuso
    #def field(name)
    #    @fields ||= []
    #    @fields << name
    #    get = %Q{
    #      def #{name}
    #        @#{name}
    #      end
    #    }
    #    set = %Q{
    #      def #{name}=(valor)
    #        @#{name}=valor
    #      end
    #    }
    #   self.class_eval = get
    #   self.class_eval = set 
    #end
#    #mais simples
		def field(name)
			attr_accessor name
		end
    #tornando metodo de classe fnciol melhor
    def next_id
      arq = Dir.glob("db/revistas/*.yml")
      return 1 if arq.empty?
      id_exitentes = arq.map {|arq| File.basename(arq,'yml').to_i}
      id_exitentes.max + 1
    end
	end
	private
	def serialize
		YAML.dump self
	end
	#sobescreve a inicialização da linha 7 do module ActiveFile
  #def self.included(base)
  #  base.extend ClassMethods
  #end
end