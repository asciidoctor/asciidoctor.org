module Awestruct
  class Engine
    def development?
      site.profile == 'development'
    end
  end
end
