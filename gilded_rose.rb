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

  DEFAULT_CLASS = GildedNormalItem
  SPECIALIZED_CLASSES = {
    'Aged Brie'                                 => GildedBrie,
    'Backstage passes to a TAFKAL80ETC concert' => GildedBackstagePass,
    'Sulfuras, Hand of Ragnaros'                => GildedItem
  }

  def initialize(items)
    @items = items.map do |item|
      klass = SPECIALIZED_CLASSES[item.name] || DEFAULT_CLASS
      klass.new(item)
    end
  end

  def update_quality
    items.each do |item|
      item.update_quality
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
