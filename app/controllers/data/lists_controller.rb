# frozen_string_literal: true

class Data
  class ListsController < ApplicationController
    # Get 'data/lists'
    def index
      lists = List.order(id: :desc)
      array = []
      lists.each do |l|
        l_hash = l.as_json
        l_hash[:comments] = []
        l.comments.each do |c|
          l_hash[:comments] << { id: c.id, body: c.body.body }
        end
        array.push l_hash
      end
      render json: array
    end
  end
end
