import Kitura
import KituraStencil
import Foundation

//une classe pour chaque matiere/ deck
class MRSubject {
    var csvFolderPath : String = "./Sources/MRFlashcards/assets/csv"
    var allDecks : [MRSubjectDeck] 
    // var deck : [MRCard]
    var arrayOfCsvDatas : [String]

//on cree le constructeur de la classe
    init() {
        self.csvFolderPath = "./Sources/MRFlashcards/assets/csv"
        self.allDecks = []
        // self.deck = []
      
        self.arrayOfCsvDatas = []
    }






//FONCTION ULTIME


//une fonction qui prend en parametre le path du folder de csv et retourne les decks
func createDecksFromCsv(csvFolderPath : String) -> [MRSubjectDeck] {
  var subjectNames : [String] = []

  var newDeck = MRSubjectDeck(subjectName : "", deck: [])

  // csv Folder est un tableau avec les noms des fichiers en string
  var csvFolder : [String]? = try? FileManager.default.contentsOfDirectory(atPath: csvFolderPath)
  //On boucle sur le dossier de csv pour avoir les noms des matieres et leurs chemins
  
for csv in csvFolder ?? ["No subject created yet"]{
  
  var subject : String = csv.replacingOccurrences(of: ".csv", with: "")
  subjectNames.append(subject)

  var csvData : String? = try? String(contentsOf : URL(fileURLWithPath: csvFolderPath + "/" + csv))
  arrayOfCsvDatas.append(csvData ?? "No question created; No response created")

}
print(arrayOfCsvDatas) //we have ["questojorjgtr", " questions.."]



//2nd step we take the path and turn it into cards in array form 
  var arrayOfDecksOfCards : [[[String]]] = []

  for csvDataString in arrayOfCsvDatas {
  //on decoupe le tableau en lignes avec CharacterSet.newlines car \n unix, \r mac et \r \n windows
      var lines: [String] = csvDataString.components(separatedBy : CharacterSet.newlines)
      //filtrer le tableau en supprimant les string vide ""
        lines = lines.filter { $0 != "" }
        var cardPairs : [[String]] = []
        // on boucle sur le tableau converti
        for i in lines {
          //on separe chaque element du tableau en colomne, c'est-a-dire par ";"
          var column : [String] = i.components(separatedBy : ";")
          
          cardPairs.append(column) 
          
        }
        arrayOfDecksOfCards.append(cardPairs)
  }



  //3rd 
  //var allDecks : [MRSubjectDeck]  



    for indexOfDecks in 0..<arrayOfDecksOfCards.count {

      var card = MRCard(questionRecto : "", responseVerso : "")
      var deckCards : [MRCard] = [] //Never move variables for nothing
      var temoin : Bool = false
      for cardPair in arrayOfDecksOfCards[indexOfDecks]  { // csvConverted c [[String]] ou ss
          for cardSide in cardPair {

            if temoin == false {
              card.questionRecto = cardSide
              temoin = true
            }
            else {
              card.responseVerso = cardSide
              deckCards.append(card)
              temoin = false
            }

          }
      }
      
      newDeck.subjectName = subjectNames[indexOfDecks]
      newDeck.deck = deckCards
      allDecks.append(newDeck)




    }



return allDecks
}



//FIN DE LA FONCTION ULTIME










}
