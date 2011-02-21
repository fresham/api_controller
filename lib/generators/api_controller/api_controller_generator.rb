require 'rails/generators'
class ApiControllerGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :model, :type => :string
  class_option :version, :type => :string, :default => 'current',
    :description => 'API version to add to.'

  def create_api_directories
    make_dir "#{RAILS_ROOT}/app/controllers/api"
    make_dir "#{RAILS_ROOT}/app/controllers/api/v#{version}"
  end

  def generate_api_controller
    structure = "api/v#{version}/"
    template 'api_controller.rb', "app/controllers/#{structure}#{model}_api_controller.rb"
    template 'api_controller_test.rb', "test/functional/#{structure}#{model}_api_test.rb"
  end

  def adjust_routes
    create_routes
  end

  private

  def version
    return latest_version if options.version.eql? 'current'
    options.version
  end

  def latest_version
    return '1' if versions.empty?
    versions.collect {|version| version.sub('v', '')}.sort.last
  end

  def versions
    Dir.chdir "#{RAILS_ROOT}/app/controllers/api"
    Dir.glob('v*')
  end

  def make_dir(dir)
    Dir.mkdir dir unless File.directory?(dir)
  end

  def create_routes
    final = []
    File.open("#{RAILS_ROOT}/config/routes.rb", "r+") do |file|
      file.each do |line|
        final << line
        if line =~ /\w+::Application.routes.draw/
          final << <<-ROUTES

  namespace :api do
    namespace v#{version} do
      resources :#{model}, :controller => '#{model}_api',
        :only => [:index, :show, :create, :update, :destroy]
    end
  end

          ROUTES
        end
      end
      file.pos = 0
      file.puts final
    end
  end
end
