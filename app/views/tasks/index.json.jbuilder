json.array!(@tasks) do |task|
  json.extract! task, :id, :owner_id, :value, :completed, :category, :overdue, :assignee_id
  json.url task_url(task, format: :json)
end
