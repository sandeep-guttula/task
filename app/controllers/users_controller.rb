class UsersController < ApplicationController

  before_action :authorize_teacher!, only: [:new_student, :create_student, :all_students, :show_student, :destroy_student]

  STUDENTS_PER_PAGE = 3

  def new
    @user = User.new
  end

  def index
    @users = User.all
    if current_user && current_user.role == "teacher"
      @subjects = get_current_teacher_subjects
      @my_students = get_current_teacher_students
      @
    elsif current_user && current_user.role == "student"
      @my_teachers = get_current_students_teachers
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def create
    # TODO: change the user field to not null in the db
    Rails.logger.info("User params: #{user_params} ----->")

    user = User.new(user_params)
    if user.save
      session_id = SecureRandom.uuid
      UserActiveSession.new(user_id: user.id, session_id: session_id, status: true, session_expiry: 30.minutes.from_now).save
      session[:user_session_id] = session_id
      redirect_to users_path, notice: "User created successfully"
    else
      render :new , notice: "User creation failed"
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end

  def all_students
    # SELECT u.name AS student_name, u.email, sts.teacher_id, t.name AS teacher_name, sts.subject_id, s.name AS subject_name, u.role
    # FROM users u LEFT JOIN student_teacher_subjects sts ON u.id = sts.student_id
    # LEFT JOIN subjects s ON s.id = sts.subject_id
    # LEFT JOIN users t ON t.id = sts.teacher_id
    # WHERE u.role = 'student';

      # @students = User.where(role: 'student')
      # .select('users.id, users.name as student_name, users.email, student_teacher_subjects.teacher_id, users.name as teacher_name, student_teacher_subjects.subject_id, subjects.name as subject_name, users.role')
      # .joins('LEFT JOIN student_teacher_subjects ON users.id = student_teacher_subjects.student_id')
      # .joins('LEFT JOIN subjects ON student_teacher_subjects.subject_id = subjects.id')
      # .joins('LEFT JOIN users ON student_teacher_subjects.teacher_id = users.id')

      @students = User.where(role: 'student').select('users.id, users.name , users.email, student_teacher_subjects.teacher_id, t.name as teacher_name, student_teacher_subjects.subject_id, subjects.name
      as subject_name, users.role ').joins('LEFT JOIN student_teacher_subjects ON users.id = student_teacher_subjects.student_id').joins('LEFT JOIN subjects ON student_teacher_subjects.subject_id = subjects.
     id').joins('LEFT JOIN users as t  ON student_teacher_subjects.teacher_id = t.id')
  end

  def new_student
    @user = User.new
    @subjects = get_current_teacher_subjects
  end

  def create_student
    student = User.new(user_params)
    student.role = "student"
    if student.save
      StudentTeacherSubject.new(teacher_id: current_user.id, student_id: student.id, subject_id: params[:user][:id]).save
      redirect_to users_path, notice: "Student created successfully"
    else
      render :new_student, notice: "Student creation failed"
    end
  end

  def show_student
    @student = User.find_by(id: params[:id])
  end

  def destroy_student
    student = User.find(params[:id])
    student.destroy
    redirect_to users_path, notice: "Student deleted successfully"
  end


  def show_teacher
    if current_user.role == "student"
      @teacher = User.find_by(id: params[:id])
    else
      redirect_to users_path, notice: "You are not allowed to view this page"
    end
  end



  private


  def user_params
    params.require(:user).permit(:name, :email, :role, :password, :password_confirmation)
  end

  def get_current_teacher_subjects
    TeacherSubject.where(user_id: current_user.id).map(&:subject)
  end

  def get_current_teacher_students
    student_ids = StudentTeacherSubject.where(teacher_id: current_user.id).pluck(:student_id)
    User.where(role: 'student', id: student_ids)
    .select('users.id, users.name, users.email, student_teacher_subjects.subject_id, subjects.name as subject_name')
    .joins('JOIN student_teacher_subjects ON users.id = student_teacher_subjects.student_id')
    .joins('JOIN subjects ON student_teacher_subjects.subject_id = subjects.id')
  end

  def get_current_students_teachers
    teacher_ids = StudentTeacherSubject.where(student_id: current_user.id).pluck(:teacher_id)
    User.where(role: 'teacher', id: teacher_ids)
    .select('users.id, users.name, users.email, student_teacher_subjects.subject_id, subjects.name as subject_name')
    .joins('JOIN student_teacher_subjects ON users.id = student_teacher_subjects.teacher_id')
    .joins('JOIN subjects ON student_teacher_subjects.subject_id = subjects.id').distinct

  end

  def authorize_teacher!
    if current_user.role != "teacher"
      redirect_to users_path, alert: "You are not allowed to view that page"
    end
  end

end
