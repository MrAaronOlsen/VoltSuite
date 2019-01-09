module Volt
  class Arbitor
    include Structs
    attr_reader :broad_contacts, :contact_manifolds, :joint_contacts

    def initialize
      @broad_contacts = []
      @narrow_contacts = []
    end

    def clear
      @broad_contacts = []
      @narrow_contacts = []
    end

    def pre_solve(bodies)
      bodies.each_with_index do |body1, i|
        bodies[i+1..-1].each do |body2|
          @broad_contacts << BroadContact.new(body1, body2) if AABB.query(body1.bounding, body2.bounding)
        end
      end
    end

    def solve
      @broad_contacts.each do |contact|
        contact.body1.shapes.each do |shape1|
          next if shape1.static

          contact.body2.shapes.each do |shape2|
            next if shape2.static

            support1 = shape1.get_support
            support1.transform(shape1.body.trans)
            support2 = shape2.get_support
            support2.transform(shape2.body.trans)

            manifold = Manifold.new(support1, support2)

            if manifold.pre_solve && manifold.solve
              manifold.body1 = contact.body1
              manifold.body2 = contact.body2

              @narrow_contacts << manifold
            end
          end
        end
      end
    end

    def resolve(dt)
      sorted_contacts = @narrow_contacts.sort_by { |manifold| manifold.contact_depth }

      sorted_contacts.each do |manifold|
        Impulse.resolve_interpenetration(manifold, dt)
        Impulse.resolve_velocity(manifold, dt)
      end
    end
  end
end