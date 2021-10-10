# frozen_string_literal: true

class Data
  class TopicsController < ApplicationController
    # Get /data/topics
    def index
      topics = Topic.order(title: :asc)
      render json: topics.to_json
    end
  end
end
