/*--- Description ---*/
/*

This program diagnoses fake patients based on their symptoms. I have a
set of patients and their symptoms in this file. What happens is that
the program attaches certainty factors to specific symptoms and
manitpulates the certainty factors to arrive at an overall certainty
factor for specific patients having specific diseases. From the command
line you can run the test(person,CF) rule and it will return all
diseases with a certainty factor > 0. If you run diagnose(person) from
the command line it will return the diseases that they have as well as
any case where the program is not sure if they do or do not have the
disease.

*/


/*--- Inadequacies of my program ---*/
/*

I have all of the patient's information in this file. I would like to
take that out of the file and make my system learn a person's symptoms
from them inputing them in the command line. I would use a list to act
as working memory.

I would very much like to factor in a patient's lifestyle and genetic
history, not only their symptoms as an influence in my
program's diagnosis. I would do this by simply adding predicates such as
smoker(person) and historyHeartDisease(person). My system would attach
certainty factors to those the same way it currently does to symptoms.

I would also like to factor in tests of their physical condition such as
bloodPressure(person,low) and heartRate(person,average).

No disease has greater than 5 symptoms, this is not the case in the real
world. I would add more.

I would like to make it so that patients need at least 3 symptoms of a
disease to be diagnosed with it. I would do this by counting the number
of symptoms they have that relate to a given disease and not diagnose
them unless they have 3 or more.

The certainty factor is never negative because I don't see how having
one symptom would decrease the likelyhood of having a disease. If that
is something that exists in the real world, I would change the section
called "Rules for determining overall certainty factor" to account for
that since manipulating certainty factors doesn't work the same when
they are negative.

If you have a cough for example, this system says that it is equally
likely that you have either a cold or lung cancer because coughing is a
symptom of both diseases. Obviously this does not match with the real
world. I would like to make it more accurate by factoring in bayes'
rule.

*/

/* AUTHOR'S NOTE:
 *
 *  In the section called "Rules for determining overall certainty
 *  factor" I expanded the formula O1 = A+B - A*B to include more than
 *  two certainty factors by treating (A+B - A*B) as it's own certainty
 *  factor and adding another to it such as O2 = O1+C - O1*C or more
 *  specifically O2 = (A+B - A*B)+C - (A+B - A*B)*C. I countinued this
 *  out to include 5 certainty factors but it quickly became very hard
 *  to read, that is why I'm adding this explanation.
 *
*/

/* AUTHOR'S NOTE:
 *
 *  From the command line the only types of queries that should be
 *  called are test(person,CF) and diagnose(person)
 *
*/

/*--- People and their symptoms ---*/

runnyNose(kevin).

soreThroat(kevin).
soreThroat(jack).

cough(jim).
cough(kevin).
cough(paul).

congestion(kevin).

sneezing(kevin).

fatigue(jim).
fatigue(jen).
fatigue(paulo).
fatigue(cameron).
fatigue(chris).

troubleBreathing(jim).
troubleBreathing(chris).

dizzy(chris).
dizzy(paul).
dizzy(sophie).

tinglingLegs(chris).

soreTongue(chris).

darkUrine(jen).
darkUrine(paulo).

fever(paulo).
fever(theresa).
fever(mary).

nausea(theresa).
nausea(jen).
nausea(paulo).
nausea(paul).
nausea(jason).

yellowEyes(jen).
yellowSkin(jen).

badBreath(kevin).

bleedingGums(sue).

recedingGums(sue).

looseTeeth(sue).

sensitiveTeeth(sue).

chestPain(jim).
chestPain(paul).
chestPain(jason).

lossOfAppetite(jim).
lossOfAppetite(paulo).
lossOfAppetite(paul).

wateryStool(theresa).

bloodyStool(theresa).

urgentNeedForBM(theresa).

difficultySwallowing(jack).

swollenLymphNodes(jack).

whiteThroatSpots(mary).

yellowThroatSpots(jack).

bloodyDischarge(alex).

painfulUrination(alex).

painfulTesticles(alex).

painfulBM(alex).
painfulBM(jim).

analItching(jack).

armPain(paul).

sweaty(paul).
sweaty(jason).

excessiveThirst(cameron).

excessiveHunger(cameron).

increasedUrination(cameron).

blurryVision(cameron).

/* --- Certainty factors relating to specific symptoms ---*/

hasSnot(X,N) :- (runnyNose(X); congestion(X)) -> N is 0.7; N is 0.0.

hasSoreThroat(X,N) :- soreThroat(X) -> N is 0.25; N is 0.0.

hasCough(X,N) :- cough(X) -> N is 0.3; N is 0.0.

hasSneezing(X,N) :- sneezing(X) -> N is 0.2; N is 0.0.

hasFatigue(X,N) :- fatigue(X) -> N is 0.2; N is 0.0.
/*hasFatigue(X,N) :- (\+fatigue(X) ; N is 0.2) ; N is 0.0.*/

hasTroubleBreathing(X,N) :- troubleBreathing(X) -> N is 0.3; N is 0.0.

hasDizzy(X,N) :- dizzy(X) -> N is 0.3; N is 0.0.

hasTinglingLegs(X,N) :- tinglingLegs(X) -> N is 0.6; N is 0.0.

hasSoreTongue(X,N) :- soreTongue(X) -> N is 0.5; N is 0.0.

hasDarkUrine(X,N) :- darkUrine(X) -> N is 0.65; N is 0.0.

hasFever(X,N) :- fever(X) -> N is 0.1; N is 0.0.

hasNausea(X,N) :- nausea(X) -> N is 0.2; N is 0.0.

hasJaundice(X,N) :- (yellowSkin(X), yellowEyes(X)) -> N is 0.65; N is 0.0.

hasBadBreath(X,N) :- badBreath(X) -> N is 0.2; N is 0.0.

hasBleedingGums(X,N) :- bleedingGums(X) -> N is 0.4; N is 0.0.

hasRecedingGums(X,N) :- recedingGums(X) -> N is 0.6; N is 0.0.

hasLooseTeeth(X,N) :- looseTeeth(X) -> N is 0.4; N is 0.0.

hasSensitiveTeeth(X,N) :- sensitiveTeeth(X) -> N is 0.4; N is 0.0.

hasChestPain(X,N) :- chestPain(X) -> N is 0.4; N is 0.0.

hasLossOfAppetite(X,N) :- lossOfAppetite(X) -> N is 0.3; N is 0.0.

hasWateryStool(X,N) :- wateryStool(X) -> N is 0.6; N is 0.0.

hasBloodyStool(X,N) :- bloodyStool(X) -> N is 0.5; N is 0.0.

hasUrgentNeedForBM(X,N) :- urgentNeedForBM(X) -> N is 0.5; N is 0.0.

hasDifficultySwallowing(X,N) :- difficultySwallowing(X) -> N is 0.3; N is 0.0.

hasSwollenLymphNodes(X,N) :- swollenLymphNodes(X) -> N is 0.4; N is 0.0.

hasColouredThroatSpots(X,N) :- (whiteThroatSpots(X) ; yellowThroatSpots(X)) -> N is 0.7; N is 0.0.

hasBloodyDischarge(X,N) :- bloodyDischarge(X) -> N is 0.6; N is 0.0.

hasPainfulUrination(X,N) :- painfulUrination(X) -> N is 0.7; N is 0.0.

hasPainfulTesticles(X,N) :- painfulTesticles(X) -> N is 0.6; N is 0.0.

hasPainfulBM(X,N) :- painfulBM(X) -> N is 0.2; N is 0.0.

hasAnalItching(X,N) :- analItching(X) -> N is 0.3; N is 0.0.

hasArmPain(X,N) :- armPain(X) -> N is 0.5; N is 0.0.

hasSweaty(X,N) :- sweaty(X) -> N is 0.3; N is 0.0.

hasExcessiveThirst(X,N) :- excessiveThirst(X) -> N is 0.4; N is 0.0.

hasExcessiveHunger(X,N) :- excessiveHunger(X) -> N is 0.4; N is 0.0.

hasIncreasedUrination(X,N) :- increasedUrination(X) -> N is 0.6; N is 0.0.

hasBlurryVision(X,N) :- blurryVision(X) -> N is 0.2; N is 0.0.

/*--- Rules for determining overall certainty factor ---*/

hasCold(X,N) :-
	hasSnot(X,C1),
	hasSoreThroat(X,C2),
	hasCough(X,C3),
	hasSneezing(X,C4),
	N is ((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4.

hasAnemia(X,N) :-
	hasFatigue(X,C1),
	hasTroubleBreathing(X,C2),
	hasDizzy(X,C3),
	hasTinglingLegs(X,C4),
	hasSoreTongue(X,C5),
	N is (((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)+C5-
	(((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)*C5.

hasHepatitisB(X,N) :-
	hasDarkUrine(X,C1),
	hasFever(X,C2),
	hasNausea(X,C3),
	hasFatigue(X,C4),
	hasJaundice(X,C5),
	N is (((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)+C5-
	(((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)*C5.

hasPeridontalDisease(X,N) :-
	hasBadBreath(X,C1),
	hasBleedingGums(X,C2),
	hasRecedingGums(X,C3),
	hasLooseTeeth(X,C4),
	hasSensitiveTeeth(X,C5),
	N is (((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)+C5-
	(((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)*C5.

hasLungCancer(X,N) :-
	hasCough(X,C1),
	hasChestPain(X,C2),
	hasLossOfAppetite(X,C3),
	hasTroubleBreathing(X,C4),
	hasFatigue(X,C5),
	N is (((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)+C5-
	(((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)*C5.

hasDiarrhea(X,N) :-
	hasWateryStool(X,C1),
	hasBloodyStool(X,C2),
	hasFever(X,C3),
	hasNausea(X,C4),
	hasUrgentNeedForBM(X,C5),
	N is (((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)+C5-
	(((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)*C5.

hasStrepThroat(X,N) :-
	hasSoreThroat(X,C1),
	hasDifficultySwallowing(X,C2),
	hasFever(X,C3),
	hasSwollenLymphNodes(X,C4),
	hasColouredThroatSpots(X,C5),
	N is (((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)+C5-
	(((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)*C5.

hasSTD(X,N) :-
	hasBloodyDischarge(X,C1),
	hasPainfulUrination(X,C2),
	hasPainfulTesticles(X,C3),
	hasPainfulBM(X,C4),
	hasAnalItching(X,C5),
	N is (((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)+C5-
	(((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)*C5.

hasHeartDisease(X,N) :-
	hasChestPain(X,C1),
	hasArmPain(X,C2),
	hasSweaty(X,C3),
	hasNausea(X,C4),
	hasDizzy(X,C5),
	N is (((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)+C5-
	(((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)*C5.

hasT2Diabetes(X,N) :-
	hasExcessiveThirst(X,C1),
	hasExcessiveHunger(X,C2),
	hasIncreasedUrination(X,C3),
	hasFatigue(X,C4),
	hasBlurryVision(X,C5),
	N is (((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)+C5-
	(((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)+C4-((C1+C2-C1*C2)+C3-(C1+C2-C1*C2)*C3)*C4)*C5.

/*--- Rules for determining a patient's overall condition ---*/

test(X,N) :- hasCold(X,N), N > 0 -> nl, write("Cold certainty: ").
test(X,N) :- hasAnemia(X,N), N > 0 -> nl, write("Anemia certainty: ").
test(X,N) :- hasHepatitisB(X,N), N > 0 -> nl, write("Hepatitis B certainty: ").
test(X,N) :- hasPeridontalDisease(X,N), N > 0 -> nl, write("Peridontal Disease certainty: ").
test(X,N) :- hasLungCancer(X,N), N > 0 -> nl, write("Lung Cancer certainty: ").
test(X,N) :- hasDiarrhea(X,N), N > 0 -> nl, write("Diarrhea certainty: ").
test(X,N) :- hasStrepThroat(X,N), N > 0 -> nl, write("Strep Throat certainty: ").
test(X,N) :- hasSTD(X,N), N > 0 -> nl, write("STD certainty: ").
test(X,N) :- hasHeartDisease(X,N), N > 0 -> nl, write("Heart Disease certainty: ").
test(X,N) :- hasT2Diabetes(X,N), N > 0 -> nl, write("Type 2 Diabetes certainty: ").

diagnose(X) :- hasCold(X,N), N > 0.7 -> write(X), write(" has as a cold.") ;
               hasCold(X,N), N >= 0.5 -> write(X),
	       write(" may have a cold, further tests required.").
diagnose(X) :- hasAnemia(X,N), N > 0.7 -> write(X), write(" has as anemia.") ;
               hasAnemia(X,N), N >= 0.5 -> write(X),
	       write(" may have anemia, further tests required.").
diagnose(X) :- hasHepatitisB(X,N), N > 0.7 -> write(X), write(" has as hepatitis B.") ;
               hasHepatitisB(X,N), N >= 0.5 -> write(X),
	       write(" may have hepatitis B, further tests required.").
diagnose(X) :- hasPeridontalDisease(X,N), N > 0.7 -> write(X),
	       write(" has as peridontal disease.") ;
	       hasPeridontalDisease(X,N), N >= 0.5 -> write(X),
	       write(" may have peridontal disease, further tests required.").
diagnose(X) :- hasLungCancer(X,N), N > 0.7 -> write(X), write(" has as lung cancer.") ;
               hasLungCancer(X,N), N >= 0.5 -> write(X),
	       write(" may have lung cancer, further tests required.").
diagnose(X) :- hasDiarrhea(X,N), N > 0.7 -> write(X), write(" has as diarrhea.") ;
               hasDiarrhea(X,N), N >= 0.5 -> write(X),
	       write(" may have diarrhea, further tests required.").
diagnose(X) :- hasStrepThroat(X,N), N > 0.7 -> write(X), write(" has as strep throat.") ;
               hasStrepThroat(X,N), N >= 0.5 -> write(X),
	       write(" may have strep throat, further tests required.").
diagnose(X) :- hasSTD(X,N), N > 0.7 -> write(X), write(" has as an STD.") ;
               hasSTD(X,N), N >= 0.5 -> write(X),
	       write(" may have an STD, further tests required.").
diagnose(X) :- hasHeartDisease(X,N), N > 0.7 -> write(X), write(" has as heart disease.") ;
               hasHeartDisease(X,N), N >= 0.5 -> write(X),
	       write(" may have heart disease, further tests required.").
diagnose(X) :- hasT2Diabetes(X,N), N > 0.7 -> write(X), write(" has as type 2 diabetes.") ;
               hasT2Diabetes(X,N), N >= 0.5 -> write(X),
	       write(" may have type 2 diabetes, further tests required.").


/*

TOP 10 MOST COMMON HEALTH DISEASES (according to livestrong.com)
+-----------------------------+
|         Common Cold         |
|                             |
|	    Anemia            |
|                             |
|         Hepatitis B         |
|                             |
|    Peridontal Disease	      |
|                             |
|         Lung Cancer         |
|                             |
|	   Diarrhea	      |
|                             |
|         Strep Throat        |
|                             |
|Sexually Transmitted Diseases|
|                             |
|	 Heart Disease        |
|                             |
|       Type 2 Diabetes       |
+-----------------------------+

*/


/*

1 ?- test(sue,CF).

Peridontal Disease certainty:
CF = 0.9136000000000002 ;
false.

2 ?- diagnose(sue).
sue has as peridontal disease.
true ;
false.

3 ?- test(jim,CF).

Cold certainty:
CF = 0.3 ;

Anemia certainty:
CF = 0.44 ;

Hepatitis B certainty:
CF = 0.2 ;

Lung Cancer certainty:
CF = 0.83536 ;

STD certainty:
CF = 0.2 ;

Heart Disease certainty:
CF = 0.4 ;

Type 2 Diabetes certainty:
CF = 0.2.

4 ?- diagnose(jim).
jim has as lung cancer.
true ;
false.

5 ?- diagnose(paul).
paul has as lung cancer.
true ;
paul has as heart disease.
true ;
false.

6 ?- test(paul,CF).

Cold certainty:
CF = 0.3 ;

Anemia certainty:
CF = 0.3 ;

Hepatitis B certainty:
CF = 0.2 ;

Lung Cancer certainty:
CF = 0.706 ;

Diarrhea certainty:
CF = 0.2 ;

Heart Disease certainty:
CF = 0.8823999999999999 ;
false.

7 ?- diagnose(cameron).
cameron has as type 2 diabetes.
true.

8 ?- test(cameron,CF).

Anemia certainty:
CF = 0.2 ;

Hepatitis B certainty:
CF = 0.2 ;

Lung Cancer certainty:
CF = 0.2 ;

Type 2 Diabetes certainty:
CF = 0.90784.

9 ?- test(jason,CF).

Hepatitis B certainty:
CF = 0.2 ;

Lung Cancer certainty:
CF = 0.4 ;

Diarrhea certainty:
CF = 0.2 ;

Heart Disease certainty:
CF = 0.664 ;
false.

10 ?- diagnose(jason).
jason may have heart disease, further tests required.
true ;
false.

11 ?- test(jen,CF).

Anemia certainty:
CF = 0.2 ;

Hepatitis B certainty:
CF = 0.9216000000000001 ;

Lung Cancer certainty:
CF = 0.2 ;

Diarrhea certainty:
CF = 0.2 ;

Heart Disease certainty:
CF = 0.2 ;

Type 2 Diabetes certainty:
CF = 0.2.

12 ?- diagnose(jen).
jen has as hepatitis B.
true ;
false.

13 ?- test(alex,CF).

STD certainty:
CF = 0.9616000000000001 ;
false.

14 ?- diagnose(alex).
alex has as an STD.
true ;
false.

15 ?- diagnose(theresa).
theresa has as diarrhea.
true ;
false.

16 ?- test(theresa,CF).

Hepatitis B certainty:
CF = 0.28 ;

Diarrhea certainty:
CF = 0.9279999999999999 ;

Strep Throat certainty:
CF = 0.1 ;

Heart Disease certainty:
CF = 0.2 ;
false.

17 ?- diagnose(jack).
jack has as strep throat.
true ;
false.

18 ?- test(jack,CF).

Cold certainty:
CF = 0.25 ;

Strep Throat certainty:
CF = 0.9054999999999999 ;

STD certainty:
CF = 0.3 ;
false.

*/
















