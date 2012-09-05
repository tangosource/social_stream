class SocialStream::Ostatus::InstallGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  
  source_root File.expand_path('../templates', __FILE__)
  
  def config_initializer
    copy_file 'initializer.rb', 'config/initializers/social_stream-ostatus.rb'
  end
  
  def inject_remote_user_relation
    append_file 'config/relations.yml',
                     "\nremote_subject:\n  friend:\n    name: friend\n    permissions:\n      - [ follow ]\n    sphere: personal\n"+
                                        "  public:\n    name: public\n    permissions:\n      - [ read, tie, star_tie ]\n    sphere: personal"  
  end

  require 'rails/generators/active_record'

  def self.next_migration_number(dirname)
    ActiveRecord::Generators::Base.next_migration_number(dirname)
  end

  def create_migration_file
    migration_template 'migration.rb', 'db/migrate/create_social_stream_ostatus.rb'
  end
end