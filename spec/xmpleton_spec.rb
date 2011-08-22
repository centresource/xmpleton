require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Xmpleton::Reader do
  describe "::new" do
    it "should throw an error if called with no arguments" do
      lambda { Xmpleton::Reader.new }.should raise_error
    end

    it "should throw an error if called with more than one argument" do
      f = File.open("#{RESOURCES_PATH}/test_img.jpg")
      lambda { Xmpleton::Reader.new(f,6) }.should raise_error
      lambda { Xmpleton::Reader.new(f,6,9) }.should raise_error
    end

    it "should not throw an error if called with one argument that is an IO" do
      f = File.open("#{RESOURCES_PATH}/test_img.jpg")
      lambda { Xmpleton::Reader.new(f) }.should_not raise_error
    end

    it "should throw an error if called with one argument that is not an IO" do
      lambda { Xmpleton::Reader.new("smeg") }.should raise_error
    end
  end

  describe "tags" do
    it "should appropriately read the tags of the passed image" do
      f = File.open("#{RESOURCES_PATH}/test_img.jpg")
      reader = Xmpleton::Reader.new(f)
      reader.tags.should == [
        "jeremy",
        "corndog",
        "magic biscuit",
        "potato captain",
        "beet sauce"
      ]
    end
  end
end
