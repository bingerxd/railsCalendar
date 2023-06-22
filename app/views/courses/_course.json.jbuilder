json.extract! course, :id, :course_name, :teacher_name, :email, :start_time, :end_time, :created_at, :updated_at
json.url course_url(course, format: :json)
