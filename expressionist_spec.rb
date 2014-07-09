require_relative "expressionist"

describe Expressionist::Parser do
  describe "#to_f" do
    {
      "1"                   =>  1.0,
      "1.5 + 1.5"           =>  3.0,
      "1.0 / 3.0"           =>  0.33333,
      "1 + 2"               =>  3.0,
      "1 + 2 * ++-+---3"    =>  7.0,
      "1 + 2 * (3 - 4) / 5" =>  0.6,
      "-1"                  => -1.0,
      "+(-(-(-(-(1)))))"    =>  1.0
    }.each do |k, v|
      it "should return #{v.inspect} for #{k.inspect}" do
        expect(subject.parse(k).to_f).to be_within(0.001).of v
      end
    end
  end

  describe "#to_rpn" do
    {
      "1"                   => "1",
      "1.5 + 1.5"           => "1.5 1.5 +",
      "1.0 / 3.0"           => "1.0 3.0 /",
      "1 + 2"               => "1 2 +",
      "1 + 2 * ++-+---3"    => "1 2 3 -1 * -1 * -1 * -1 * * +",
      "1 + 2 * (3 - 4) / 5" => "1 2 3 4 - * 5 / +",
      "-1"                  => "1 -1 *",
      "+(-(-(-(-(1)))))"    => "1 -1 * -1 * -1 * -1 *",
    }.each do |k, v|
      it "should return #{v.inspect} for #{k.inspect}" do
        expect(subject.parse(k).to_rpn).to eq v
      end
    end
  end

  describe "#parse error handling" do
    {
      "1 + " => "Syntax error",
      "a"    => "Syntax error",
      "1 2"  => "Unexpected token \"2\", expecting \"\"",
      "( 1"  => "Unexpected token \"\", expecting \")\""
    }.each do |k, v|
      it "should raise #{v.inspect} for #{k.inspect}" do
        expect { subject.parse(k) }.to raise_error v
      end
    end
  end
end
