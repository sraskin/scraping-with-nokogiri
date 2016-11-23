class RubyBook

  def self.local_and_global_var
    localvar = "hello"
    $globalvar = "goodbye"

    def amethod
      localvar = 10
      puts(localvar)
      puts($globalvar)
    end

    def another_method
      localvar = 500
      $globalvar = "bonjur"
      puts(localvar)
      puts($globalvar)
    end

  end


end