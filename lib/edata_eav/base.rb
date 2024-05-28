module EdataEav
  class Base < ActiveRecord::Base
    self.abstract_class = true

    EdataEav.establish_connection
  end
end
