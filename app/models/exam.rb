class Exam < ApplicationRecord
  after_initialize :add_field_accessors
  after_save       :add_field_accessors

  belongs_to :patient
  has_many_attached :files

  serialize :exam_values, Hash

  def add_store_accessor field_name
    singleton_class.class_eval {store_accessor self.exam_values, field_name}
  end

  def add_field_accessors
    num_fields = self.exam_values.try(:keys).try(:count) || 0
    options.keys.each {|field_name| add_store_accessor field_name} if num_fields > 0
  end

end
