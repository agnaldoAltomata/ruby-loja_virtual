require "fileutils"

namespace :db do
	desc "Limpa o banco de dados file db/NAME_PATH/*.yml"
	#remove com o nome do arquivo e estenção
	#task :clear, [:folder, :file_extension] do |task, args|
	#FileUtils.rm Dir["db/#{args.folder}/*.#{args.file_extension}"]
	
	task :clear,[:folder] do|task,args|
		arquivos = Dir.glob("db/#{args.folder}/*.yml")
		FileUtils.rm_f(arquivos) unless arquivos.empty?
	end
	desc "Popula com os dados definidos no arquivo db/folder/"
	task :seed,[:folder] do |task,args|
		seed_file = File.expand_path "db/#{args.folder}/seeds.rb"
		load(seed_file) if File.exist?(seed_file)
	end
	desc "Popula com os dados definidos no arquivo db/folder/seeds.rb"
	task :reseed,[:folder]=>["db:clear","db:seed"]do
		puts "Feito"
	end
end
