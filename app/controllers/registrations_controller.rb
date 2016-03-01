class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    resource.class.transaction do
      resource.save
      yield resource if block_given?
      if resource.persisted?
        @payment = Payment.new({ email: params["user"]["email"],
                                token: params[:payment]["token"], user_id: resource.id })
        
        flash[:error] = "Please check registration errors" unless @payment.valid?
        
        begin
          @payment.process_payment
          @payment.save
        rescue Exception => e
          flash[:error] = e.message
          resource.destroy
          puts 'Payment failed'
          render :new and return
        end

        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end

      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  end
 
  protected 

  def after_sign_up_path_for(resource)
    session.delete(:return_to) || current_user
  end
   
  
  def after_update_path_for(resource)
    current_user
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :payment)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end

end