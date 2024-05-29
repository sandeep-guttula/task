class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all
    if current_user && current_user.role == "teacher"
      @subjects = get_current_teacher_subjects
      @my_students = get_current_teacher_students
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
    student_ids = StudentTeacherSubject.where(teacher_id: current_user.id).pluck(:student_id)

    @students = User.where(role: 'student').includes(:subjects, :teachers).all

  end

  def new_student
    @user = User.new
    @subjects = get_current_teacher_subjects
  end

  def create_student
    student = User.new(user_params)
    student.role = "student"
    if student.save
      redirect_to users_path, notice: "Student created successfully"
    else
      render :new , notice: "Student creation failed"
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

end
