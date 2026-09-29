
require File.expand_path('lib/loja_virtual.rb')


begin
	Revista.find 42
rescue DocumentNotFound => e 
	p e.mensagem_formatada
end