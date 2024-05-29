class StudentTeacherSubjects < ActiveRecord::Migration[7.1]
  def change
    create_table :student_teacher_subjects do |t|
      t.integer :teacher_id, null: false
      t.integer :student_id, null: false
      t.integer :subject_id, null: false

      t.timestamps
    end

    add_foreign_key :student_teacher_subjects, :users, column: :teacher_id
    add_foreign_key :student_teacher_subjects, :users, column: :student_id
    add_foreign_key :student_teacher_subjects, :subjects, column: :subject_id

    add_index :student_teacher_subjects, :teacher_id
    add_index :student_teacher_subjects, :student_id
    add_index :student_teacher_subjects, :subject_id
    add_index :student_teacher_subjects, [:teacher_id, :student_id, :subject_id], unique: true, name: 'index_student_teacher_subjects_on_teacher_student_subject'
  end
end
