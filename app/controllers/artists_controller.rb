class ArtistsController < ApplicationController
  # GET /artists/1.xml
  def show
    @artist = Artist.find(:all,:conditions=>["Name=:id",params])
    respond_to do |format|
      if @artist[0].nil?
        format.xml { render :xml => "<message>empty</message>" }
      else
        if params[:status].nil?
          format.xml { render :xml => @artist[0] }
        else
          @artist[0].Status = params[:status]
          if @artist[0].save
            format.xml { render :xml => @artist[0] }
          else
            format.xml { render :xml => "<message>error</message>" }
          end
        end
      end
    end
  end
  
  # POST /artists.xml
  def create
    @artist = Artist.new(params[:artist])
    respond_to do |format|
      if @artist.save
        format.xml { render :xml => @artist }
      else
        format.xml { render :xml => "<message>error</message>" }
      end
    end
  end
end
