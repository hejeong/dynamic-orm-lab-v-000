require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'
class InteractiveRecord
  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    info = DB[:conn].execute("PRAGMA table_info(#{self.table_name})")
    names = []
    info.each do |info_hash|
      names << info_hash["name"]
    end
    names
  end

  def initialize(attribute_hash = {})
    attribute_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end

  def table_name_for_insert
    self.class.to_s.downcase.pluralize
  end

  def col_names_for_insert
    self.class.column_names.delete_if do |name|
      name == "id"
    end.join(", ")
  end

  def values_for_insert
    columns = self.class.column_names.delete_if {|name| name == "id"}
    values = self.class.column_names.map do |name|
      if name != "id"
        self.send(name)
      end
    end
    values.join(", ")
  end
end
