import { application } from "controllers/application"

// Import controllers with the full path
import PremiumController from "controllers/premium_controller"
import HelloController from "controllers/hello_controller"

// Register them
application.register("premium", PremiumController)
application.register("hello", HelloController)

console.log("Controllers registered:", application.router.modulesByIdentifier)