require 'rspec'
require_relative '../lib/tree'

describe Tree do
  before(:each) do
    @tree = Tree.new
  end

  it 'should be a Class' do
    expect(described_class.is_a? Class).to eq true
  end

  it 'should be initialized with reasonable defaults' do
    expect(@tree.height).to eq 0
    expect(@tree.age).to eq 0
    expect(@tree.apples).to eq []
    expect(@tree.alive).to eq true
  end

  it 'age! should increment age by 1' do
    @tree.age!
    expect(@tree.age).to eq 1
  end

  it 'any_apples? should return false when no apples' do
    expect(@tree.any_apples?).to eq false
  end

  it 'pick_an_apple! should raise NoApplesError when no apples' do
    expect {@tree.pick_an_apple!}.to raise_error NoApplesError
  end

  it 'dead? returns the opposite of alive' do
    expect(@tree.dead?).to eq false
    @tree.age! until @tree.age > @tree.max_age # conduct theodicy
    expect(@tree.dead?).to eq true
  end
end

describe 'Fruit' do
end

describe 'Apple' do
end
