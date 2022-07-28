class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_inputs

  def index
    render json: Instructor.all, status: :ok
  end

  def show
    instructor = Instructor.find(params[:id])
    render json: instructor, status: :ok
  end

  def update
    instructor = Instructor.find(params[:id])
    # byebug
    instructor.name = params[:name]
    instructor.save!
    render json: instructor
  end

  def destroy
    instructor = Instructor.find(params[:id])
    instructor.destroy
    head :no_content
  end

  private

  def instructor_params
    params.permit(:name, :id)
  end

  def render_not_found_response
    render json: { error: "Instructor not found"}, status: :not_found
  end

  def invalid_inputs(invalid)
    render json: { errors: invalid.record.errors}, status: :unprocessable_entity
  end
end
