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
end
