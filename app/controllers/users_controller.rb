class UsersController < ApplicationController
  def show
    case params[:status]
    when "delete"
      @user = User.find(:all,:conditions=>["Name=:id",params])
      respond_to do |format|
        if @user[0].nil?
          format.xml { render :xml => "<message>empty</message>" }
        else
          @user[0].destroy
          format.xml { render :xml => "<message>ok</message>" }
        end
      end
    else
      case params[:id]
      when "delete"
        User.find(:all).each{|r| r.destroy}
        respond_to do |format|
          format.xml { render :xml => "<message>ok!</message>" }
        end
      when "all"
        respond_to do |format|
          format.xml { render :xml => User.find(:all) }
        end
      else
        @user = User.find(:all,:conditions=>["Name=:id",params])
        respond_to do |format|
          if @user[0].nil?
            format.xml { render :xml => "<message>empty</message>" }
          else
            format.xml { render :xml => @user[0] }
          end
        end
      end
    end
  end
  def create
    @user = User.new(params[:user])
    @users = User.find(:all,:conditions=>["Name=:Name",@user])
    respond_to do |format|
      if @users[0].nil?
        if @user.save
          format.xml  { render :xml => @user }
        else
          format.xml { render :xml => "<message>error</message>" }
        end
      else
        format.xml { render :xml => "<message>login</message>" }
      end
    end
  end
end