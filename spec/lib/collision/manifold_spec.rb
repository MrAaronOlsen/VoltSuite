RSpec.describe "Manifold" do

  describe 'Poly Poly' do
    it "#solve case 1" do
      shape_a = [V.new(4, 6), V.new(4, 4), V.new(6, 4), V.new(6, 6)]
      support1 = Support::Poly.new(VectMath.average(shape_a), shape_a)

      shape_b = [V.new(7, 7), V.new(5, 7), V.new(7, 4)]
      support2 = Support::Poly.new(VectMath.average(shape_b), shape_b)

      run_poly_poly_case1(support1, support2)
      run_poly_poly_case1(support2, support1, true)
    end

    def run_poly_poly_case1(support1, support2, flipped = false)
      manifold = Manifold.new(support1, support2)
      manifold.pre_solve

      expect(manifold.contact?).to be_truthy

      manifold.solve

      expect(manifold.contact_depth).to be_within(0.0001).of(0.2773)

      if flipped
        expect(manifold.contact_normal).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(0.8320, 0.5547))
      else
        expect(manifold.contact_normal).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(-0.8320, -0.5547))
      end

      expect(manifold.contact_points.size).to eq(1)
      expect(manifold.contact_points[0]).to eq(V.new(6, 6))

      expect(manifold.reference.start).to eq(V.new(5, 7))
      expect(manifold.reference.terminus).to eq(V.new(7, 4))

      expect(manifold.incident.start).to eq(V.new(6, 4))
      expect(manifold.incident.terminus).to eq(V.new(6, 6))
    end
  end

  describe 'Poly Circle' do
    it "#solve case 1" do
      shape_a = [V.new(1, 4), V.new(4, 4), V.new(4, 7), V.new(1, 7)]
      support1 = Support::Poly.new(VectMath.average(shape_a), shape_a)

      support2 = Support::Circle.new(V.new(5, 3), 2)

      run_poly_circle_case1(support1, support2)
      run_poly_circle_case1(support2, support1, true)
    end

    def run_poly_circle_case1(support1, support2, flipped = false)
      manifold = Manifold.new(support1, support2)
      manifold.pre_solve

      expect(manifold.contact?).to be_truthy

      manifold.solve

      expect(manifold.contact_depth).to be_within(0.0001).of(0.5857)

      if (flipped)
        expect(manifold.contact_normal).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(-0.7071, 0.7070))
      else
        expect(manifold.contact_normal).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(0.7071, -0.7070))
      end

      expect(manifold.contact_points.size).to eq(1)
      expect(manifold.contact_points[0]).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(3.5856, 4.4140))

      if (flipped)
        expect(manifold.reference.axis).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(0.707, 0.7071))
      else
        expect(manifold.reference.axis).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(-0.707, -0.7071))
      end
    end
  end
end