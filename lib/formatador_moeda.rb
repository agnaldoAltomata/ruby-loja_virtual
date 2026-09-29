module FormatadorMoeda
	def metodo_de_instancia
		"um mentodo de instancia"
	end
	module ClassMethods
		def formata_moeda(*variaveis_e_metodos)
			variaveis_e_metodos.each do |name|
				define_method("#{name}_formatado") do 
					valor= respond_to?(name)? send(name): instance_variable_get("@#{name}")
					"R$ #{valor}"
				end
			end
		end
	end

	def self.included(classe_que_incluiu_modulo)
		classe_que_incluiu_modulo.extend ClassMethods
	end

end