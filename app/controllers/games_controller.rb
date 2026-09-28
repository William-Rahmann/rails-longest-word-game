class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
  end

  def score
    @word = params[:word].downcase
    grid_letters = params[:letters].downcase.chars

    if word_can_be_built?(@word, grid_letters)
      if real_word?(@word)
        @message = "#{@word} is valid and worth #{@word.length} points!"
      else
        @message = "#{@word} isn't a real word"
      end
    else
      @message = "#{@word} can't be built from the letters you were given"
    end
  end

  private

  def word_can_be_built?(word, letters)
    remaining = letters.dup
    word.chars.all? do |char|
      if remaining.include?(char)
        remaining.delete_at(remaining.index(char))
        true
      else
        false
      end
    end
  end

require "json"

  def real_word?(word)
    response = HTTParty.get("https://dictionary.lewagon.com/#{word}")
    JSON.parse(response.body)["found"]
  end
end
