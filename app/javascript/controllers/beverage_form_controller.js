import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["category", "subcategory", "temperatureLabel"]

  connect() {
    // File Preview
    document.getElementById("beverage_entry_photo").addEventListener("change", function(event) {
      const file = event.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
          document.getElementById("image-preview").src = e.target.result;
          document.getElementById("preview-container").style.display = "block";
        };
        reader.readAsDataURL(file);
      }
    });

    // function removeImage() {
    //   document.getElementById("beverage_entry_photo").value = "";
    //   document.getElementById("preview-container").style.display = "none";
    // }

    // Add more visible debugging
    console.log("Beverage form controller connected")
    document.body.classList.add('beverage-form-connected')
    
    this.updateSubcategories()
    this.updateTemperatureLabel()

    // Bootstrap Form Validation
    (function () {
      'use strict';
      var forms = document.querySelectorAll('.needs-validation');
      Array.prototype.slice.call(forms).forEach(function (form) {
        form.addEventListener('submit', function (event) {
          if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
          }
          form.classList.add('was-validated');
        }, false);
      });
    })();
  }

  updateSubcategories() {
    const subcategorySelect = this.element.querySelector('select[name="beverage_entry[subcategory]"]');
    const category = this.categoryTarget.value
    const subcategories = this.getSubcategoriesFor(category)
    // Update subcategory options
    subcategorySelect.innerHTML = ""; // Clear existing options
    subcategories.forEach(subcategory => {
      const option = document.createElement("option");
      option.value = subcategory;
      option.textContent = subcategory;
      subcategorySelect.appendChild(option);
    });
  }

  updateTemperatureLabel() {
    const value = this.element.querySelector('input[type="range"]').value
    const labels = {
      0: "❄️ Ice Cold",
      1: "🧊 Chilled",
      2: "🌡️ Cool",
      3: "🌡️ Room Temperature",
      4: "🔥 Warm",
      5: "🌡️ Hot",
      6: "💧 Boiling",
    }
    this.temperatureLabelTarget.textContent = labels[value]
  }

  getSubcategoriesFor(category) {
    // Define subcategories based on the selected category
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
    }
    return subcategories[category] || [];
  }
}
