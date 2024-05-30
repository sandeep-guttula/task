class StudentTeacherSubject < ApplicationRecord
  # belongs_to :teacher, class_name: 'User'
  # belongs_to :student, class_name: 'User'
  # belongs_to :subject

  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
  belongs_to :subject
end
