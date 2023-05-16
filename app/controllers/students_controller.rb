class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

    # GET /students
    def index 
        students = Student.all
        render json: students, status: :ok
    end

    # GET /students/:id
    def show
        student = Student.find(params[:id])
        render json: student, status: :ok
    end

    # POST /student
    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    # UPDATE /student/:id
    def update
        student = Student.find(params[:id])
        student.update!(student_params)
        render json: student, status: :created
    end

    # DELETE /student/:id
    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private 
    
    def student_params
        params.permit(:name, :age, :major, :instructor_id)
    end

    def render_not_found_response
        render json: {
            error: "Student not found"
            },
             status: :not_found
    end

    def render_invalid_response(invalid)
        render json: { 
            errors: invalid.record.errors.full_messages
            },
             status: :unprocessable_entity
    end

end
