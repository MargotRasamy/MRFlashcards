import Kitura
import KituraStencil
import Foundation
import HeliumLogger
HeliumLogger.use()


let newFlashcardsGame = MRFlashcardsGame()
newFlashcardsGame.createDecksFromCsv(csvFolderPath : "./Sources/MRFlashcards/assets/csv") //Si lien errone, le nil a ete gere => a tester !

let decks = newFlashcardsGame.allDecks 



let router = Router()
router.all(middleware: [BodyParser(), StaticFileServer(path: "./Public")])
router.add(templateEngine: StencilTemplateEngine())


router.get("/") { request, response, next in
  try response.render("Home.stencil", with: decks, forKey: "allDecks")
  next()
}



router.get("/matiere/:NomDeLaMatiere") { request, response, next in
  let subjectDeckName : String? = request.parameters["NomDeLaMatiere"]



  for(i, matiere) in newFlashcardsGame.allDecks.enumerated() {
    
      // print(matiere.subjectName)
    
    if matiere.subjectName == subjectDeckName ?? "No subject" {

    try response.render("Deck.stencil", with: matiere.deck, forKey: "matiereTable")
    }
  }

  next()
}




 Kitura.addHTTPServer(onPort: 8080, with: router)
 Kitura.run()
