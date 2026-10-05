require "fileutils"

namespace :db do
	desc "Limpa o banco de dados file db/revistas/*.yml"
	task :clear do
		#FileUtils.rm Dir["db/revistas/*.yml"]
		puts "limpando"
	end
end
