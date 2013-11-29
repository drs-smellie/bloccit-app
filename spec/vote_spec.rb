require 'spec-helper'

describe Vote do
  describe "up_vote?" do
    it "returns true for an up vote" do
      v = Vote.new(value: 1)
      v.up_vote?.should be (true)
    end
  end
end