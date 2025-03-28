import { Application } from "@hotwired/stimulus"
import NestedFormController from "./nested_form_controller"
import BeverageFormController from "./beverage_form_controller"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
application.register("nested-form", NestedFormController)
application.register("beverage-form", BeverageFormController)