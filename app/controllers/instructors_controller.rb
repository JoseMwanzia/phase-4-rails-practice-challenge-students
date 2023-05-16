class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

# GET /instructors
    def index 
        instructors = Instructor.all
        render json: instructors, status: :ok
    end

# GET /instructors/:id
    def show
        instructor = Instructor.find(params[:id])
        render json: instructor, status: :ok
    end

# POST /instructor
    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end
# UPDATE /instructor/:id
    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor, status: :created
    end

# DELETE /instructor/:id
    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    private
    def render_not_found_response
        render json: {
            error: "Instructor not found"
            },
             status: :not_found
    end

    def instructor_params
        params.permit(:name)
    end

    def render_invalid_response(invalid)
        render json: { 
            errors: invalid.record.errors.full_messages
            },
             status: :unprocessable_entity
    end
end
