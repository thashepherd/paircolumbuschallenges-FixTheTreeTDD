class NoApplesError < StandardError; end

class Tree
  attr_accessor :height, :age, :apples, :alive
  attr_reader :max_age
  
  def initialize
    @height = 0
    @age = 0
    @apples = []
    @alive = true
    # From https://homegardenveg.com/apple-tree-lifespan/
    @max_age = rand(35..45)
  end
  
  def age!
    @age += 1
    # From https://homeguides.sfgate.com/size-apple-tree-rate-growth-57015.html
    @height += rand(0.5..1.5)
    add_apples
    @alive = false if age > @max_age
  end
  
  def add_apples
    colors = ['red', 'yellow', 'green', 'red and green']
    # From https://stemilttrade.com/wp-content/uploads/2013/07/AppleSizing.pdf
    size_lower, size_upper = 2.31, 3.63

    # From https://www.reference.com/world-view/many-apples-apple-trees-produce-36b0e32df35f5e35
    # Assuming 126 apples per bushel
    for i in 0..rand(378..1260)
      @apples.push(Apple.new(colors.sample, rand(size_lower..size_upper).round(2)))
    end
  end
  
  def any_apples?
    return @apples.length > 0
  end
  
  def pick_an_apple!
    raise NoApplesError, "This tree has no apples" unless self.any_apples?
    apples.pop
  end
  
  def dead?
    !@alive
  end
end

class Fruit
  attr_reader :color, :diameter

  def initialize(color, diameter)
    has_seeds = true
    @color = color
    @diameter = diameter
  end
end

class Apple < Fruit
  def initialize(color, diameter)
    super
  end
end

#THERES ONLY ONE THING YOU NEED TO EDIT BELOW THIS LINE
# avg_diameter (line 58) will raise an error.
# it should calculate the diameter of the apples in the basket

def tree_data
  tree = Tree.new
  
  tree.age! until tree.any_apples?
  
  puts "Tree is #{tree.age} years old and #{tree.height} feet tall"
  
  until tree.dead?
    basket = []
    
    # It places the apple in the basket
    while tree.any_apples?
      basket << tree.pick_an_apple!
    end
    
    diameter_sum = 0
    
    basket.each do |apple|
      diameter_sum += apple.diameter
    end
    
    # It's up to you to calculate the average diameter for this harvest.
    avg_diameter = diameter_sum / basket.length
    
    puts "Year #{tree.age} Report"
    puts "Tree height: #{tree.height.round(2)} feet"
    puts "Harvest:     #{basket.size} #{if basket.size == 1 then 'apple' else 'apples' end} with an average diameter of #{avg_diameter.round(2)} inches"
    puts ""
    
    # Ages the tree another year
    tree.age!
  end
  
  puts "Alas, the tree, she is dead!"
end

# Uncomment this line to run the script, but BE SURE to comment it before you try to run your tests!
# tree_data
