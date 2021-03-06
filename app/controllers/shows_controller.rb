class ShowsController < ApplicationController
	load_and_authorize_resource
	before_action :load_authorize_parent

	def index
		@shows = @movie.shows.paginate(:page=>params[:page],:per_page=>10)
	end

	def show
		@shows = @movie.shows.group_by {|x| x.theatre.name}
	end

	def new
	end

	def edit
	end

	def create
		@show = @movie.shows.new(show_params)
		@show.endtime = (@show.starttime.to_time + @movie.duration.hours).to_datetime
		respond_to do |format|
			if @show.save
				format.html { redirect_to movie_shows_path(@movie), notice: 'Show was successfully created.' }
				format.json { render :show, status: :created, location: @show }
			else
				format.html { render :new }
				format.json { render json: @show.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @show.update(show_params)
				format.html { redirect_to movie_shows_path(@movie), notice: 'Show was successfully updated.' }
				format.json { render :show, status: :ok, location: @show }
			else
				format.html { render :edit }
				format.json { render json: @show.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@show.destroy
		respond_to do |format|
			format.html { redirect_to movie_shows_path(@movie), notice: 'Show was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private

	def show_params
		params.require(:show).permit(:starttime, :endtime, :screen_id,:theatre_id)
	end

	def load_authorize_parent
		if params[:movie_id].present?
			@movie = Movie.find(params[:movie_id])
		end
	end

end