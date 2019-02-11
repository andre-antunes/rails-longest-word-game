# frozen_string_literal: true

# comment
class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = []
    alphabet = ('A'..'Z').to_a
    10.times do
      @letters << alphabet.sample
    end
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || '').upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
