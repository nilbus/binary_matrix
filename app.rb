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
    write_phrase(request.body.read&.chomp)
    202
  end

  get "/answer_binary" do
    phrase = load_phrase
    translate_phrase(phrase).join(" ")
  end

  def load_phrase
    File.read(STORE).to_s.chomp
  rescue
    ""
  end

  def write_phrase(phrase)
    File.write(STORE, phrase)
  end

  def translate_phrase(phrase)
    phrase.split(//).map { |char| char_to_binary(char) }
  end

  def char_to_binary(char)
    char.ord.to_s(2).rjust(8, "0")
  end
end
