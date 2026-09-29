require 'yaml'

class BancoDeArquivos
  ARQUIVO = 'livros.yaml'

  def salva(livro)
    File.open(ARQUIVO, 'a') do |arq|
      arq.puts YAML.dump(livro)
      arq.puts "" 
    end		
  end

  def carrega
	$/ = "\n\n"
	return [] unless File.exist?('livros.yaml')
	File.open('livros.yaml', 'r').map do |livro_serializado|
	    YAML.safe_load(livro_serializado, permitted_classes: [Livro,DVD, Symbol])
	  end
	ensure
	  $/ = "\n"
	end

end
