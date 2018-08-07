require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'
class InteractiveRecord
  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    sql = <<-SQL
          PRAGMA table_info(#{self.table_name})
          SQL
    table_information = DB[:conn].execute(sql)
    column_names = []
    table_information.each do |column|
      column_names << column["name"]
    end
    column_names
  end

  def initialize(hash_of_attributes={})
    hash_of_attributes.
    hash_of_attributes.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end

  def table_name_for_insert
    self.class.table_name
  end

  def col_names_for_insert
    self.class.column_names.delete_if do |name|
      name == "id"
    end.join(", ")
  end
  
end
