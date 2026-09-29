#encoding: utf-8
class Relatorio

	def initialize(biblioteca)
		@biblioteca = biblioteca
	end
	def titulos
		#titulos = []
		#@biblioteca.livros.each do |livro|
		#	titulos << livro.titulo
		#end
		#titulos
		@biblioteca.livros.map {|livro| livro.titulo}
	end
	def total

		#soma = 0.0
		#@biblioteca.livros.each do |livro|
		#	soma += livro.preco
		#end
		#soma
		@biblioteca.livros.inject(0){|tot,livro| tot += livro.preco}
	end
	
end