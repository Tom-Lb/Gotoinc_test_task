require_relative './gotinc_test_task.rb'
require 'pry'
class User
end
class Car
  include Validation
  attr_reader :brand, :address, :user, :horses
  def initialize(attributes)
    @brand = attributes[:brand]
    @address = attributes[:address]
    @user = attributes[:user]
    @horses = attributes[:horses]
  end
  validate :brand, presence: true
  validate :user, type: User
  validate :horses, greater_than: 3
end
