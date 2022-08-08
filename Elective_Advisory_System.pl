% elective_fields
% for_Mtech
elective_field('Data Engineering').
elective_field('Information Security').
elective_field('Artifical Intelligence').
elective_field('Mobile Computing').


% corresponding_electives
elective('Database System Implementation','GPU Computing','Cloud Computing and Virtualization','Mining Large Networks','Statistical Mobile Computing','Data Engineering').
elective('Secure Coding','Distributed Systems Security','Applied Cryptography','Digital and Cyber Forensics','Ethical Hacking','Information Security').
elective('Advanced Mobile Computing','Multi-Agent Systems','Reinforcement Learning','Data Mining','Natural Language Processing','Artifical Intelligence').
elective('Distributed Systems Security','Ad Hoc Wireless Networks','Introduction to Spatial Computing','Network Anonymity and Privacy','Smart Sensing for Internet of Things','Mobile Computing').

% driver_function
main:-

	write('\t\t--------ELECTIVE ADVISORY SYSTEM USING PROLOG--------'),nl,sleep(0.25),
        retractor(),nl,
	write('How to give answer: Type y. for Yes and n. for No'), sleep(0.25), nl,
	write('For value input: Type value.'),nl,nl,
	write('Questions regarding your interest in the field of Computer Science:-'),nl,
	ask_user_interests(_),
	ask_user_job,
	ask_user_research,nl,
	write('Questions regarding your background information:-'), sleep(0.25),nl ,nl,
	ask_user_GPA,
	ask_competitive_programming,
	ask_user_INTERNSHIP,
	write('\t\t\t----------- FUTURE ADVICE FOR YOU ---------'), nl,
	write('So our final advice is as follows - '), nl, sleep(0.25),
	final_advice_generated(_, _, _, _, _),
	feedback.

% functions_to_fetch_user_inetrest_and_make_corresponding_fact

ask_user_interests(Interest) :-
	elective_field(Interest),
	user_interested(Interest),
	assert(recommended(Interest)),fail.

ask_user_interests(_) :-
	nl, convert_to_list(List),
	write('Based on your interest in the Fields: '),
	write(List), nl,nl,write('\t\t----------- ELECTIVE RECOMMENDED FOR YOU -----------'),nl,print_elective(List),nl,!,
	assert(interest_list(List)).

% function_to_print_electives

print_elective([]).

print_elective([X|T]):-
	elective(E1,E2,E3,E4,E5,X),write(E1),nl,write(E2),nl,write(E3),nl,write(E4),nl,write(E5),nl,
        print_elective(T).

user_interested(Interest) :-
	nl,
	write('Are you interested in '), write(Interest), write(':'),
	read(Y), Y = y,
	write('How many courses you had completed in: '), write(Interest), write('?'),
	read(X), X >= 2,
	write('What is your average GPA in these courses: '), write(Interest),write('?'),
	read(A), A >= 8.

% function_to_convert_items_to_list

convert_to_list([Px|Tail]) :-
	elective_field(Px),
	retract(recommended(Px)),
	convert_to_list(Tail).

convert_to_list([]).

% Job_Details
ask_user_job:- write('Are you interested in an delivering engineer Role ?'), nl, read(Y), nl, decide_job(Y).
decide_job(Y) :- Y = y, assert(job('True')).
decide_job(Y) :- Y = n, assert(job('False')).

% CP_Details
ask_competitive_programming:- write('Are you a competitive programming enthusiastic?'), nl, read(Y), nl, make_competitive_programming(Y).
make_competitive_programming(Y) :- Y = y, assert(cp('good')).
make_competitive_programming(Y) :- Y = n, assert(cp('bad')).

% GPA_Details
ask_user_GPA:- write('What is your current GPA?'), nl, read(Y), nl, ask_user_GPA(Y).
ask_user_GPA(Y) :- Y >= 8, assert(gpa('good')).
ask_user_GPA(Y) :- Y < 8, assert(gpa('bad')).

% Research_Details
ask_user_research:- write('Are you interested in doing Research ?'), nl, read(Y), nl, make_research(Y).
make_research(Y) :- Y = y, assert(research('True')).
make_research(Y) :- Y = n, assert(research('False')).

% INTERNSHIP_Details
ask_user_INTERNSHIP:- write('Have you done any internship?'), nl, read(Y), nl, make_user_internship(Y).
make_user_internship(Y) :- Y = y, assert(internship('True')).
make_user_internship(Y) :- Y = n, assert(internship('False')).


advice_elective_field([X | Tail]) :- elective_field(X), interest_list([X | Tail]),!, write(X), nl, sleep(0.25),advice_elective_field(Tail).
advice_elective_field([]).
advice_elective_field([X | Tail]) :- elective_field(X), write(X), nl, advice_elective_field(Tail), sleep(0.25).

retractor():-
     retractall(internship(_)),
     retractall(feedback(_)),
     retractall(gpa(_)),
     retractall(interest_list(_)),
     retractall(research(_)),
     retractall(job(_)),
     retractall(cp(_)).

% cases_for_different_final_career_advice_for_user

final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'True', JL = 'False', IL = 'False', GL = 'bad', CL = 'good',
	write('CASE 2'), nl,
	write('Although you have some interest in research but it would better to go for a job in career because you are lacking in research experience.'),nl,
	write('and your GPA-CP shows that it will be better if you go a engineer job.').

final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'True', JL = 'True', IL = 'False', (GL = 'bad'; CL = 'good'),nl,
	write('CASE 1 - 3 cases'), nl,
	write('System advices you go for a job because you dont have any research experince.'),nl,
	write('and your GPA-CP shows that it will be better if you go a engineer job.').

final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'True', JL = 'False', IL = 'True', GL = 'good',
	write('CASE 3'), nl,
	write('You are perfect enough for persuing solid research career. You have a good GPA and research experince.'), nl,
	write('Keep going !!! You are on the right track.').

final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'True', JL = 'False', IL = 'False', GL = 'good',
	write('CASE 5'),nl,
	write('The interest in research is good enough. You have a good GPA too, however no research experince (NO INTERNSHIP)  will be a problem for you.'), nl,
	write('System advices you do some reseach based work').

final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'True', JL = 'True', IL = 'True', (GL = 'good'; CL = 'bad'),
	write('CASE 6 - 3 cases'), nl,
	write('System advices you go for researh becasue you have no in competitive programming.'),nl,
	write('and your GPA-INTERNSHIP shows that it will be better if you go a research role based job. ').

final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'True', JL = 'False', IL = 'True', (GL = 'good'; CL = 'bad'),
	write('CASE 7'), nl,
	write('Although your want a engineer job, it would better to go for a research because you do not have any interest in competitive programming'),nl,
	write('and your GPA-INTERNSHIP shows that it will be better if you go a research role based job.').

final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'True', JL = 'False', IL = 'True', GL = 'bad',
	write('CASE 4'),nl,
	write('Your interest in research is good enough. You have a good research experince too, however your GPA is not quite good'), nl,
	write('System advices you to work on your GPA and then go for a research further or pursue further studies'), nl.

final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'False', JL = 'True', CL = 'good', GL = 'good',
	write('CASE 8'), nl,
	write('You are perfect person for persuing solid engineer career ahead, and its a advantage that you have good GPA and also you are intrested in competitive programming.'), nl.


final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'False', JL = 'True', CL = 'good', GL = 'bad',
	write('CASE 7'),nl,
	write('The decision of going for an enigneer job is good. You have an interest in Competitive programming which will be a plus point for you.'), nl,
	write('System advices you to focus on getting a good GPA.'), nl.



final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'False', JL = 'False',IL = 'True' ,CL = 'good',
	write('CASE 9'), nl,
	write('You are good to go for either research or job role becasue you have good GPA and also intrest in competitive programming.').

final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'False', JL = 'False',IL = 'False' ,CL = 'good',
	write('CASE 10'), nl,
	write('This is strange that have no interest in doing research because you have research experience.'),
	write('So System advices you to go for the research role.').

final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'False', JL = 'False',IL = 'True' ,CL = 'bad',
	write('CASE 11'), nl,
	write('This is strange that have no interest in doing research because you have research experience.'),
	write('So System advices you to go for the research role.').

final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'False', JL = 'True', CL = 'bad', GL = 'good',
	write('CASE 8'),nl,
	write('The decision of going for an enigneer job is good, you have a decent GPA, however you should work on your competitive programming skills because that will be major plus point in engineer job.'), nl.


final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'False', JL = 'False', IL = 'False' , CL = 'bad',
	write('CASE 12'), nl,
	write('It seems that you are testing the system, Try again some other time :)').

final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'True', JL = 'True',IL = 'True' , CL = 'good', GL = 'good',
	write('CASE 13'), nl,
	write('You are good to go for either research or job role becasue you have good research experience and also interest in competitive programming.'),
	write('and a GOOD GPA too.').

final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'True', JL = 'True',IL = 'False' ,CL = 'good',
	write('CASE 14'), nl,
	write('System advices you go for engineer role because you are lacking in research experience but you have interest in Competitive programming.').

final_advice_generated(RL, JL, IL, GL, CL) :-
	research(RL), job(JL), internship(IL), gpa(GL), cp(CL),
	RL = 'True', JL = 'True',IL = 'False' ,CL = 'bad', GL = 'bad',
	write('CASE 15'), nl,
	write('It seems that you are showing your interest but do not have interest in real.'),
	write('System suggest you not doing that and work hard and develop the interest in the field you love.'),
	write('If you are confused in going for any role, the engineer role will be the best option for you.').

% printing_ending_greet_message

feedback:-
	nl,
	write('Thank you for using this system, Hope it helps you choosing your electives and gives you appropriate future career advice.'),nl.


















