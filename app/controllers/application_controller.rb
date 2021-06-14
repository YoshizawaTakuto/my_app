class ApplicationController < ActionController::Base
    before_action :login_user
    

    def login_user
        if session[:user_id]
            @login_user = User.find_by(id: session[:user_id])
        end
    end

    def no_login
        if session[:user_id] == nil
            flash[:notice] = "ログインしてください"
            redirect_to login_form_path
        end
    end

    def set_login
        if @login_user
            flash[:notice] = "すでにログインしています"
            redirect_to "/"
        end
    end
end
