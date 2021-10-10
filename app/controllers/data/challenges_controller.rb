# frozen_string_literal: true

class Data
  class ChallengesController < ApplicationController
    # GET /data/challenges
    def index
      challenges = Challenge.order(id: :desc)
      render json: challenges.to_json(include: :body)
    end
  end
end
