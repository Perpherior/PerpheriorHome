module CloudinaryWorkers
  class RemoveByTag < Base
    def perform(tag)
      CloudinaryAdmin.new.remove_by_tag(tag)
    end
  end
end