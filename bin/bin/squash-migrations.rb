#!/usr/bin/env ruby
require 'erb'

structure_version=`git ls-files db/migrate/*.rb | sort | tail -1`.gsub(/[^\d]/, '')
migration_file=%(db/migrate/#{structure_version}_create_database.rb)

migration = ERB.new <<-'EOMIGRATION'
class CreateDatabase < ActiveRecord::Migration[7.1]
  def up
    execute File.read("#{Rails.root}/db/migrate/<%= structure_version %>_structure.sql")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
EOMIGRATION

%x(git rm -f db/migrate/*.rb db/migrate/*_structure.sql;
  mkdir db/migrate;
  git mv db/structure.sql db/migrate/#{structure_version}_structure.sql;
  )
File.write(migration_file, migration.result)
%x(bundle exec rails db:migrate)
