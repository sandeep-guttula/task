class CreateTeacherSubjects < ActiveRecord::Migration[7.1]
  def change
    create_table :teacher_subjects do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
