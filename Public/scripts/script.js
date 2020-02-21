let decks = document.querySelectorAll('.deck')
var subjectName
var subjectNameTrimed // No white space for path


for(let i = 0; i<decks.length ; i++)
decks[i].addEventListener(
    
    'click',
    function(){
        subjectName = decks[i].innerHTML
        subjectNameTrimed = subjectName.replace(/\s/gi,'')
        window.location.href="/matiere/" + subjectNameTrimed
    }
)