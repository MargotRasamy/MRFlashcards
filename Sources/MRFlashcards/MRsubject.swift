import Kitura
import KituraStencil
import Foundation


class MRsubject {
    var rawCsv: String
    var questions: [String]
    var responses: [String]

    init() {
        self.questions = [""]
        self.responses = [""]
        self.rawCsv = csvImported!
    }

    func convertStringToTab(stringToConvert: String) -> [String]{
    // creer le tableau de tableau qui sera retourne a la fin

    // decouper le texte en lignes
    // for letter in stringToConvert! {

      //on decoupe le tableau en lignes avec CharacterSet.newlines car \n unix, \r mac et \r \n windows
      var converted: [String] = stringToConvert.components(separatedBy : CharacterSet.newlines)
      // for i in converted {

      // let converted2: [String] = i.components(separatedBy : ";")
      self.questions = converted
      //}
      return self.questions
    }

}


// if let csv: String = csvImported{

//   // fonction qui prend le texte du fichier et renvoit le tableau contenant les colonnes du CSV

//   func convertStringToTab(stringToConvert: String) -> [[String]]{
//     // creer le tableau de tableau qui sera retourne a la fin
//     var csvTab : [[String]] = []
//     // decouper le texte en lignes
//     // for letter in stringToConvert! {

//       //on decoupe le tableau en lignes avec CharacterSet.newlines car \n unix, \r mac et \r \n windows
//       let converted: [String] = stringToConvert.components(separatedBy : CharacterSet.newlines)
//       // for i in converted {

//       // let converted2: [String] = i.components(separatedBy : ";")
//       csvTab.append(converted)
//       //}
//       return csvTab
      

// //       let str = "Swift 4.0 is the best version of Swift to learn, so if you're starting fresh you should definitely learn Swift 4.0."
// // let replaced = str.replacingOccurrences(of: "4.0", with: "5.0")

//    //}

//   }

//   let hello:[[String]] = convertStringToTab(stringToConvert: csvImported!)
//   print(hello)




// }


// //cas du nil
// else {
//   print("i am nil because you did not put your CSV files in the folder")
// }

