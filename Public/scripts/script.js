let decks = document.querySelectorAll('.deck')
let cardQuestion = document.querySelectorAll('.cardQuestion')
let cardResponse = document.querySelectorAll('.cardResponse')

var subjectName
var subjectNameTrimed // No white space for path

//etape 1 click pour redirection vers les routes
for(let i = 0; i<decks.length ; i++){
decks[i].addEventListener(
    
    'click',
    function(){
        subjectName = decks[i].innerHTML
        subjectNameTrimed = subjectName.replace(/\s/gi,'')
        window.location.href="/matiere/" + subjectNameTrimed
    }

    )

    
}


//2eme etape afficher et cacher les reponses
for(let j = 0; j < cardQuestion.length; j++){
    cardQuestion[j].addEventListener(
        'click',
        function(){
           
            cardResponse[j].classList.toggle("is-hidden")
        }
    )

}