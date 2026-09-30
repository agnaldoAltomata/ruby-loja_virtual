
require File.expand_path('lib/loja_virtual.rb')

class Revista
	include ActiveFile
	field :titulo
	field :valor
end
