class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  get '/figures/new' do
    erb :"figures/new"
  end

  post '/figures' do
    @figure = Figure.new(:name => params["figure"]["name"])

    if !!params["figure"]["title_ids"]
      params["figure"]["title_ids"].each do |title_id|
        @figure.titles << Title.find(title_id)
      end
    end

    if !params["title"].empty?
      @figure.titles << Title.find_or_create_by(params["title"])
    end


    if !!params["figure"]["landmark_ids"]
      params["figure"]["landmark_ids"].each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end

    if !params["landmark"].empty?
      @figure.landmarks << Landmark.find_or_create_by(params["landmark"])
    end
    @figure.save

    redirect "/figures/#{@figure.id}"
  end


  get '/figures/:id' do
    @figure = Figure.find(params[:id])

    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])

    erb :"figures/edit"
  end

  patch '/figures/:id' do
    raise params.inspect
    @figure = Figure.find(params[:id])
    @figure.titles.clear
    @figure.landmarks.clear

    if !!params["figure"]["title_ids"]
      params["figure"]["title_ids"].each do |title_id|
        @figure.titles << Title.find(title_id)
      end
    end

    if !params["title"].empty?
      @figure.titles << Title.find_or_create_by(params["title"])
    end


    if !!params["figure"]["landmark_ids"]
      params["figure"]["landmark_ids"].each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end

    if !params["landmark"].empty?
      @figure.landmarks << Landmark.find_or_create_by(params["landmark"])
    end

    @figure.save

    redirect "/figures/#{@figure.id}"
  end


end
