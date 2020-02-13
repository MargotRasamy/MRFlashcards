import Kitura
import KituraStencil
import Foundation
import HeliumLogger
HeliumLogger.use()




// On importe le fichier CSV en string avec la fonction String()
//on lui passe en argument contentSOf : URL() pour recuperer le chemin du csv
 let csvImported = try? String(contentsOf : URL(fileURLWithPath:"./Sources/MRFlashcards/assets/csv/csv1.csv")) 
 // on fait un print pour verifier ce qu'il retourne et si le fichier est nil : avertissement
  print(csvImported ?? "You did not put your CSV files in the folder")



if let csv: String = csvImported{

  // fonction qui prend le texte du fichier et renvoit le tableau contenant les colonnes du CSV

  func convertStringToTab(stringToConvert: String) -> [[String]]{
    // creer le tableau de tableau qui sera retourne a la fin
    var csvTab : [[String]] = []
    // decouper le texte en lignes
    // for letter in stringToConvert! {

      //on decoupe le tableau en lignes avec CharacterSet.newlines car \n unix, \r mac et \r \n windows
      let converted: [String] = stringToConvert.components(separatedBy : CharacterSet.newlines)
      // for i in converted {

      // let converted2: [String] = i.components(separatedBy : ";")
      csvTab.append(converted)
      //}
      return csvTab
      

//       let str = "Swift 4.0 is the best version of Swift to learn, so if you're starting fresh you should definitely learn Swift 4.0."
// let replaced = str.replacingOccurrences(of: "4.0", with: "5.0")

   //}

  }

  let hello:[[String]] = convertStringToTab(stringToConvert: csvImported!)
  print(hello)




}


//cas du nil
else {
  print("i am nil because you did not put your CSV files in the folder")
}

  // for a in csvImported {
  //   print("hey")
  // }






// fonction qui prend le texte du fichier et renvoit le tableau contenant les colonnes du CSV
// func csvArray(csv: String) -> [[String]] {
  // creer le tableau de tableau qui sera retourne a la fin
  // decouper le texte en lignes
  // pour chaque ligne
    // decouper la ligne en colonne avec le caractere ";"
    // verifier qu'on a le bon nombre de colonnes
    // ajouter les colonnes dans le resultat final
  //retourner le resultat final
// }


let router = Router()

router.all(middleware: BodyParser())

 router.get("/") { request, response, next in
     //response.send(csvImported ?? "hey")
     response.send("hey")
     next()
 }

 Kitura.addHTTPServer(onPort: 8080, with: router)
 Kitura.run()
