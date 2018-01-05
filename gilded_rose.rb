class GildedItem
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update_quality
  end
end

class GildedNormalItem < GildedItem
  def update_quality
    item.sell_in -= 1
    return if item.quality == 0
    item.quality -= 1
    item.quality -= 1 if item.sell_in <= 0
  end
end

class GildedBackstagePass < GildedItem
  def update_quality
    item.sell_in -= 1
    return if item.quality >= 50
    return item.quality = 0 if item.sell_in < 0
    item.quality += 1
    item.quality += 1 if item.sell_in < 10
    item.quality += 1 if item.sell_in < 5
  end
end

class GildedBrie < GildedItem
  def update_quality
    item.sell_in -= 1
    item.quality += 1 if item.quality < 50
    item.quality += 1 if item.quality < 50 && item.sell_in <= 0
  end
end

class GildedRose
  attr_reader :items

  def initialize(items)
    @items = items.map do |item|
      klass = klass_from_name(item.name)
      klass.new(item)
    end
  end

  def update_quality
    items.each do |item|
      item.update_quality
    end
  end

private
  def klass_from_name(name)
    case name
    when 'Aged Brie'
      GildedBrie
    when 'Backstage passes to a TAFKAL80ETC concert'
      GildedBackstagePass
    when 'Sulfuras, Hand of Ragnaros'
      GildedItem
    else
      GildedNormalItem
    end
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
