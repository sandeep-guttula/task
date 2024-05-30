class Subject < ApplicationRecord
  # has_many :student_teacher_subjects
  # has_many :students, through: :student_teacher_subjects
  # has_many :teachers, through: :student_teacher_subjects

  has_many :student_teacher_subjects
  has_many :students, through: :student_teacher_subjects, source: :student
end
