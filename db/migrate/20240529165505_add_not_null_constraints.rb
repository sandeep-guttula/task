class AddNotNullConstraints < ActiveRecord::Migration[7.1]
  def change
    change_column_null :subjects, :name, false
    change_column_null :user_active_sessions, :session_id, false
    change_column_null :user_active_sessions, :status, false
    change_column_null :user_active_sessions, :session_expiry, false
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
    change_column_null :users, :role, false
    change_column_null :users, :name, false
  end
end
