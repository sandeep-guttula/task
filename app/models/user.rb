class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true

  # has_many :teacher_subjects, class_name: 'StudentTeacherSubject', foreign_key: 'teacher_id'
  # has_many :students, through: :teacher_subjects, source: :student

  # has_many :student_subjects, class_name: 'StudentTeacherSubject', foreign_key: 'student_id'
  # has_many :teachers, through: :student_subjects, source: :teacher

  has_many :student_teacher_subjects, foreign_key: 'student_id', dependent: :destroy
  has_many :subjects, through: :student_teacher_subjects

  has_many :teacher_subjects, class_name: 'StudentTeacherSubject', foreign_key: 'teacher_id', dependent: :destroy
  has_many :students, through: :teacher_subjects, source: :student


end
