# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# User.create!(name: 'Teacher 01' ,email: 'teacher01@email.com', password: 'password', password_confirmation: 'password', role: 'teacher')
# User.create!(name: 'Teacher 02' ,email: 'teacher02@email.com', password: 'password', password_confirmation: 'password', role: 'teacher')
# User.create!(name: 'Teacher 03' ,email: 'teacher03@email.com', password: 'password', password_confirmation: 'password', role: 'teacher')
# User.create!(name: 'Teacher 04' ,email: 'teacher04@email.com', password: 'password', password_confirmation: 'password', role: 'teacher')


# User.create!(name: 'Student 01' ,email: 'student01@email.com', password: 'password', password_confirmation: 'password', role: 'student')
# User.create!(name: 'Student 02' ,email: 'student02@email.com', password: 'password', password_confirmation: 'password', role: 'student')
# User.create!(name: 'Student 03' ,email: 'student03@email.com', password: 'password', password_confirmation: 'password', role: 'student')
# User.create!(name: 'Student 04' ,email: 'student04@email.com', password: 'password', password_confirmation: 'password', role: 'student')
# User.create!(name: 'Student 05' ,email: 'student05@email.com', password: 'password', password_confirmation: 'password', role: 'student')
# User.create!(name: 'Student 06' ,email: 'student06@email.com', password: 'password', password_confirmation: 'password', role: 'student')
# User.create!(name: 'Student 07' ,email: 'student07@email.com', password: 'password', password_confirmation: 'password', role: 'student')
# User.create!(name: 'Student 08' ,email: 'student08@email.com', password: 'password', password_confirmation: 'password', role: 'student')


# Subject.create(name: "Mathematics")
# Subject.create(name: "Science")
# Subject.create(name: "History")
# Subject.create(name: "Geography")
# Subject.create(name: "English")
# Subject.create(name: "Kiswahili")
# Subject.create(name: "French")
# Subject.create(name: "German")
# Subject.create(name: "Spanish")
# Subject.create(name: "Chinese")
# Subject.create(name: "Japanese")
# Subject.create(name: "Arabic")
# Subject.create(name: "Music")
# Subject.create(name: "Art")


# TeacherSubject.create(user_id: 1, subject_id: 1)
# TeacherSubject.create(user_id: 1, subject_id: 2)
# TeacherSubject.create(user_id: 1, subject_id: 3)
# TeacherSubject.create(user_id: 2, subject_id: 1)
# TeacherSubject.create(user_id: 2, subject_id: 5)
# TeacherSubject.create(user_id: 2, subject_id: 6)
# TeacherSubject.create(user_id: 3, subject_id: 7)
# TeacherSubject.create(user_id: 3, subject_id: 8)


# StudentTeacherSubject.create(teacher_id: 1, student_id: 5, subject_id: 1)
# StudentTeacherSubject.create(teacher_id: 1, student_id: 6, subject_id: 1)
# StudentTeacherSubject.create(teacher_id: 1, student_id: 7, subject_id: 2)
# StudentTeacherSubject.create(teacher_id: 1, student_id: 8, subject_id: 3)


StudentTeacherSubject.create(teacher_id: 2, student_id: 9, subject_id: 1)
StudentTeacherSubject.create(teacher_id: 2, student_id: 10, subject_id: 1)
StudentTeacherSubject.create(teacher_id: 2, student_id: 11, subject_id: 5)
StudentTeacherSubject.create(teacher_id: 2, student_id: 12, subject_id: 6)
StudentTeacherSubject.create(teacher_id: 2, student_id: 15, subject_id: 6)
