var checkboxes = document.querySelectorAll('input[type="checkbox"]');
let submitButton = document.querySelector('button[type="submit"]');
let scoreDisplay = document.querySelector('#score');
var scoreCount
var rightAnswersCount

submitButton.addEventListener(
    'click',
    function(){  
        scoreCount = 0
        rightAnswersCount = 0
        for(let i=0; i<checkboxes.length; i++){
            if (checkboxes[i].checked){
                rightAnswersCount += 1
            }
        }
        scoreCount = (rightAnswersCount / checkboxes.length) * 100
        scoreDisplay.innerHTML = `Ton score est de ${scoreCount}%, soit ${rightAnswersCount}/${checkboxes.length} !`
    }
)

