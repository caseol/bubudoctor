# == Schema Information
#
# Table name: exams
#
#  id         :integer          not null, primary key
#  patient_id :integer
#  title      :string
#  conclusion :text
#  exam_hash  :text
#  date_done  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Exam < ApplicationRecord
  #after_initialize :add_field_accessors
  #after_save       :add_field_accessors
  #after_initialize :set_exam_table
  belongs_to :patient, inverse_of: :exams
  has_many_attached :exam_files

  serialize :exam_table, Array
  #store_accessor :exam_table, :data

  validates_presence_of :patient_id, :date_done, :title


=begin
  def add_store_accessor field_name
    singleton_class.class_eval {store_accessor self.exam_values, field_name}
  end
=end

=begin
  def add_field_accessors
    num_fields = self.exam_hash.try(:keys).try(:count) || 0
    options.keys.each {|field_name| add_store_accessor field_name} if num_fields > 0
  end
=end

end
