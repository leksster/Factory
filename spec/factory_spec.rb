require 'spec_helper'

describe Factory do
  context "::Model" do
    before(:each) do
      @metaclass = Factory::Model.new(:first_name, :second_name, :address)
      @instance_of_class = @metaclass.new("Alex", "Smith", 49125)
      @obj1 = @metaclass.new("John", "Du", 2)
      @obj2 = @metaclass.new("John", "Du", 2)
    end

    it 'has a version number' do
      expect(Factory::VERSION).not_to be nil
    end

    it "is a class" do
      expect(Factory::Model.class).to eq(Class)
    end

    it 'should create instances of the class Class' do
      expect(@metaclass).to be_a(Class)
    end

    it 'has no instance variables' do
      expect(@metaclass.instance_variables).to eq([])
    end

    it 'instance has getter' do
      expect(@instance_of_class.first_name).to eq("Alex")
    end

    it 'instance has setter' do
      expect{@instance_of_class.first_name = "John"}.to change{@instance_of_class.first_name}.from("Alex").to("John")
    end

    it '==' do
      expect(@obj1 == @obj2).to be true
    end

    it '#eql?' do
      expect(@obj1.eql?(@obj2)).to be true
    end

    it 'gets element by [index]' do
      expect(@instance_of_class[1]).to eq("Smith")
    end

    it 'gets element by [name]' do
      expect(@instance_of_class[:second_name]).to eq("Smith")
    end

    it '#each' do
      expect(@instance_of_class.each { |x| x }).to eq(["Alex", "Smith", 49125])
    end

    it '#each_pair' do
      expect(@instance_of_class.each_pair { |name, value| "#{name}, #{value}" }).to eq({:first_name => "Alex", :second_name => "Smith", :address => 49125})
    end

    it '#hash' do
      expect(@instance_of_class.hash).to eq({:first_name => "Alex", :second_name => "Smith", :address => 49125})
    end

    it '#inspect' do
      expect(@instance_of_class.inspect).to eq("first_name='Alex', second_name='Smith', address='49125'")
    end

    it '#members' do
      expect(@instance_of_class.members).to eq([:first_name, :second_name, :address])
    end

    it '#select' do
      expect(@instance_of_class.select { |value| value.is_a?(String) }).to eq(["Alex", "Smith"])
    end

    it '#size' do
      expect(@instance_of_class.size).to eq(3)
    end

    it '#to_a' do
      expect(@instance_of_class.to_a).to eq(["Alex", "Smith", 49125])
    end

    it '#to_h' do
      expect(@instance_of_class.to_h).to eq({:first_name => "Alex", :second_name => "Smith", :address => 49125})
    end

    it '#values' do
      expect(@instance_of_class.values).to eq(["Alex", "Smith", 49125])
    end

    it '#values_at' do
      expect(@instance_of_class.values_at 0, 2).to eq(["Alex", 49125])
    end
  end

end
