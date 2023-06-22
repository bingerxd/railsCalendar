json.extract! consultation, :id, :consultation_name, :teacher_name, :email, :date, :time_start, :time_end, :created_at, :updated_at
json.url consultation_url(consultation, format: :json)
