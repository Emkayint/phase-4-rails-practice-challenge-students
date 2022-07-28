class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_params
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  
  def index
    render json: Student.all, status: :ok
  end

  def show
    student = Student.find(params[:id])
    render json: student, include: :instructor, status: :ok
  end

  def update
    student = Student.find(params[:id])
    student.update!(student_params)
    render json: student, status: :ok

  end

  def destroy
  end

  private
  def student_params
    params.permit(:name, :major, :age, :id, :instructor_id)
  end

  def render_not_found_response
    render json: { error: "Student not found"}, status: :not_found
  end

  def render_invalid_params(invalid)
    render json: { errors: invalid.record.errors}, status: :unprocessable_entity
  end
end
