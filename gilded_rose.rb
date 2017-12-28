class GildedRose
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality
    items.each do |item|
      if item.name == brie
        update_brie(item)
      elsif item.name == backstage_pass
        update_backstage_pass(item)
      elsif item.name == sulfuras
        update_sulfuras(item)
      else
        update_normal(item)
      end
    end
  end

  def update_sulfuras(item)
  end

  def update_normal(item)
    decrement_quality = lambda { item.quality -= 1 unless item.quality == 0 }
    if item.sell_in > 0
      decrement_quality.call
    else
      2.times { decrement_quality.call }
    end
    item.sell_in -= 1
  end

  def update_backstage_pass(item)
    increment_quality = lambda { item.quality += 1 unless item.quality == 50 }
    if item.sell_in <= 0
      item.quality = 0
    elsif item.sell_in < 6
      3.times { increment_quality.call }
    elsif item.sell_in < 11
      2.times { increment_quality.call }
    else
      increment_quality.call
    end
    item.sell_in -= 1
  end

  def update_brie(item)
    increment_quality = lambda { item.quality += 1 unless item.quality == 50 }
    if item.sell_in > 0
      increment_quality.call
    else
      2.times { increment_quality.call }
    end
    item.sell_in -= 1
  end

  def brie
    'Aged Brie'
  end

  def backstage_pass
    'Backstage passes to a TAFKAL80ETC concert'
  end

  def sulfuras
    'Sulfuras, Hand of Ragnaros'
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]
