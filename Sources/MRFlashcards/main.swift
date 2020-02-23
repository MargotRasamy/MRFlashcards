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

  //Passer de "nom_du_sujet_" dans le chemin a "nom du sujet"
  var subjectDeckNameTrimed : String? = subjectDeckName?.replacingOccurrences(of: "_", 
  with: " ")
  subjectDeckNameTrimed = subjectDeckNameTrimed?.trimmingCharacters(in: .whitespacesAndNewlines)


  for(i, subjectList) in newFlashcardsGame.allDecks.enumerated() {
    if subjectList.subjectName == subjectDeckNameTrimed ?? "No subject" {
    try response.render("Deck.stencil", with: subjectList.deck, forKey: "cardsList")
    }
  }

  next()
}




 Kitura.addHTTPServer(onPort: 8080, with: router)
 Kitura.run()
