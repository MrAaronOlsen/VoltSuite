RSpec.describe VectorMath do

  it '#farthest_point_along_axis' do
    points = [V.new(2, 2), V.new(4, 2), V.new(6, 2), V.new(4, 4), V.new(2, 3)]
    axis = V.new(1, 0)

    farthest_point = VectMath.farthest_point_along_axis(points, axis)

    expect(farthest_point.point).to eq(V.new(6, 2))
    expect(farthest_point.position).to eq(6.0)
    expect(farthest_point.index).to eq(2)
  end

  describe "#normal_towards"  do
    # is also described as the triple product.

    it "Can find the normal most towards a point case one" do
      a = V.new(10, 0)
      b = V.new(10, 10)
      c = V.new(0, 5)

      axis = a - b
      normal_norm = axis.normal_unit
      normal_norm.flip! if normal_norm.cross(c) > 0

      normal_trip = VectMath.normal_towards(a, b, c).unit

      expect(normal_trip).to eq(normal_norm)
    end

    it "Can find the normal most towards a point case two" do
      a = V.new(10, 0)
      b = V.new(10, 10)
      c = V.new(0, 5)

      axis = b - a
      normal_norm = axis.normal_unit
      normal_norm.flip! if normal_norm.cross(c) > 0

      normal_trip = VectMath.normal_towards(a, b, c).unit

      expect(normal_trip).to eq(normal_norm)
    end
  end

  describe "distance_of_point_to_line" do

    it "simple case" do
      point = V.new(2, 2)
      line = V.new(0, 1)
      point_on_line = V.new(3, 3)

      distance = VectMath.distance_of_point_to_line(point, line, point_on_line)

      expect(distance).to eq(1.0)
    end

    it "diagonal case 1" do
      point = V.new(2, 2)
      line = V.new(1, -1)
      point_on_line = V.new(4, 2)

      distance = VectMath.distance_of_point_to_line(point, line, point_on_line)

      expect(distance).to be_within(0.0001).of(1.4142)
    end

    it "diagonal case 2" do
      point = V.new(2, 2)
      line = V.new(1, -1)
      point_on_line = V.new(4, 1)

      distance = VectMath.distance_of_point_to_line(point, line, point_on_line)

      expect(distance).to be_within(0.0001).of(0.7071)
    end
  end

  describe '#averages' do

    context 'point' do
      before do
        @points = [V.new(0, 0)]
      end

      it 'can find average' do
        average = VectMath.average(@points)

        expect(average).to eq(V.new(0, 0))
      end

      it 'can find area average' do
        average = VectMath.area_average(@points)

        expect(average).to eq(V.new(0, 0))
      end
    end

    context 'segment' do
      before do
        @points = [V.new(-5, 0), V.new(5, 0)]
      end

      it 'can find average' do
        average = VectMath.average(@points)

        expect(average).to eq(V.new(0, 0))
      end

      it 'can find area average' do
        average = VectMath.area_average(@points)

        expect(average).to eq(V.new(0, 0))
      end
    end

    context 'triangle' do
      before do
        @points = [V.new(0, -5), V.new(5, 5), V.new(-5, 5)]
      end

      it 'can find average' do
        average = VectMath.average(@points)

        expect(average).to be_within_vect(0.0001).of(V.new(0, 1.6666))
      end

      it 'can find area average' do
        average = VectMath.area_average(@points)

        expect(average).to be_within_vect(0.0001).of(V.new(0, 1.6666))
      end
    end

    context 'square' do
      before do
        @points = [V.new(-5, -5), V.new(5, -5), V.new(5, 5), V.new(-5, 5)]
      end

      it 'can find average' do
        average = VectMath.average(@points)

        expect(average).to eq(V.new(0, 0))
      end

      it 'can find area average' do
        average = VectMath.area_average(@points)

        expect(average).to eq(V.new(0, 0))
      end
    end

    context 'rectangle' do
      before do
        @points = [V.new(-10, -5), V.new(10, -5), V.new(10, 5), V.new(-10, 5)]
      end

      it 'can find average' do
        average = VectMath.average(@points)

        expect(average).to eq(V.new(0, 0))
      end

      it 'can find area average' do
        average = VectMath.area_average(@points)

        expect(average).to eq(V.new(0, 0))
      end
    end

    context 'polygon' do
      before do
        @points = [V.new(-5, -5), V.new(5, -5), V.new(5, 0), V.new(5, 5), V.new(-5, 5)]
      end

      # Getting the normal average can be skewed when extra points weigh down a side. This is really just a square
      # but with an extra vert on one side. This causes the center to move towards that side.
      it 'can find average' do
        average = VectMath.average(@points)

        expect(average).to eq(V.new(1, 0))
      end

      # The area average uses the normal average but weights them based on area, giving us a more accurate center.
      it 'can find area average' do
        average = VectMath.area_average(@points)

        expect(average).to be_within_vect(0.0001).of(V.new(0, 0))
      end
    end
  end
end