class DataController < ApplicationController

  def books
    books = Book.order(id: :desc)
    array = []
    books.each do |b|
      b_hash = b.as_json
      b_hash[:url] = url_for(b.body.embeds.find{|embeds| embeds.image?})
      array.push b_hash
      b_hash[:comments] = b.comments.as_json
    end
    render json: array
  end

  def notes
    notes = Note.order(id: :desc)
    array = []
    notes.each do |n|
      n_hash = n.as_json
      n_hash[:url] = url_for(b.body.embeds.find{|embeds| embeds.file?})
      array.push n_hash
    end
    render json: array
  end
end
