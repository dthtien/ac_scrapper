# frozen-string-literal: true

class BaseService
  attr_reader :errors

  def initialize
    @errors = []
  end

  def success?
    @errors.empty?
  end

  def failure?
    !success?
  end
end
