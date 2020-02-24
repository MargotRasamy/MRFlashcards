import Kitura
import KituraStencil
import Foundation
import HeliumLogger
HeliumLogger.use()

//Start a new flashcards board
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



router.get("/matiere/:subjectDeckNameInPath") { request, response, next in
  let subjectDeckName : String? = request.parameters["subjectDeckNameInPath"]

  //Passer de "nom_du_sujet_" dans le chemin a "nom du sujet"
  var subjectDeckNameTrimed : String? = subjectDeckName?.replacingOccurrences(of: "_", 
  with: " ")
  subjectDeckNameTrimed = subjectDeckNameTrimed?.trimmingCharacters(in: .whitespacesAndNewlines)

  //Boucle pour rendre les bonnes cartes selon le sujet en recuperant le nom de la matiere de la route
  for(i, subjectList) in newFlashcardsGame.allDecks.enumerated() {
    if subjectList.subjectName == subjectDeckNameTrimed ?? "No subject" {
    try response.render("Deck.stencil", with: subjectList, forKey: "subjectList")
    }
  }
  next()
}

 Kitura.addHTTPServer(onPort: 8080, with: router)
 Kitura.run()
