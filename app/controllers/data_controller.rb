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

  def book
    binding.pry
    book = Book.find(params[:id])

  end

  def notes
    notes = Note.order(id: :desc)
    array = []
    notes.each do |n|
      n_hash = n.as_json
      attachments = n.body.body.attachments
      n_hash[:url] =
        if attachments.length == 1
          attachments.first.url
        else
          nil
        end
      array.push n_hash
    end
    render json: array
  end

  def challenges
    challenges = Challenge.order(id: :desc)
    render json: challenges.to_json(include: :body)
  end

  def blogs
    blogs = Blog.order(id: :desc)
    render json: blogs.to_json(include: :body)
  end
end
