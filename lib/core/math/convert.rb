class Convert

  class << self

    def radian(degree)
      degree * (Math::PI/180)
    end

    def degree(radian)
      radian * (180/Math::PI)
    end
  end

end