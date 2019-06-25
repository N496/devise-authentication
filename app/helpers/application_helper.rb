module ApplicationHelper
  REACT_URL = ''
  HTTP_CREATED = 201
  HTTP_OK = 200
  HTTP_BAD_REQUEST = 400
  HTTP_NOT_FOUND = 404
  HTTP_UNAUTHORIZED = 401
  HTTP_METHOD_NOT_ALLOWED = 405
  HTTP_INTERNAL_SERVER_ERROR = 500
  def unauthorize_http_response(msg=nil)
    render json: {
      success: false, errors:[ msg ]
    }, status: HTTP_UNAUTHORIZED
  end

  def error_response(obj, errors=nil)
    action = obj.new_record? ? 'create' : 'update'
    custom_error = errors.nil? ? "Failed to #{action} #{obj.class.to_s.downcase} !" : errors
    render json: {
      success: false, errors: obj.errors.full_messages || custom_error
    }, status: HTTP_BAD_REQUEST
  end

  def error_response_without_obj(errors=nil)
    errors  = ' ' unless errors.present?
    render json: {
      success: false, errors: [ errors ]
    }, status: HTTP_BAD_REQUEST
  end

  def success_response(msg=nil)
    message = msg.nil? ? "Successfully Done!" : msg
    render json: {
      success: true, message: message
    }, status: HTTP_OK
  end

  def success_response_create(msg=nil)
    message = msg.nil? ? "Successfully #{action} #{obj.class.to_s.downcase} !" : msg
    render json: {
      success: true, message: message
    }, status: HTTP_CREATED
  end

  def success_response_without_option(obj=nil, msg=nil)
    if obj.present?
      action = obj.new_record? ? 'created' : 'updated'
    end
    message = msg.nil? ? "Successfully #{action} #{obj.class.to_s.downcase} !" : msg
    render json: {
      success: true, message: message,
      "#{obj.class.name.underscore}": { id: "#{obj.id}" },
    }, status: HTTP_CREATED
  end

  def destroy_response(obj=nil, msg=nil)
    message = msg.nil? ? "Successfully deleted #{obj.class.to_s.downcase}" : msg
    render json: {
      success: true, message: message
    }, status: HTTP_OK
  end

  def no_data_found(msg=nil)
    message = msg.present? ? msg : 'Opps. No data found !'
    render json: {
      success: false, errors: [ message ]
    }, status: HTTP_NOT_FOUND
  end

  def already_exist(msg=nil)
    message = msg.present? ? msg : 'Opps. already exist !'
    render json: {
      success: false, message: message
    }, status: HTTP_OK
  end

  def success_response_with_object(obj, msg=nil, options={})
    message = msg.present? ? msg : ' '
    render json: {
      success: true,
      isConfirmed: false,
      "#{obj.class.to_s.downcase}": { id: "#{obj.id}" , email: "#{obj.email}" } ,
      message: message
    }, status: HTTP_CREATED
  end
end
