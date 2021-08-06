# frozen_string_literal: true

class Customer < ApplicationRecord

  validates :name, presence: true
  #Email format validation either with URI::MailTo::EMAIL_REGEXP or a service like Abstract API
end
