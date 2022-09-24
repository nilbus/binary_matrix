require "sinatra"
require "json"

class BinaryMatrix < Sinatra::Base
  STORE = "tmp/answer.txt"

  get "/", layout: :layout do
    phrase = load_phrase
    erb :index, locals: { binary_translation: translate_phrase(phrase), answer: phrase }
  end

  get "/answer", layout: :layout do
    erb :answer, locals: { answer: load_phrase }
  end

  post "/update_answer" do
    write_phrase(params[:answer])
  end

  def load_phrase
    File.read(STORE).chomp
  rescue
    ""
  end

  def write_phrase(phrase)
    File.write(STORE, phrase)
  end

  def translate_phrase
    PHRASE.split(//).map { |char| char_to_binary(char) }
  end

  def char_to_binary(char)
    char.ord.to_s(2).rjust(8, "0")
  end
end
