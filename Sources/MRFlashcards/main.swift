import Kitura
import KituraStencil
import Foundation
import HeliumLogger
HeliumLogger.use()


  let nouveauxQuiz = MRFlashcardsGame()
  nouveauxQuiz.createDecksFromCsv(csvFolderPath : "./Sources/MRFlashcards/assets/csv")
print(nouveauxQuiz.allDecks)

//STEP 1







let router = Router()
router.all(middleware: [BodyParser(), StaticFileServer(path: "./Public")])
router.add(templateEngine: StencilTemplateEngine())



 router.get("/") { request, response, next in
    response.send(nouveauxQuiz.allDecks)
     
       


     
     next()
 }




 Kitura.addHTTPServer(onPort: 8080, with: router)
 Kitura.run()
