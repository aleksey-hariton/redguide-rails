errors = []
if defined?(error_obj) && error_obj.errors.any?
  errors += error_obj.errors.full_messages
end

flash.each do |name, msg|
  errors << "#{name} - #{msg}"
end

json.errors errors