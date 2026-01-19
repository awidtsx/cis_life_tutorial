import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

// Import and register all your controllers
import controllers from "./controllers"
controllers.forEach((controller) => {
  application.register(controller.name, controller.module.default)
})

export { application }