class ScriptsController < ApplicationController
  def server
    @artist = Artist.find(:all,:conditions=>["Name=:id",params])
    if @artist[0].nil?
      respond_to do |format|
        format.xml { render :xml => "<message>empty</message>" }
      end
    else
      @room = Room.find(:all,:conditions=>["Name=:id",{:id=>@artist[0].RoomName}])  
      if @room[0].nil?
        respond_to do |format|
          format.xml { render :xml => "<message>empty</message>" }
        end
      else
        initPort = 4465
        sign = true
        dictionary = {}
        artistArray = @room[0].Artists.split(",")
        personCount = artistArray.length
        personIndex = 1
        currentPersonIndex = 1
        artistArray.each {|a|
          dictionary[a]=Artist.find(:all,:conditions=>["Name=:id",{:id=>a}])[0]
    		  if dictionary[a].nil?
      			sign = false
      			break
    		  end
          #dictionary[a].Index=personIndex
          if (a == params[:id])
            currentPersonIndex = personIndex
          end
          sign &= (dictionary[a].Status >= 1)
          personIndex += 1
        }
        respond_to do |format|
          if sign
            str = ""
            str << "<chanels>"
            for i in 1..personCount-1
              str << "<chanel name='' ip='' port='"+(initPort+(personCount-1)*(currentPersonIndex-1)+i).to_s+"' />"
            end
            str << "</chanels>"
            format.xml { render :xml => str}
          else
            format.xml { render :xml => "<message>waiting</message>" }
          end
        end
      end
    end
  end
  def client
    @artist = Artist.find(:all,:conditions=>["Name=:id",params])
    if @artist[0].nil?
      respond_to do |format|
        format.xml { render :xml => "<message>empty</message>" }
      end
    else
      @room = Room.find(:all,:conditions=>["Name=:id",{:id=>@artist[0].RoomName}])
      if @room[0].nil?
        respond_to do |format|
          format.xml { render :xml => "<message>empty</message>" }
        end
      else
        initPort = 4465
        sign = true
        dictionary = {}
        artistArray = @room[0].Artists.split(",")
        personCount = artistArray.length
        personIndex = 1
        currentPersonIndex = 0
        artistArray.each {|a|
          dictionary[a]=Artist.find(:all,:conditions=>["Name=:id",{:id=>a}])[0]
    		  if dictionary[a].nil?
      			sign = false
      			break
    		  end
          dictionary[a].Index=personIndex
          if (a == params[:id])
            currentPersonIndex = personIndex
          end
          sign &= (dictionary[a].Status >= 2)
          personIndex += 1
        }
        respond_to do |format|
          if sign
            str = ""
            str << "<chanels>"
            artistArray.each {|a|
              if (a != params[:id])
                if dictionary[a].Index < currentPersonIndex
                  str << "<chanel name='"+dictionary[a].Name+"' ip='"+dictionary[a].IP+"' port='"+(initPort+(dictionary[a].Index-1)*(personCount-1)+currentPersonIndex-1).to_s+"' />"
                else
                  str << "<chanel name='"+dictionary[a].Name+"' ip='"+dictionary[a].IP+"' port='"+(initPort+(dictionary[a].Index-1)*(personCount-1)+currentPersonIndex).to_s+"' />"
                end
              end
            }
            str << "</chanels>"
            format.xml { render :xml => str}
          else
            format.xml { render :xml => "<message>waiting</message>" }
          end
        end
      end
    end
  end
end
