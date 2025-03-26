class BeverageEntry < ApplicationRecord
  belongs_to :user
  has_many :symptoms, dependent: :destroy
  has_one_attached :photo
  
  validates :consumed_at, :category, :quantity, :quantity_unit, :temperature, presence: true
  
  accepts_nested_attributes_for :symptoms, allow_destroy: true
  
  enum temperature: {
    very_cold: 0,
    chilled: 1,
    cool: 2,
    room_temperature: 3,
    warm: 4,
    hot: 5,
    very_hot: 6
  }

  CATEGORIES = {
    "Water-Based Beverages" => [
      "Plain Water", 
      "Infused Water (Lemon, Cucumber, Mint, Ginger)", 
      "Coconut Water", 
      "Electrolyte-Infused Water", 
      "Oral Rehydration Solutions"
    ],
    "Coffee-Based Beverages" => [
      "Black Coffee", 
      "Espresso", 
      "Americano", 
      "Cold Brew", 
      "Latte (Dairy-Based)", 
      "Latte (Plant-Based)", 
      "Cappuccino", 
      "Mocha"
    ],
    "Tea-Based Beverages" => [
      "Green Tea", 
      "Black Tea", 
      "White Tea", 
      "Oolong Tea", 
      "Herbal Tea (Peppermint, Chamomile, Ginger, Fennel, Licorice Root)", 
      "Matcha", 
      "Yerba Mate"
    ],
    "Juice & Smoothies" => [
      "Fresh Fruit Juice (Apple, Orange, Pomegranate, etc.)", 
      "Vegetable Juice (Carrot, Beet, Celery, etc.)", 
      "Blended Smoothies (Fruit-Based)", 
      "Blended Smoothies (Vegetable-Based)"
    ],
    "Dairy-Based Beverages" => [
      "Whole Milk", 
      "Low-Fat Milk", 
      "Skim Milk", 
      "Lactose-Free Milk", 
      "Kefir", 
      "Buttermilk"
    ],
    "Plant-Based Milks" => [
      "Almond Milk (Unsweetened)", 
      "Almond Milk (Sweetened)", 
      "Oat Milk (Unsweetened)", 
      "Oat Milk (Sweetened)", 
      "Soy Milk", 
      "Coconut Milk", 
      "Rice Milk", 
      "Hemp Milk"
    ],
    "Fermented & Probiotic Beverages" => [
      "Kombucha", 
      "Lassi", 
      "Yakult", 
      "Kvass"
    ],
    "Carbonated & Artificially Sweetened Drinks" => [
      "Regular Soda", 
      "Diet Soda", 
      "Sparkling Water", 
      "Energy Drinks", 
      "Sports Drinks (Gatorade, Powerade)"
    ],
    "Alcoholic Beverages" => [
      "Beer", 
      "Wine", 
      "Cider", 
      "Cocktails", 
      "Liquor (Vodka, Whiskey, Gin, Tequila)"
    ],
    "Other" => [
      "Other"
    ]
  }
end
