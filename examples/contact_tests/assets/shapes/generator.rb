module Assets
  module Shapes
    class Generator

      class << self

        def new_rectangle(origin)
          Rect.new do |rec|
            rec.origin = origin
            rec.width = 200
            rec.height = 200
            rec.color = Canvas::Colors.blue
            rec.fill = true
            rec.mass = 15
            rec.moment = 500
            rec.vel = V.new(-100, -10)
            rec.a_vel = 30
          end
        end

        def new_segment(origin)
          Segment.new do |seg|
            seg.origin = origin
            seg.start = V.new(0, 0)
            seg.term = V.new(-200, 0)
            seg.color = Canvas::Colors.yellow
            seg.mass = 8
            seg.moment = 500
            seg.vel = V.new(-400, -100)
            seg.a_vel = -30
            seg.recenter = true
          end
        end
      end
    end
  end
end