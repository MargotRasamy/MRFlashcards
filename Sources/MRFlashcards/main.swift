import Kitura
import KituraStencil
import Foundation
import HeliumLogger
HeliumLogger.use()


let newFlashcardsGame = MRFlashcardsGame()
newFlashcardsGame.createDecksFromCsv(csvFolderPath : "./Sources/MRFlashcards/assets/csv")
print(newFlashcardsGame.allDecks)



let router = Router()
router.all(middleware: [BodyParser(), StaticFileServer(path: "./Public")])
router.add(templateEngine: StencilTemplateEngine())


router.get("/") { request, response, next in
    
  var hello : String = ""
  // response.send(newFlashcardsGame.allDecks)
  try response.render("Home.stencil", context: [ hello  : ""])
  next()
 }


 Kitura.addHTTPServer(onPort: 8080, with: router)
 Kitura.run()
