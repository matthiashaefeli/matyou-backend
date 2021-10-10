# frozen_string_literal: true

class Data
  class CmdsController < ApplicationController
    # Get /data/cmds
    def index
      cmd = Career.order(id: :desc)
      array = []
      cmd.each do |c|
        c_hash = c.as_json
        c_hash[:url] = url_for(c.body.embeds.find { |embeds| embeds.image? })
        array.push c_hash
        c_hash[:comments] = c.comments.as_json
      end
      render json: array
    end
  end
end
