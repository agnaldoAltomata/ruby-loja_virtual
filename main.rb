#Testar as classes
#
#Carrega as classes
require File.expand_path('lib/loja_virtual.rb')


windows = DVD.new "Windows 7 for Dummies", 198.9, :sistemas_operacionais
p windows.valor_por_extenso

