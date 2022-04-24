class SearchesController < ApplicationController
  def search
    @model = search_params[:model]
    @method = search_params[:method]
    @word = search_params[:word]

    @results = @model.constantize.search(@method, @word)
  end

  def search_params
    params.require(:search).permit(:model, :method, :word)
  end
end
