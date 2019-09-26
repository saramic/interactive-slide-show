class GraphqlController < ApplicationController
  # rubocop:disable Metrics/MethodLength
  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      # current_user: current_user,
    }
    result = InteractiveSlideShowSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name
    )
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end
  # rubocop:enable Metrics/MethodLength

  private

  # Handle form data, JSON body, or a blank value
  # rubocop:disable Metrics/MethodLength
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
  # rubocop:enable Metrics/MethodLength

  # rubocop:disable Naming/UncommunicativeMethodParamName
  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: {
      error: {
        message: e.message, backtrace: e.backtrace
      }, data: {}
    }, status: 500
  end
  # rubocop:enable Naming/UncommunicativeMethodParamName
end
