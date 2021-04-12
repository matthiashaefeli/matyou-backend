class DataController < ApplicationController

  # GET /data/books
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

  # Get /data/book/:id
  def book
    book = Book.find(params[:id])
    book_hash = book.as_json
    book_hash['comments'] = book.comments.map{|c| { id: c.id, comment: c.body.body.to_html} }
    book_hash['url'] = url_for(book.body.embeds.find{|embeds| embeds.image?})
    render json: book_hash
  end

  # GET /data/notes
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

  # GET /data/challenges
  def challenges
    challenges = Challenge.order(id: :desc)
    render json: challenges.to_json(include: :body)
  end

  # GET /data/blogs
  def blogs
    blogs = Blog.order(id: :desc)
    render json: blogs.to_json(include: :body)
  end

  # Get /data/topics
  def topics
    topics = Topic.order(title: :asc)
    render json: topics.to_json
  end

  # Get /data/cmds
  def cmds
    cmd = Career.order(id: :desc)
    array = []
    cmd.each do |c|
      c_hash = c.as_json
      c_hash[:url] = url_for(c.body.embeds.find{|embeds| embeds.image?})
      array.push c_hash
      c_hash[:comments] = c.comments.as_json
    end
    render json: array
  end
end
