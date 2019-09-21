# rubocop:disable Metrics/LineLength
module Admin
  class SlideshowsController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   foo = Foo.find(params[:id])
    #   foo.update(params[:foo])
    #   send_foo_updated_email
    # end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #  if current_user.super_admin?
    #    resource_class
    #  else
    #    resource_class.with_less_stuff
    #  end
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    # overwritten from original, is there a better way to set scope for current_user?
    # gems/administrate-0.12.0/app/controllers/administrate/application_controller.rb

    # rubocop:disable Metrics/MethodLength
    def create
      resource = resource_class.new(
        # override with current user
        resource_params.merge(user_id: current_user.id)
      )
      authorize_resource(resource)

      if resource.save
        redirect_to(
          [namespace, resource],
          notice: translate_with_resource("create.success")
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource)
        }
      end
    end

    # rubocop:enable Metrics/MethodLength
  end
end

# rubocop:enable Metrics/LineLength
