class LookupController < ApplicationController
  respond_to :json

  def definition
    render :json => {:result => Lookup::Definition.lookup(params[:word])}
  end

  def translation
    render :json => {:result => Lookup::Translation.lookup(params[:word]).join(", ")}
  end

  def example
    render :json => {:result => Lookup::Example.lookup(params[:word]).join(".\n")}
  end
end
