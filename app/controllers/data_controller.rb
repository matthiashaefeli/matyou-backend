class DataController < ApplicationController

  def books
    books = Book.order(id: :desc)
    render json: books.to_json(include: :body)
  end

  def notes
    notes = Note.order(id: :desc)
    render json: notes.to_json(include: :body)
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
