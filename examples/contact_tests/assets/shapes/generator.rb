module Assets
  module Shapes
    class Generator

      class << self

        def new_circle(origin)
          Circle.new do |circ|
            circ.origin = origin
            circ.radius = 50
            circ.color = Canvas::Colors.white
            circ.fill = true
            circ.mass = 8
            circ.moment = 500
            circ.vel = V.new(-400, -100)
            circ.a_vel = -30
          end
        end

        def new_segment(origin)
          Segment.new do |seg|
            seg.origin = origin
            seg.line = V.new(-100, 0)
            seg.color = Canvas::Colors.white
            seg.mass = 8
            seg.moment = 500
            seg.vel = V.new(-400, -100)
            seg.a_vel = -30
            seg.recenter = true
          end
        end

        def new_triangle(origin)
          Triangle.new do |pol|
            pol.origin = origin
            pol.height = 100
            pol.width = 100
            pol.color = Canvas::Colors.white
            pol.fill = true
            pol.mass = 15
            pol.moment = 500
            pol.vel = V.new(-100, -10)
            pol.a_vel = 30
          end
        end

        def new_rectangle(origin)
          Rectangle.new do |rec|
            rec.origin = origin
            rec.width = 100
            rec.height = 100
            rec.color = Canvas::Colors.white
            rec.fill = true
            rec.mass = 15
            rec.moment = 500
            rec.vel = V.new(-100, -10)
            rec.a_vel = 30
          end
        end

        def new_polygon(origin)
          Polygon.new do |pol|
            pol.origin = origin
            pol.radius = 50
            pol.color = Canvas::Colors.white
            pol.fill = true
            pol.mass = 15
            pol.moment = 500
            pol.vel = V.new(-100, -10)
            pol.a_vel = 30
          end
        end

        def make_poly(num_points, radius)
          angle = 360 / num_points
          axis = Vector.new(0, -radius)

          Array.new.tap do |a|
            num_points.times do |i|
              axis.rotate!(angle)
              a.push(axis.copy)
            end
          end
        end
      end
    end
  end
end