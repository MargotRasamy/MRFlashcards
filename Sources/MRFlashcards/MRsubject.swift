import Kitura
import KituraStencil
import Foundation



//une classe pour chaque matiere/ deck
class MRsubject {
    var rawCsv: String
    var csvConverted : [[String]]
    var allElements : [String]
    var questions: [String]
    var responses: [String]

//un deck
    var deck : [Card]



//on cree le constructeur de la classe
    init() {
        self.questions = [] //tableau vide
        self.responses = []
        self.allElements = []
        self.rawCsv = csvImported! // on initialise rawCsv a la chaine du csv importe
        self.csvConverted = [[]]
        self.deck = []
    }

//cette fonction retourne les paires de questions et reponses
    func convertStringToTab(stringToConvert: String) -> [[String]]{
    

      //on decoupe le tableau en lignes avec CharacterSet.newlines car \n unix, \r mac et \r \n windows
      var lines: [String] = stringToConvert.components(separatedBy : CharacterSet.newlines)

      //filtrer le tableau en supprimant les string vide ""
        lines = lines.filter { $0 != "" }

          var matiere : [[String]] = []


        // on boucle sur le tableau converti
        for i in lines {
          //on separe chaque element du tableau en colomne, c'est-a-dire par ";"
          var column : [String] = i.components(separatedBy : ";")
          
          matiere.append(column) 
          
        }
        // print(matiere)
        
       csvConverted = matiere
       
      

      // self.questions = matiere

      return self.csvConverted
    }







//cette fonction retourne TOUS LES ELEMENTS A LA SUITE
    func extractAllElements(csvConverted : [[String]]) -> [String] {
      var allElements : [String] = []
      for i in csvConverted {
        for j in i {
          allElements.append(j)
        }
      }
      self.allElements = allElements
      return self.allElements

    }


//Cette fonction retourne un deck questions et un deck reponses
    func extractQuestions(csvConvertedAllElements : [String]) -> ([String], [String]) {
         var temoin : Bool = false
         var questions : [String] = []
         var responses : [String] = []
      for i in csvConvertedAllElements {
        if temoin == false {
          
          questions.append(i)
          
          temoin = true
        }
        else {
        
          responses.append(i)
          
          temoin = false
        }
      }
      self.questions = questions
      self.responses = responses
      // print(self.questions)
      // print(self.responses)
      return (self.questions, self.responses)

    }


//cette fonction retourne les cartes en structure
    func extractCards(csvConverted : [[String]]) -> [Card] {
      var temoin : Bool
      var card = Card(questionRecto : "", responseVerso : "")
          temoin = false
      for i in csvConverted {
          for j in i {

            if temoin == false {
              card.questionRecto = j
              
              
              temoin = true
            }
            else {
              card.responseVerso = j

              self.deck.append(card)
            
              
              temoin = false
            }

          }
      }


      print(deck)
      //on retourne deck
      return self.deck
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

