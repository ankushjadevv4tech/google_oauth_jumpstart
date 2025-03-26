import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["category", "subcategory", "temperatureSlider", "temperatureLabel", "temperatureValue"];

  connect() {
    console.log("Beverage form controller connected");

    // Initialize subcategories if category is preselected
    this.updateSubcategories();
    this.updateTemperatureLabel()
  }

  updateSubcategories(event) {
    const category = event ? event.target.value : this.element.querySelector("select[name='beverage_entry[category]']").value;
    const subcategorySelect = this.subcategoryTarget;
    const subcategories = this.getSubcategoriesFor(category);

    // Preserve previously selected subcategory
    const selectedSubcategory = subcategorySelect.dataset.selectedSubcategory;

    // Clear existing options
    subcategorySelect.innerHTML = "";

    // Populate subcategories dynamically
    subcategories.forEach(subcategory => {
      const option = document.createElement("option");
      option.value = subcategory;
      option.textContent = subcategory;
      if (subcategory === selectedSubcategory) {
        option.selected = true;
      }
      subcategorySelect.appendChild(option);
    });
  }

  updateTemperatureLabel() {
    const temperatures = {
      0: ["very_cold", "❄️ Ice Cold (0°C / 32°F)"],
      1: ["chilled", "🧊 Chilled (4°C / 40°F)"],
      2: ["cool", "🥶 Cool (10°C / 50°F)"],
      3: ["room_temperature", "🌡️ Room Temperature (20°C / 68°F)"],
      4: ["warm", "🔥 Warm (50°C / 122°F)"],
      5: ["hot", "☕ Hot (70°C / 158°F)"],
      6: ["very_hot", "♨️ Boiling (100°C / 212°F)"]
    }
    
    const value = this.temperatureSliderTarget.value
    const [dbValue, label] = temperatures[value]
    
    this.temperatureLabelTarget.textContent = label
    this.temperatureValueTarget.value = dbValue
  }

  getSubcategoriesFor(category) {
    const subcategories = {
      "Water-Based Beverages": ["Plain Water", "Infused Water (Lemon, Cucumber, Mint, Ginger)", "Coconut Water", "Electrolyte-Infused Water", "Oral Rehydration Solutions"],
      "Coffee-Based Beverages": ["Black Coffee", "Espresso", "Americano", "Cold Brew", "Latte (Dairy-Based)", "Latte (Plant-Based)", "Cappuccino", "Mocha"],
      "Tea-Based Beverages": ["Green Tea", "Black Tea", "White Tea", "Oolong Tea", "Herbal Tea (Peppermint, Chamomile, Ginger, Fennel, Licorice Root)", "Matcha", "Yerba Mate"],
      "Juice & Smoothies": ["Fresh Fruit Juice (Apple, Orange, Pomegranate, etc.)", "Vegetable Juice (Carrot, Beet, Celery, etc.)", "Blended Smoothies (Fruit-Based)", "Blended Smoothies (Vegetable-Based)"],
      "Dairy-Based Beverages": ["Whole Milk", "Low-Fat Milk", "Skim Milk", "Lactose-Free Milk", "Kefir", "Buttermilk"],
      "Plant-Based Milks": ["Almond Milk (Unsweetened)", "Almond Milk (Sweetened)", "Oat Milk (Unsweetened)", "Oat Milk (Sweetened)", "Soy Milk", "Coconut Milk", "Rice Milk", "Hemp Milk"],
      "Fermented & Probiotic Beverages": ["Kombucha", "Lassi", "Yakult", "Kvass"],
      "Carbonated & Artificially Sweetened Drinks": ["Regular Soda", "Diet Soda", "Sparkling Water", "Energy Drinks", "Sports Drinks (Gatorade, Powerade)"],
      "Alcoholic Beverages": ["Beer", "Wine", "Cider", "Cocktails", "Liquor (Vodka, Whiskey, Gin, Tequila)"],
      "Other": ["Other"]
    };
    
    return subcategories[category] || [];
  }
}
