# frozen_string_literal: true

class Data
  class NotesController < ApplicationController
    # GET /data/notes
    def index
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
  end
end
