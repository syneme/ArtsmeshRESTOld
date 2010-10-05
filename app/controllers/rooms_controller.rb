class RoomsController < ApplicationController
  def show
    if params[:status].nil?
      @room = Room.find(:all,:conditions=>["Name=:id",params])
      respond_to do |format|
        if @room[0].nil?
          format.xml { render :xml => "<message>empty</message>" }
        else
          format.xml { render :xml => @room[0] }
        end
      end
    else
      case params[:status]
      when "delete"
        Script.find(:all).each{|r| r.destroy}
        #Artist.find(:all).each{|r| r.destroy}
        #Room.find(:all).each{|r| r.destroy}
        Artist.find(:all,:conditions=>["RoomName=:id",params]).each{|r| r.destroy}
        Room.find(:all,:conditions=>["Name=:id",params]).each{|r| r.destroy}
        respond_to do |format|
          format.xml { render :xml => "<message>ok</message>" }
        end
      when "remove"
        Room.find(:all).each{|r|
          if r.Artists.include?params[:id]
            r.Artists=","+r.Artists
            r.Artists=r.Artists.gsub(","+params[:id],"")
            r.Artists=r.Artists[1..r.Artists.length]
            r.save
          end
        }
        respond_to do |format|
          format.xml { render :xml => "<message>ok</message>" }
        end
      else
        Room.find(:all).each{|r|
          if r.Artists.include?params[:id]
            @room = r
            break
          end
        }
        respond_to do |format|
          if @room.nil?
            format.xml { render :xml => "<message>empty</message>" }
          else
            format.xml { render :xml => @room }
          end
        end
      end
    end
  end
  def create
    @room = Room.new(params[:room])
    respond_to do |format|
      if @room.save
        format.xml { render :xml => @room }
      else
        format.xml { render :xml => "<message>error</message>" }
      end
    end
  end
end
