require 'rails/generators/base'

module VisualEnvironments
  module Generators
    class InstallGenerator < Rails::Generators::Base
    
      def copy_initializer_file
        copy_file File.expand_path("../templates/initializer.rb", __FILE__), "config/initializers/visual-environment.rb"
      end

      def self.banner
        "rails generate visual-environments:install"
      end

      private

      def add_gem(name, options = {})
        gemfile_content = File.read(destination_path("Gemfile"))
        File.open(destination_path("Gemfile"), 'a') { |f| f.write("\n") } unless gemfile_content =~ /\n\Z/
        gem name, options unless gemfile_content.include? name
      end

      def print_usage
        self.class.help(Thor::Base.shell.new)
        exit
      end
  
    end
  end
end