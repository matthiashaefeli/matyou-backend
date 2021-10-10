# frozen_string_literal: true

class Data
  class BooksController < ApplicationController
    # GET /data/books
    def index
      books = Book.order(id: :desc)
      array = []
      books.each do |b|
        b_hash = b.as_json
        b_hash[:url] = url_for(b.body.embeds.find(&:image?))
        array.push b_hash
        b_hash[:comments] = b.comments.as_json
      end
      render json: array
    end

    # Get /data/books/:id
    def show
      book = Book.find(params[:id])
      book_hash = book.as_json
      book_hash['comments'] = book.comments.order(id: 'asc').map { |c| { id: c.id, comment: c.body.body.to_html } }
      book_hash['url'] = url_for(book.body.embeds.find(&:image?))
      render json: book_hash
    end
  end
end
