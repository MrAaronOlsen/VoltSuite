module Volt
  class World
    attr_accessor :bodies
    attr_reader :dt

    def initialize
      @bodies = []
      @arbitor = Arbitor.new
    end

    def update(dt)
      return if dt <= 0.0

      @arbitor.pre_solve(@bodies)
      @arbitor.solve
      @arbitor.resolve(dt)

      bodies.each do |body|
        body.update(dt)
      end

      @arbitor.clear
    end

    def add_body(body)
      @bodies << body
    end

    def add_bodies(bodies)
      bodies.each { |body| add_body(body) }
    end

    def add_joint(joint)
      @joints << joint
    end

    def add_joints(joints)
      joints.each { |joint| add_joint(joint) }
    end
  end
end