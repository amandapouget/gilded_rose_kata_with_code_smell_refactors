class GildedSulfuras
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update_quality
  end
end

class GildedNormalItem
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update_quality
    decrement_quality = lambda { item.quality -= 1 unless item.quality == 0 }
    if item.sell_in > 0
      decrement_quality.call
    else
      2.times { decrement_quality.call }
    end
    item.sell_in -= 1
  end
end

class GildedBackstagePass
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update_quality
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
end

class GildedBrie
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update_quality
    increment_quality = lambda { item.quality += 1 unless item.quality == 50 }
    if item.sell_in > 0
      increment_quality.call
    else
      2.times { increment_quality.call }
    end
    item.sell_in -= 1
  end
end

class GildedRose
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality
    items.each do |item|
      if item.name == brie
        rose = GildedBrie.new(item)
      elsif item.name == backstage_pass
        rose = GildedBackstagePass.new(item)
      elsif item.name == sulfuras
        rose = GildedSulfuras.new(item)
      else
        rose = GildedNormalItem.new(item)
      end
      rose.update_quality
    end
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
