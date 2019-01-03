# Doctor-Bot

This was originally an academic project, it was made for COMP 3190, Introduction to Artificial Intelligence, fall 2016 at the University of Manitoba.

## \*\*\* DISCLAIMER \*\*\*
This project should not be used to diagnose people. Any and all results from this project have no basis in medicine and should not be treated as if they do. Under no circumstance should anyone consider the output from this project to be medical advice.

## Description

This bot has a list of fake people in its knowledge base and a list of their symptoms. From the Prolog console you can call the functions `diagnose()` and `test()` like this: `diagnose(kevin)` and `test(jason, CF)`.

This program diagnoses fake patients based on their symptoms. A set of fake patients and their symptoms are in the [app.pl](./app.pl) file. The program arrives at an overall certainty factor for these patients having diseases by attaching certainty factors to specific symptoms and using the existence of those symptoms to calculate the certainty factor for diseases. From the Prolog console you can run the `test(person,CF)` rule and it will return all diseases with a certainty factor > 0. If you run `diagnose(person)` from the Prolog console it will return the diseases that they have as well as any case where the program is not sure if they do or do not have the disease.

## Transcript

I have included a transcript that can be found in the [Transcript.txt](./Transcript.txt) file and also exists as a comment at the end of the code in [app.pl](./app.pl)
