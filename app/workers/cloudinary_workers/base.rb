module CloudinaryWorkers
  class Base
    include Sidekiq::Worker
  end
end