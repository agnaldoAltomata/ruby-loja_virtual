require 'yaml'
require 'fileutils'
require "active_file/version"

module ActiveFile
  #Asim não funciona na versão 4 
  #def included(base)
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      attr_reader :id, :destroyed, :new_record
      def initialize(parametrs={})
        @id = self.class.next_id
        @destroyed = false
        @new_record = true
        parametrs.each do |key,value|
          instance_variable_set "@#{key}",value
        end
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

        #tornando metodo de classe funcional melhor
        def next_id
          arq = Dir.glob("db/revistas/*.yml")
          return 1 if arq.empty?
          id_exitentes = arq.map {|arq| File.basename(arq,'yml').to_i}
          id_exitentes.max + 1
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
    
        #mais simples
        def field(name)
          @fields ||= []
          @fields << name
          attr_accessor name
        end
        def method_missing(name, *args, &block)
          method_name = name.to_s
          argument = args.first

          if method_name.start_with?("find_by_")
          
            field = method_name.sub("find_by_","")
          
            load_all.select do |object|
              #object.send(field) == args.first
              should_select? object,field,argument 
            end
          
          else
            super
          end

        end
        private
        def should_select?(object,field,argument)
          if argument.kind_of? Regexp
            object.send(field) =~ argument
          end
        end
        def respond_to_missing?(name, include_private = false)
          name.to_s.start_with?("find_by_") || super
        end
        
        def load_all
          Dir.glob("db/revistas/*.yml").map do |file|
            deserialize file
          end
        end
        def deserialize(file)
          obj = File.open(file,"r")
          YAML.safe_load(obj,permitted_classes:[Revista,Symbol])
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