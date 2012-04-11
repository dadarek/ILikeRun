require 'some_class'

describe SomeClass do

  it "should not error" do
    c = SomeClass.new
    c.el_value.should == 4
  end

end
