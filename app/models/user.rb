class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true

  has_many :student_teacher_subjects, foreign_key: 'student_id', dependent: :destroy
  has_many :subjects, through: :student_teacher_subjects

  has_many :teacher_subjects, class_name: 'StudentTeacherSubject', foreign_key: 'teacher_id', dependent: :destroy
  has_many :students, through: :teacher_subjects, source: :sandeep

  validate :validate_password

  before_validation :authorize_teacher_create
  before_destroy :authorize_teacher_destroy

  def validate_password
    if password_digest.blank?
      errors.add(:password, "can't be blank")
      throw(:abort)
    end
  end


  # allow only teachers to create students and delete students
  def authorize_teacher_create
    if Current.user&.role != 'teacher'
      errors.add(:base, "Only teachers can create students")
      throw(:abort)
    end
  end

  def authorize_teacher_destroy
    if Current.user&.role != 'teacher'
      errors.add(:base, "Only teachers can delete students")
      throw(:abort)
    end
  end
end
