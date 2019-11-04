require 'open-uri'

class GamesController < ApplicationController
  def new
    @list_letters = (0...10).map { (65 + rand(26)).chr }
  end

  def score

    @answer = params[:answer].upcase
    @grid = params[:list_letters]

    def length(answer)
    @answer.length.to_i
    end
     @test3 = length(@answer)

    def time(start_time, end_time)
      ti = end_time - start_time
      1.0 / ti
     end

    def check_letters(answer, grid)
      @answer.chars.all? { |letter| @answer.count(letter) <= @grid.count(letter) }
    end
    @test = check_letters(@answer, @grid)

    def check_vocabulary(answer)
      url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
      serialized = open(url).read
      user = JSON.parse(serialized)
      user["found"]
    end
    @test2 = check_vocabulary(@answer)
  end


   def run_game(answer, grid, start_time, end_time)
   # TODO: runs the game and return detailed hash of result
   if check_letters(@answer.upcase, grid) && check_vocabulary(@answer)
     score = length(@answer) + time(start_time, end_time)
     @score = score
     @message = "well done"
   elsif !check_letters(@answer.upcase, grid)
     @score = 0
     @message = "not in the grid"
   elsif !check_vocabulary(@answer)
     @score = 0
     @message = "not an english word"
   end
 end

  # The word cant be built out of the original grid
  # The word is valid according to the grid, but is not a valid English word
  # The word is valid according to the grid and is an English word
end
