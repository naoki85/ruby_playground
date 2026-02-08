class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "[TestJob] performed"
  end
end
