require "sinatra"
require "json"

class BinaryMatrix < Sinatra::Base
  PHRASE = "Hello Edward".freeze

  get "/", layout: :layout do
    erb :index, locals: { binary_translation: translate_phrase, answer: PHRASE }
  end

  get "/answer", layout: :layout do
    erb :answer, locals: { phrase: PHRASE }
  end

  def translate_phrase
    PHRASE.split(//).map { |char| char_to_binary(char) }
  end

  def char_to_binary(char)
    char.ord.to_s(2).rjust(8, "0")
  end
end
