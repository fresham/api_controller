class Api::V<%= version %>::<%= model.capitalize %>ApiController < ApplicationController

  # GET /api/v<%= version %>/<%= model %>
  # GET /api/v<%= version %>/<%= model %>.xml
  # GET /api/v<%= version %>/<%= model %>.json
  def index
    @<%= model %> = <%= model.classify %>.all

    respond_to do |format|
      format.xml {render :xml => @<%= model %>}
      format.json {render :json => @<%= model %>}
    end
  end

  # GET /api/v<%= version %>/<%= model %>/1
  # GET /api/v<%= version %>/<%= model %>/1.xml
  # GET /api/v<%= version %>/<%= model %>/1.json
  def show
    @<%= model.singularize %> = <%= model.classify %>.find(params[:id])

    respond_to do |format|
      format.xml {render :xml => @<%= model.singularize %>}
      format.json {render :json => @<%= model.singularize %>}
    end
  end

end
