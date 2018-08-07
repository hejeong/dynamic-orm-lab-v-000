require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'
class InteractiveRecord
  def self.table_name
    self.class.downcase.pluralize
  end
end
