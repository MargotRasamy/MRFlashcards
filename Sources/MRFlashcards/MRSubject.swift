import Kitura
import KituraStencil
import Foundation

class MRFlashcardsGame {
  var allDecks : [MRSubjectDeck] // un tableau contenant toutes les matieres/piles de cartes
    init() {
        self.allDecks = []
    }

  //une fonction qui prend en parametre le path du folder de csv et retourne les decks
  func createDecksFromCsv(csvFolderPath : String) -> [MRSubjectDeck] {

    //Initialisation de variables
    var rawCsvDatasArray : [String] = [] // Tableau ["Question1;Question2\nQuestion1;Question2"]
    var subjectNames : [String] = [] // tableau ["Matiere1", "Matiere2"]
    var newDeck = MRSubjectDeck(subjectName : "", deck: []) // Nouvelle structure deck pour une matiere
    var csvFolder : [String]? = try? FileManager.default.contentsOfDirectory(atPath: csvFolderPath) // tableau ["Matiere1.csv", "matiere2.csv"]
    var deckOfCardsArray : [[[String]]] = [] //Tableau de matiere contenant des decks de cartes


    // 1ere etape : Extraire les noms des csv(matiere) et leurs chemins
    for csv in csvFolder ?? ["No subject created yet"]{ //On itere sur le dossier de csv pour avoir les noms des matieres et leurs chemins    
      var subject : String = csv.replacingOccurrences(of: ".csv", with: "") // subject est le nom d'une matiere sans .csv
      subjectNames.append(subject) // tableau des noms des matieres
      var csvData : String? = try? String(contentsOf : URL(fileURLWithPath: csvFolderPath + "/" + csv)) //csvData est la String contenant l'information du csv
      rawCsvDatasArray.append(csvData ?? "No question created; No response created") // on ajoute chaque chaine d'information csv dans un tableau
    }



    //2eme etape : Decouper l'information du csv en lignes et colomnes
    for csvData in rawCsvDatasArray { // On itere sur le tableau de d'infos du csv brutes pour decouper en lignes et colomnes
      var lines: [String] = csvData.components(separatedBy : CharacterSet.newlines) //on decoupe le tableau en lignes avec CharacterSet.newlines car \n unix, \r mac et \r \n windows  
      lines = lines.filter { $0 != "" } //filtrer le tableau en supprimant les string vide ""
      var cardPairs : [[String]] = [] // tableau de tableau de pair de cartes
      for line in lines { //On itere sur les lignes obtenues precedemment pour obtenir separer par colomnes
        var column : [String] = line.components(separatedBy : ";") //on separe chaque element du tableau en colomne, c'est-a-dire par ";"
        cardPairs.append(column) // On ajoute les 2 colomnes dans cardPairs qui regroupe les pairs Q et R   
      }
      deckOfCardsArray.append(cardPairs) // on ajoute le tableau de pairs Q/R
    }


    //3eme etape : Repartir les cartes questions et reponses dans les structures de type Card
    for indexOfDecks in 0..<deckOfCardsArray.count { //On itere sur la longueur du tableau d'informations du csv
      var card = MRCard(questionRecto : "", responseVerso : "") // On initialise une carte de type MRCard avec des informations vides
      var deckCards : [MRCard] = [] //Tableau doit TOUJOURS etre reinitialiser a vide a chaque tour de boucle
      var oddEvenIndicator : Bool = false // On cree un booleen initialise a False pour nous indiquer si la carte est paire (Question) ou impaire (Reponse)
      for cardPair in deckOfCardsArray[indexOfDecks]  { // On itere sur les piles de carte
        for cardSide in cardPair { //On itere sur les cartes : paire Question/Reponse 
          if oddEvenIndicator == false { //On entre dans le if car le booleen est a false
            card.questionRecto = cardSide // On prend la premiere carte (Question)
            oddEvenIndicator = true
          }
          else {
            card.responseVerso = cardSide // On prend la premiere carte (Question)
            deckCards.append(card) // On ajoute la carte a la pile de carte en boucle
            oddEvenIndicator = false
          }
        }
      }
      newDeck.subjectName = subjectNames[indexOfDecks] // On affecte a newDeck.subjectName le nom selon l'index
      newDeck.deck = deckCards // On affecte la pile de carte a newDeck.deck
      allDecks.append(newDeck) // On ajoute la pile de carte newDeck a allDecks(contient toutes les piles/matieres)
    }

    return allDecks // on retourne enfin toutes les matieres/piles de cartes
  }

}
