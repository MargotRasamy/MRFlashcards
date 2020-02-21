import Kitura
import KituraStencil
import Foundation

//une classe pour chaque matiere/ deck
class MRSubject {
    var deck : [MRCard] 

//on cree le constructeur de la classe
    init() {
        self.deck = []
    }





// La fonction principale a utiliser pour obtenir un deck a partir d'une string de csv
    func createDeckFromCsv(stringToConvert: String) -> [MRCard]{
      //on decoupe le tableau en lignes avec CharacterSet.newlines car \n unix, \r mac et \r \n windows
      var lines: [String] = stringToConvert.components(separatedBy : CharacterSet.newlines)
      //filtrer le tableau en supprimant les string vide ""
        lines = lines.filter { $0 != "" }
        var cardPair : [[String]] = []
        // on boucle sur le tableau converti
        for i in lines {
          //on separe chaque element du tableau en colomne, c'est-a-dire par ";"
          var column : [String] = i.components(separatedBy : ";")
          
          cardPair.append(column) 
          
        }
        // print(cardPair)
        
       
       
      

      // self.questions = matiere
      extractCards(csvConverted : cardPair)
      print(deck[5].responseVerso)
      print(deck)
      return deck
    }




//cette fonction retourne les cartes en structure
    func extractCards(csvConverted : [[String]]) -> [MRCard] {
      var temoin : Bool = false
      var card = MRCard(questionRecto : "", responseVerso : "")
     
      for i in csvConverted {
          for j in i {

            if temoin == false {
              card.questionRecto = j
              temoin = true
            }
            else {
              card.responseVerso = j
              deck.append(card)
              temoin = false
            }

          }
      }


      
      //on retourne deck
      return deck
    }

}
