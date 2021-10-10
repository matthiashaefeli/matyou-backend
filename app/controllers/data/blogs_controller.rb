# frozen_string_literal: true

class Data
  class BlogsController < ApplicationController
    # GET /data/blogs
    def index
      blogs = Blog.order(id: :desc)
      render json: blogs.to_json(include: :body)
    end
  end
end
