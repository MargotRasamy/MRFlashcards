import Kitura
import KituraStencil
import Foundation
import HeliumLogger
HeliumLogger.use()

// router.all(middleware: [BodyParser(), StaticFileServer(path: "./Public")])
// router.add(templateEngine: StencilTemplateEngine())





// On importe le fichier CSV en string avec la fonction String()
//on lui passe en argument contentSOf : URL() pour recuperer le chemin du csv

 let csvImported = try? String(contentsOf : URL(fileURLWithPath:"./Sources/MRFlashcards/assets/csv/csv1.csv")) 

 // on fait un print pour verifier ce qu'il retourne et si le fichier est nil : avertissement

  print(csvImported ?? "You did not put your CSV files in the folder")


//STEP 1

//si le csv importe n'est pas nil
if let csv: String = csvImported{

  let nouvelleMatiere = MRsubject()
  nouvelleMatiere.convertStringToTab(stringToConvert: csvImported!)
  print(nouvelleMatiere.csvConverted)

  nouvelleMatiere.extractAllElements(csvConverted : nouvelleMatiere.csvConverted)
  nouvelleMatiere.extractQuestions(csvConvertedAllElements : nouvelleMatiere.allElements)
  print(nouvelleMatiere.responses)
  print(nouvelleMatiere.questions)
  
 
  









}



//si le csv importe est nil
else {
  print("i am nil because you did not put your CSV files in the folder")
}







let router = Router()


router.all(middleware: [BodyParser(), StaticFileServer(path: "./Public")])
router.add(templateEngine: StencilTemplateEngine())



 router.get("/") { request, response, next in
    // response.send(csvImported ?? "hey")
     
        var hello : String = ""

    if let body = request.body?.asURLEncoded {
        } 
        else {
           response.status(.notFound)
       }
    try response.render("Home.stencil", context: [ hello  : ""] )


     
     next()
 }


 Kitura.addHTTPServer(onPort: 8080, with: router)
 Kitura.run()
