-- Named quotations have source references or an explicit unverified note.
-- Unverified does not mean disproved; unattributed sayings make no authorship claim.
-- Excerpts use sentence case and plain punctuation. Translations follow the cited source.
return {
	short = {
		-- John F. Woods, comp.lang.c++, 24 September 1991. Often misattributed to
		-- Martin Golding, but Woods posted it first.
		-- https://groups.google.com/g/comp.lang.c++/c/rYCO5yn4lXw/m/oIT8Cw5-8YQJ
		{ "Always code as if the guy who ends up maintaining your code will be a violent psychopath who knows where you live.", "", "- John F. Woods" },
		-- Wind, Sand and Stars, translated by Lewis Galantiere, chapter III, p. 66 (excerpt).
		-- https://archive.org/details/in.ernet.dli.2015.268685
		{ "Perfection is finally attained not when there is no longer anything to add, but when there is no longer anything to take away.", "", "- Antoine de Saint-Exup\195\169ry" },
		-- Modern productivity slogan with no consistent named author; no source located.
		{ "If you don't finish then you're just busy, not productive.", "", "- Unattributed" },
		-- Perlis, Epigrams in Programming, no. 120. Other epigrams are cited individually below.
		-- https://www.cs.yale.edu/homes/perlis-alan/quotes.html
		{
			"Adapting old programs to fit new machines usually means adapting new machines to behave like old ones.",
			"",
			"- Alan Perlis",
		},
		-- https://web.archive.org/web/20221209205411/https://lkml.org/lkml/2000/8/25/132
		{ "Talk is cheap. Show me the code.", "", "- Linus Torvalds" },
		-- No substantiated Deming authorship: https://quoteinvestigator.com/2017/12/29/god-data/
		{ "In God we trust. All others must bring data.", "", "- Unattributed" },
		-- Benjamin Brewster, 1882, wrote a closely related formulation; this modern
		-- rephrasing has no established author: https://quoteinvestigator.com/2018/04/14/theory/
		{ "In theory, theory and practice are the same. In practice, they're not.", "", "- Unattributed" },
		-- Raymond formulated and named Linus's Law in The Cathedral and the Bazaar.
		-- https://web.archive.org/web/20240115181928/http://www.catb.org/~esr/writings/cathedral-bazaar/cathedral-bazaar/ar01s04.html
		{ "Given enough eyeballs, all bugs are shallow.", "", "- Eric S. Raymond" },
		-- Earlier variants circulated anonymously and were reported from Abba Eban;
		-- the Einstein attribution is unsupported: https://quoteinvestigator.com/2021/07/14/clever-wise/
		{ "A clever person solves a problem. A wise person avoids it.", "", "- Unattributed" },
		-- Adaptation of a "good writer" saying documented in 2004, already authorless.
		-- Cyrus Farivar, sometimes credited, denied coining it.
		-- https://barrypopik.com/blog/being_a_good_worker_is
		{
			"Being a good software engineer is 3% talent, 97% not being distracted by the internet.",
			"",
			"- Unattributed",
		},
		-- https://clarkefoundation.org/arthur-c-clarke-biography/
		{
			"Any sufficiently advanced technology is indistinguishable from magic.",
			"",
			"- Arthur C. Clarke",
		},
		-- Salt From My Attic (1928), p. 20: https://quoteinvestigator.com/2013/12/09/safe-harbor/
		{ "A ship in harbor is safe, but that is not what ships are built for.", "", "- John A. Shedd" },
		-- Newspaper quotation reproduced on Wozniak's site: https://woz.org/?s=trust+a+computer
		{ "Never trust a computer you can't throw out a window.", "", "- Steve Wozniak" },
		-- Reported by the Jargon File, not a transcript of the original utterance.
		-- https://web.archive.org/web/20230605073744/http://www.catb.org/~esr/jargon/html/B/brute-force.html
		{ "When in doubt, use brute force.", "", "- Ken Thompson" },
		-- https://www.intercom.com/blog/where-to-draw-the-line/
		{
			"There is a fundamental difference between making a product simple, and making a simple product.",
			"",
			"- Des Traynor",
		},
		-- https://www.cs.utexas.edu/~EWD/transcriptions/EWD02xx/EWD249/EWD249.html
		{ "Program testing can be used to show the presence of bugs, but never to show their absence!", "", "- Edsger W. Dijkstra" },
		-- Extreme Programming Explained, chapter 7, p. 31: https://archive.org/details/kentBeck2000
		{ "Optimism is an occupational hazard of programming. Feedback is the treatment.", "", "- Kent Beck" },
		-- Reported by Fowler in Refactoring, chapter 2, "Refactoring Helps You Find Bugs".
		-- https://archive.org/details/RefactoringImprovingTheDesignOfExistingCode1stEditionByMartinFowlerKentBeckJohnB
		{ "I'm not a great programmer; I'm just a good programmer with great habits.", "", "- Kent Beck" },
		-- Commonly credited to William Laeder; no originating publication was established.
		{
			"Debugging becomes significantly easier if you first admit that you are the problem.",
			"",
			"- Unattributed",
		},
		-- The Elements of Programming Style, second edition, p. 144.
		-- https://archive.org/details/the-elements-of-programming-style-second-edition
		{ "Don't comment bad code - rewrite it.", "", "- Brian W. Kernighan and P. J. Plauger" },
		-- "The C Language and Models for Systems Programming", BYTE, August 1983.
		-- https://archive.org/details/byte-magazine-1983-08
		{ "But the strategy is definitely: first make it work, then make it right, and, finally, make it fast.", "", "- Stephen C. Johnson and Brian W. Kernighan" },
		-- https://web.archive.org/web/20010607043116/http://www.amazon.com/exec/obidos/ts/feature/7137/
		{ "Easy things should be easy, and hard things should be possible.", "", "- Larry Wall" },
		-- Related French sayings appeared in the nineteenth century; Friedman's
		-- government-program variant does not establish authorship of this wording.
		-- https://barrypopik.com/blog/nothing_is_so_permanent_as_a_temporary_government_program
		{ "Nothing is more permanent than a temporary solution.", "", "- Unattributed" },
		-- Mathisen's Usenet signature: https://www.yarchive.net/comp/caching_multidimensional_arrays.html
		{ "Almost all programming can be viewed as an exercise in caching.", "", "- Terje Mathisen" },
		-- Self-referential joke in the recursive-humour tradition; anonymous folklore.
		{ "To understand recursion, one must first understand recursion.", "", "- Unattributed" },
		-- Programming adaptation of a literary joke documented in 1826 and since assigned
		-- to several people; the programming adapter is unknown.
		-- https://quoteinvestigator.com/2013/09/24/god-knows/
		{ "When I wrote this code, only God and I understood what I did. Now only God knows.", "", "- Unattributed" },
		-- Often credited to Fred Brooks, but this sentence is not in his work. His
		-- authenticated line is "Adding manpower to a late software project makes it later".
		-- https://community.cadence.com/cadence_blogs_8/b/breakfast-bytes/posts/the-mythical-man-month-2
		{ "What one programmer can do in one month, two programmers can do in two months.", "", "- Unattributed" },
		{
			"Fools ignore complexity. Pragmatists suffer it. Some can avoid it. Geniuses remove it.",
			"",
			"- Alan Perlis",
		},
		-- Pun-based one-liner spread via T-shirts and quote lists; no consistent author.
		{
			"The best thing about a boolean is even if you are wrong, you are only off by a bit.",
			"",
			"- Unattributed",
		},
		{ "A LISP programmer knows the value of everything, but the cost of nothing.", "", "- Alan Perlis" },
		-- Calque of the carpenter's proverb "measure twice, cut once"; no first author.
		{ "Think twice, code once.", "", "- Unattributed" },
		-- Neither the "Turkish proverb" label nor a named author was verified.
		-- C. S. Lewis wrote a related passage, not this sentence.
		{ "No matter how far down the wrong road you have gone, turn back now.", "", "- Unattributed" },
		-- John Wooden is credibly recalled using "If you don't have time to do it right,
		-- when will you have time to do it over?" - different wording, and not proof of coinage.
		-- https://www.thewoodeneffect.com/do-it-right-or-do-it-over/
		{ "Why do we never have time to do it right, but always have time to do it over?", "", "- Unattributed" },
		-- Sarcastic inversion joke of unknown origin; not indexed by Quote Investigator.
		{ "Weeks of programming can save you hours of planning.", "", "- Unattributed" },
		-- The Paris Review, no. 32 (1964), p. 62: https://quoteinvestigator.com/2011/11/05/computers-useless/
		{ "But they are useless. They can only give you answers.", "", "- Pablo Picasso, on computers" },
		-- Notes on Programming in C, rule 3: https://www.lysator.liu.se/c/pikestyle.html
		{ "Fancy algorithms are slow when n is small, and n is usually small.", "", "- Rob Pike" },
		-- Go and the Zen of Python, slide 14: https://go.dev/talks/2012/zen.slide
		{ "Methods are just functions (no special location)", "", "- Andrew Gerrand" },
		-- Listicle one-liner with no named author or datable origin; anonymous.
		{ "All loops are infinite ones for faulty RAM modules.", "", "- Unattributed" },
		-- The Pragmatic Programmer, original-edition tips (also "Coding ain't done" below).
		-- https://web.archive.org/web/20160304030624/https://pragprog.com/the-pragmatic-programmer/extracts/tips
		{ "Invest regularly in your knowledge portfolio. Make learning a habit.", "", "- Andrew Hunt and David Thomas" },
		{ "It is easier to change the specification to fit the program than vice versa.", "", "- Alan Perlis" },
		{ "Simplicity does not precede complexity, but follows it.", "", "- Alan Perlis" },
		{ "Optimization hinders evolution.", "", "- Alan Perlis" },
		{ "Recursion is the root of computation since it trades description for time.", "", "- Alan Perlis" },
		-- Lady Windermere's Fan, Act III, Dumby: https://www.gutenberg.org/ebooks/790.txt.utf-8
		{ "Experience is the name every one gives to their mistakes.", "", "- Oscar Wilde" },
		-- Hertzfeld's notes of Kay's 1982 talk, also "predict the future" below.
		-- https://www.folklore.org/Creative_Think.html
		{ "People who are really serious about software should make their own hardware.", "", "- Alan Kay" },
		{ "Coding ain't done 'til all the tests run.", "", "- Andrew Hunt and David Thomas" },
		-- Zola, Au bonheur des dames, ch. 11; translation in Van Gogh's letter 464, note 12.
		-- https://vangoghletters.org/vg/letters/let464/letter.html#n-12
		{ "I prefer to die of passion than to die of boredom!", "", "- \195\137mile Zola, quoted by Vincent van Gogh" },
		-- Credited to John Johnson in quotation lists, with no identifiable original source.
		{ "First, solve the problem. Then, write the code.", "", "- Unattributed" },
		-- Excerpt: https://www.cs.utexas.edu/~EWD/transcriptions/EWD08xx/EWD898.html
		{
			"Alan M. Turing thought about criteria to settle the question of whether Machines Can Think, a question of which we now know that it is about as relevant as the question of whether Submarines Can Swim.",
			"",
			"- Edsger W. Dijkstra",
		},
		-- The Empire Strikes Back screenplay; spoken name retained as transcribed.
		-- https://imsdb.com/scripts/Star-Wars-The-Empire-Strikes-Back.html
		{
			"The city's central computer told you? Artoo-Detoo, you know better than to trust a strange computer.",
			"",
			"- C-3PO, The Empire Strikes Back",
		},
		-- Recalled by Wheeler's doctoral student: https://www.stroustrup.com/quotes.html
		{ "Any problem in computer science can be solved with another layer of indirection, except of course for the problem of too many indirections.", "", "- David J. Wheeler" },
		{ "The best way to predict the future is to invent it.", "", "- Alan Kay" },
		-- Hertzfeld's historical account: https://www.folklore.org/Real_Artists_Ship.html
		{ "Real artists ship.", "", "- Steve Jobs" },
		-- Established hacker folklore. The Jargon File documents both the bug/feature joke
		-- and the "undocumented feature" euphemism, but names no originator.
		-- https://www.dourish.com/goodies/jargon.html
		{ "It's not a bug. It's an undocumented feature!", "", "- Unattributed" },
		-- https://blog.cleancoder.com/uncle-bob/2013/03/11/TheFrenziedPanicOfRushing.html
		{ "The only way to go fast is to go well.", "", "- Robert C. Martin" },
		-- A Murphy's/Finagle's-law-family adage collected by Arthur Bloch, who compiled
		-- rather than authored it; effectively anonymous folklore.
		{ "A misplaced decimal point will always end up where it will do the greatest damage.", "", "- Unattributed" },
		-- Epigram 40: https://www.cs.yale.edu/homes/perlis-alan/quotes.html
		{ "There are two ways to write error-free programs; only the third one works.", "", "- Alan Perlis" },
		-- Epigram 54: https://www.cs.yale.edu/homes/perlis-alan/quotes.html
		{ "Beware of the Turing tar-pit in which everything is possible but nothing of interest is easy.", "", "- Alan Perlis" },
		-- https://www.stroustrup.com/quotes.html
		{ "'Legacy code' often differs from its suggested alternative by actually working and scaling.", "", "- Bjarne Stroustrup" },
		-- https://www.stroustrup.com/quotes.html
		{ "Familiarity is often mistaken for simplicity.", "", "- Bjarne Stroustrup" },
		-- https://www.stroustrup.com/quotes.html
		{ "Beware of 'obvious'; it often means \"I haven't thought carefully about it\".", "", "- Bjarne Stroustrup" },
		-- Hertzfeld's notes of Kay's 1982 talk: https://www.folklore.org/Creative_Think.html
		{ "Point of view is worth 80 IQ points.", "", "- Alan Kay" },
		-- Notes on Programming in C, "Variable names": https://www.lysator.liu.se/c/pikestyle.html
		{ "Length is not a virtue in a name; clarity of expression is.", "", "- Rob Pike" },
		-- Notes on Programming in C, rule 1: https://www.lysator.liu.se/c/pikestyle.html
		{ "You can't tell where a program is going to spend its time. Measure before you optimize.", "", "- Rob Pike" },
		-- The Mythical Man-Month, chapter 2 (Brooks's law): https://en.wikiquote.org/wiki/Fred_Brooks
		{ "Adding manpower to a late software project makes it later.", "", "- Fred Brooks" },
		-- The Mythical Man-Month, chapter 11: https://en.wikiquote.org/wiki/Fred_Brooks
		{ "Plan to throw one away; you will, anyhow.", "", "- Fred Brooks" },
		-- 1977 note to van Emde Boas: https://www-cs-faculty.stanford.edu/~knuth/faq.html
		{ "Beware of bugs in the above code; I have only proved it correct, not tried it.", "", "- Donald Knuth" },
		-- G\195\182del, Escher, Bach, chapter V (Hofstadter's law).
		{
			"It always takes longer than you expect, even when you take into account Hofstadter's Law.",
			"",
			"- Douglas Hofstadter",
		},
		-- RFC 761, section 2.10 (the robustness principle): https://www.rfc-editor.org/rfc/rfc761
		{ "Be conservative in what you do, be liberal in what you accept from others.", "", "- Jon Postel" },
		-- "A Plea for Lean Software", IEEE Computer, February 1995 (Wirth's law).
		-- https://doi.org/10.1109/2.348001
		{ "Software is getting slower more rapidly than hardware is getting faster.", "", "- Niklaus Wirth" },
		-- Zawinski's law, as recorded by the Jargon File.
		-- http://www.catb.org/~esr/jargon/html/Z/Zawinskis-Law.html
		{ "Every program attempts to expand until it can read mail.", "", "- Jamie Zawinski" },
		-- https://www.cs.utexas.edu/~EWD/transcriptions/EWD04xx/EWD498.html
		{
			"The use of COBOL cripples the mind; its teaching should, therefore, be regarded as a criminal offence.",
			"",
			"- Edsger W. Dijkstra",
		},
		-- https://www.cs.utexas.edu/~EWD/transcriptions/EWD03xx/EWD340.html
		{ "The competent programmer is fully aware of the strictly limited size of his own skull.", "", "- Edsger W. Dijkstra" },
		-- https://www.cs.utexas.edu/~EWD/transcriptions/EWD10xx/EWD1036.html
		{
			"If we wish to count lines of code, we should not regard them as lines produced but as lines spent.",
			"",
			"- Edsger W. Dijkstra",
		},
		-- Epigram 7: https://www.cs.yale.edu/homes/perlis-alan/quotes.html
		{ "It is easier to write an incorrect program than understand a correct one.", "", "- Alan Perlis" },
		-- Epigram 19: https://www.cs.yale.edu/homes/perlis-alan/quotes.html
		{ "A language that doesn't affect the way you think about programming is not worth knowing.", "", "- Alan Perlis" },
		-- Epigram 6: https://www.cs.yale.edu/homes/perlis-alan/quotes.html
		{ "Symmetry is a complexity-reducing concept; seek it everywhere.", "", "- Alan Perlis" },
		-- Epigram 102: https://www.cs.yale.edu/homes/perlis-alan/quotes.html
		{ "One can't proceed from the informal to the formal by formal means.", "", "- Alan Perlis" },
		-- The Elements of Programming Style, second edition, p. 124.
		-- https://archive.org/details/the-elements-of-programming-style-second-edition
		{ "Make it right before you make it faster.", "", "- Brian W. Kernighan and P. J. Plauger" },
		-- The Elements of Programming Style, second edition, p. 10.
		{ "Write clearly - don't be too clever.", "", "- Brian W. Kernighan and P. J. Plauger" },
		-- Go proverbs, distilled by Pike: https://go-proverbs.github.io/
		{ "Clear is better than clever.", "", "- Rob Pike" },
		-- Go proverbs: https://go-proverbs.github.io/
		{ "A little copying is better than a little dependency.", "", "- Rob Pike" },
		-- https://www.cs.utexas.edu/~EWD/transcriptions/EWD04xx/EWD498.html
		{ "Simplicity is prerequisite for reliability.", "", "- Edsger W. Dijkstra" },
		-- https://www.cs.utexas.edu/~EWD/transcriptions/EWD04xx/EWD498.html
		{ "PL/I, the fatal disease, belongs more to the problem set than to the solution set.", "", "- Edsger W. Dijkstra" },
		-- https://www.cs.utexas.edu/~EWD/transcriptions/EWD04xx/EWD498.html
		{
			"APL is a mistake, carried through to perfection. It is the language of the future for the programming techniques of the past.",
			"",
			"- Edsger W. Dijkstra",
		},
		-- Epigram 8: https://www.cs.yale.edu/homes/perlis-alan/quotes.html
		{ "A programming language is low level when its programs require attention to the irrelevant.", "", "- Alan Perlis" },
		-- https://www.stroustrup.com/quotes.html
		{ "Proof by analogy is fraud.", "", "- Bjarne Stroustrup" },
		-- Recalled by Fowler: https://martinfowler.com/bliki/TwoHardThings.html
		{
			"There are only two hard things in computer science: cache invalidation and naming things.",
			"",
			"- Phil Karlton",
		},
		-- OOPSLA 1997 keynote, "The Computer Revolution Hasn't Happened Yet".
		{ "I invented the term object-oriented, and I can tell you I did not have C++ in mind.", "", "- Alan Kay" },
		-- https://www.nps.gov/people/grace-hopper.htm
		{
			"The most damaging phrase in the language is: we've always done it this way.",
			"",
			"- Grace Hopper",
		},
		-- Widely credited to Berard but traced only to quotation aggregators; no
		-- originating publication or talk located.
		{ "Walking on water and developing software from a specification are easy if both are frozen.", "", "- Attributed to Edward V. Berard" },
		-- Sinz's comp.sys.amiga.programmer signature, 1991. The terser original reads
		-- "support it for life"; this expanded form circulates widely.
		-- https://barrypopik.com/blog/programming_is_like_sex
		{ "Programming is like sex. One mistake and you have to support it for the rest of your life.", "", "- Michael Sinz" },
		-- Apocryphal: absent from Wright's documented sayings and likely a confusion
		-- with his authenticated "the architect can only advise his clients to plant
		-- vines" line. No source located.
		{ "You can use an eraser on the drafting table or a sledgehammer on the construction site.", "", "- Attributed to Frank Lloyd Wright" },
		-- Long-standing folklore attribution to Barton (Burroughs B5000 architect),
		-- repeated by Alan Kay; original utterance undocumented.
		{ "System programmers are the high priests of a low cult.", "", "- Attributed to Robert S. Barton" },
		-- "Doug Linder" is untraceable to any identifiable person or original text.
		{ "A good programmer is someone who always looks both ways before crossing a one-way street.", "", "- Unattributed" },
		-- "Vidiu Platon" has no verifiable identity or original publication.
		{ "I don't care if it works on your machine! We are not shipping your machine.", "", "- Unattributed" },
		-- Consistent with the themes of Maguire's Writing Solid Code (1993), but the
		-- one-liner is not confirmed as his verbatim wording.
		{ "Fix the cause, not the symptom.", "", "- Attributed to Steve Maguire" },
		-- Circulated as Cunningham; no talk, post, or interview located.
		{ "It's all talk until the code runs.", "", "- Attributed to Ward Cunningham" },
		-- Thematically Ullman-esque but not confirmed against her published text.
		{ "There is always one more bug to fix.", "", "- Attributed to Ellen Ullman" },
		-- Consistent with Atwood's stance, but the exact sentence is not sourced.
		{ "We have to stop optimizing for programmers and start optimizing for users.", "", "- Attributed to Jeff Atwood" },
		-- Stable attribution to Norm Schryer (Bell Labs) in quotation lists, but no
		-- traceable original text.
		{ "If the code and the comments do not match, possibly both are incorrect.", "", "- Attributed to Norm Schryer" },
		-- Long-standing attribution to Johnson (of the "Gang of Four"), from software
		-- reuse discussions, but the original venue is not documented.
		{ "Before software can be reusable it first has to be usable.", "", "- Attributed to Ralph Johnson" },
		-- Loose paraphrase, not Knuth's phrasing. His documented dictum is "premature
		-- optimization is the root of all evil" (cited in the long section).
		{ "If you optimize everything, you will always be unhappy.", "", "- Unattributed" },
		-- Commonly credited to Gates (often to Business @ the Speed of Thought, 1999),
		-- but not verified to a specific passage.
		{ "Your most unhappy customers are your greatest source of learning.", "", "- Attributed to Bill Gates" },
		-- Not in Pascal's Pensees; the wording is associated with Elbert Hubbard.
		{ "Small minds are concerned with the extraordinary, great minds with the ordinary.", "", "- Misattributed to Blaise Pascal" },
		-- Frequently credited to Kay but not found in his documented talks or interviews.
		{ "The most disastrous thing that you can ever learn is your first programming language.", "", "- Attributed to Alan Kay" },
		-- Consistent with Knuth's views on beauty in programming, but the verbatim
		-- quote lacks a traceable original.
		{ "Everyday life is like programming, I guess. If you love something, you can put beauty into it.", "", "- Attributed to Donald Knuth" },
		-- Peter Seibel, Coders at Work (2009), Ken Thompson interview.
		-- https://www.codersatwork.com/
		{ "One of my most productive days was throwing away 1000 lines of code.", "", "- Ken Thompson" },
		-- Credited to tech columnist Peter Coffee only via quotation sites; no
		-- original column or talk located.
		{ "Computers are fast; developers keep them slow.", "", "- Attributed to Peter Coffee" },
		-- "All Questions Answered", Notices of the AMS 49(3), March 2002, p. 320 (excerpt).
		-- The bare "Software is hard." is a truncation of this sentence.
		-- https://www.ams.org/notices/200203/fea-knuth.pdf
		{
			"My main conclusion after spending ten years of my life working on the TeX project is that software is hard.",
			"",
			"- Donald Knuth",
		},
		-- Consistently credited to aerospace engineer Burt Rutan, but no primary
		-- recording or publication located.
		{ "Testing leads to failure, and failure leads to understanding.", "", "- Attributed to Burt Rutan" },
		-- Credited to Thomas Fuchs (script.aculo.us author); original tweet or talk
		-- not located.
		{ "The best error message is the one that never shows up.", "", "- Attributed to Thomas Fuchs" },
		-- Associated with Jason C. McDonald; originating article or post not located.
		{ "Don't write better error messages, write code that doesn't need them.", "", "- Attributed to Jason C. McDonald" },
		-- Credited to Ron Jeffries (XP/Agile), but no original publication located.
		{ "Code never lies, comments sometimes do.", "", "- Attributed to Ron Jeffries" },
		-- Anonymous programmer joke; the "Woulfe" credit appears aggregator-invented.
		{ "If, at first, you do not succeed, call it version 1.0.", "", "- Unattributed" },
		-- Robert C. Martin, Clean Code (2008), chapter 1.
		{ "Truth can only be found in one place: the code.", "", "- Robert C. Martin" },
		-- Credited to Cory House; the originating tweet could not be primary-verified.
		{ "Code is like humor. When you have to explain it, it's bad.", "", "- Attributed to Cory House" },
		-- Old programming proverb; the "Roy Carlson" credit is unverifiable folklore.
		{ "The sooner you start to code, the longer the program will take.", "", "- Unattributed" },
		-- Deutsch's epigram, quoted by Stroustrup in The C++ Programming Language.
		-- The canonical wording keeps "is" before "divine".
		{ "To iterate is human, to recurse is divine.", "", "- L. Peter Deutsch" },
		-- Attributed to Wall but absent from the extensive documented archive of his
		-- Usenet and talk sayings; provenance doubtful.
		{ "Almost every programming language is overrated by its practitioners.", "", "- Attributed to Larry Wall" },
		-- Widely floating aphorism; the Wilczek attribution is popular but unverified.
		{ "If you don't make mistakes, you're not working on hard enough problems.", "", "- Attributed to Frank Wilczek" },
		-- In keeping with Lamport's views on specification, but the exact sentence is
		-- not traceable to a primary text.
		{ "If you don't start with a spec, every piece of code you write is a patch.", "", "- Attributed to Leslie Lamport" },
		-- Frequently credited to Pike; no originating talk or post located.
		{ "Caches are bugs waiting to happen.", "", "- Attributed to Rob Pike" },
		-- Echoes Alan Cooper's About Face on interaction idioms, but the exact wording
		-- is not primary-verified.
		{ "All idioms must be learned. Good idioms only need to be learned once.", "", "- Attributed to Alan Cooper" },
		-- Kay's, per https://en.wikiquote.org/wiki/Alan_Kay (rendered "90 percent").
		{ "If you don't fail at least 90% of the time, you're not aiming high enough.", "", "- Alan Kay" },
		-- Brian W. Kernighan and P. J. Plauger, Software Tools (1976).
		-- https://archive.org/details/softwaretools0000kern
		{ "Controlling complexity is the essence of computer programming.", "", "- Brian Kernighan" },
		-- Listed as attributed (not sourced) to Booch on Wikiquote; no original Booch
		-- text located. https://en.wikiquote.org/wiki/Grady_Booch
		{ "The function of good software is to make the complex appear to be simple.", "", "- Attributed to Grady Booch" },
		-- The "drugs and software" joke is widely credited to Tufte but has no
		-- verified original.
		{ 'There are only two industries that refer to their customers as "users".', "", "- Attributed to Edward Tufte" },
		-- In Hickey's idiom and attributed to his talks, but not pinned to a specific
		-- verified transcript line.
		{ "Patterns mean I have run out of language.", "", "- Attributed to Rich Hickey" },
		-- Attributed to Ullman on aggregators but not traced to a primary work.
		-- Programming Perl glossary, shipped verbatim as perlglossary. The circulating
		-- "Laziness is a programmer's main virtue" corrupts this: it is the first of
		-- three virtues, not the main one. https://perldoc.perl.org/perlglossary
		{ "Laziness is the first great virtue of a programmer.", "", "- Larry Wall" },
		{ "Programming is the art of algorithm design and the craft of debugging errant code.", "", "- Attributed to Ellen Ullman" },
	},
	long = {
		-- https://www.wall.org/~larry/onion/onion.html
		{ "Most of you are familiar with the virtues of a programmer. There are three, of course: laziness, impatience, and hubris.", "", "- Larry Wall" },
		-- https://firstmonday.org/ojs/index.php/fm/article/download/583/504
		{ "Most of the good programmers do programming not because they expect to get paid or get adulation by the public, but because it is fun to program.", "", "- Linus Torvalds" },
		-- The Mythical Man-Month, p. 17: https://en.wikiquote.org/wiki/Fred_Brooks
		{ "The bearing of a child takes nine months, no matter how many women are assigned.", "", "- Fred Brooks" },
		-- https://regex.info/blog/2006-09-15/247
		{ 'Some people, when confronted with a problem, think "I know, I\'ll use regular expressions." Now they have two problems.', "", "- Jamie Zawinski" },
		-- Quoted by Jon Bentley, "Bumper-Sticker Computer Science" (1985): https://doi.org/10.1145/4284.315122
		{ "The first 90% of the code accounts for the first 90% of the development time. The remaining 10% of the code accounts for the other 90% of the development time.", "", "- Tom Cargill" },
		-- https://www.stroustrup.com/quotes.html
		{ "There are only two kinds of languages: the ones people complain about and the ones nobody uses.", "", "- Bjarne Stroustrup" },
		-- https://www.paulgraham.com/hp.html
		{ "A programming language is for thinking of programs, not for expressing programs you've already thought of. It should be a pencil, not a pen.", "", "- Paul Graham" },
		-- https://lore.kernel.org/all/Pine.LNX.4.64.0607270936200.4168@g5.osdl.org/
		{ "Bad programmers worry about the code. Good programmers worry about data structures and their relationships.", "", "- Linus Torvalds" },
		-- The Elements of Programming Style, p. 10: https://archive.org/details/the-elements-of-programming-style-second-edition
		{ "Everyone knows that debugging is twice as hard as writing a program in the first place. So if you're as clever as you can be when you write it, how will you ever debug it?", "", "- Brian W. Kernighan and P. J. Plauger" },
		-- "Program Development by Stepwise Refinement" (1971): https://en.wikiquote.org/wiki/Niklaus_Wirth
		{ "Active programming consists of the design of new programs, rather than contemplation of old programs.", "", "- Niklaus Wirth" },
		-- https://www.stroustrup.com/quotes.html
		{ "C makes it easy to shoot yourself in the foot; C++ makes it harder, but when you do it blows your whole leg off.", "", "- Bjarne Stroustrup" },
		-- https://sarabander.github.io/sicp/html/Preface-1e.xhtml
		{ "Programs must be written for people to read, and only incidentally for machines to execute.", "", "- Harold Abelson and Gerald Jay Sussman, with Julie Sussman" },
		-- Epigram 9: https://www.cs.yale.edu/homes/perlis-alan/quotes.html
		{ "It is better to have 100 functions operate on one data structure than 10 functions on 10 data structures.", "", "- Alan Perlis" },
		-- https://www.cs.virginia.edu/~evans/cs655/readings/smalltalk.html
		{ "If a system is to serve the creative spirit, it must be entirely comprehensible to a single individual.", "", "- Daniel H. H. Ingalls" },
		-- Doug Gwyn is a circulating attribution, but no original message was established;
		-- an older collection acknowledges that uncertainty: https://www.linfo.org/q_unix.html
		{ "Unix was not designed to stop its users from doing stupid things, as that would also stop them from doing clever things.", "", "- Unattributed" },
		-- A shorter variant is credited to Anonymous in Raymond's The Art of Unix Programming (2003).
		-- Andreas Bogk's alleged authorship was not substantiated.
		-- https://www.linuxtopia.org/online_books/programming_books/art_of_unix_programming/toolschapter.html
		{ "Contrary to popular belief, Unix is user friendly. It just happens to be very selective about who it decides to make friends with.", "", "- Unattributed" },
		-- https://www.nasa.gov/history/rogersrep/v2appf.htm
		{ "For a successful technology, reality must take precedence over public relations, for nature cannot be fooled.", "", "- Richard Feynman" },
		-- 66 tips from the original edition: https://web.archive.org/web/20160304030624/https://pragprog.com/the-pragmatic-programmer/extracts/tips
		{ "Care about your craft. Why spend your life developing software unless you care about doing it well?", "", "- Andrew Hunt and David Thomas" },
		{ "Provide options, don't make lame excuses. Instead of excuses, provide options. Don't say it can't be done; explain what can be done.", "", "- Andrew Hunt and David Thomas" },
		{ "Be a catalyst for change. You can't force change on people. Instead, show them how the future might be and help them participate in creating it.", "", "- Andrew Hunt and David Thomas" },
		{ "Make quality a requirements issue. Involve your users in determining the project's real quality requirements.", "", "- Andrew Hunt and David Thomas" },
		{ "Critically analyze what you read and hear. Don't be swayed by vendors, media hype, or dogma. Analyze information in terms of you and your project.", "", "- Andrew Hunt and David Thomas" },
		{ "DRY - Don't Repeat Yourself. Every piece of knowledge must have a single, unambiguous, authoritative representation within a system.", "", "- Andrew Hunt and David Thomas" },
		{ "Eliminate effects between unrelated things. Design components that are self-contained, independent, and have a single, well-defined purpose.", "", "- Andrew Hunt and David Thomas" },
		{ "Use tracer bullets to find the target. Tracer bullets let you home in on your target by trying things and seeing how close they land.", "", "- Andrew Hunt and David Thomas" },
		{ "Program close to the problem domain. Design and code in your user's language.", "", "- Andrew Hunt and David Thomas" },
		{ "Iterate the schedule with the code. Use experience you gain as you implement to refine the project time scales.", "", "- Andrew Hunt and David Thomas" },
		{ "Use the power of command shells. Use the shell when graphical user interfaces don't cut it.", "", "- Andrew Hunt and David Thomas" },
		{ "Always use source code control. Source code control is a time machine for your work - you can go back.", "", "- Andrew Hunt and David Thomas" },
		{ "Don't panic when debugging. Take a deep breath and THINK! about what could be causing the bug.", "", "- Andrew Hunt and David Thomas" },
		{ "Don't assume it - prove it. Prove your assumptions in the actual environment - with real data and boundary conditions.", "", "- Andrew Hunt and David Thomas" },
		{ "Write code that writes code. Code generators increase your productivity and help avoid duplication.", "", "- Andrew Hunt and David Thomas" },
		{ "Design with contracts. Use contracts to document and verify that code does no more and no less than it claims to do.", "", "- Andrew Hunt and David Thomas" },
		{ "Use assertions to prevent the impossible. Assertions validate your assumptions. Use them to protect your code from an uncertain world.", "", "- Andrew Hunt and David Thomas" },
		{ "Finish what you start. Where possible, the routine or object that allocates a resource should be responsible for deallocating it.", "", "- Andrew Hunt and David Thomas" },
		{ "Configure, don't integrate. Implement technology choices for an application as configuration options, not through integration or engineering.", "", "- Andrew Hunt and David Thomas" },
		{ "Analyze workflow to improve concurrency. Exploit concurrency in your user's workflow.", "", "- Andrew Hunt and David Thomas" },
		{ "Always design for concurrency. Allow for concurrency, and you'll design cleaner interfaces with fewer assumptions.", "", "- Andrew Hunt and David Thomas" },
		{ "Use blackboards to coordinate workflow. Use blackboards to coordinate disparate facts and agents, while maintaining independence and isolation among participants.", "", "- Andrew Hunt and David Thomas" },
		{ "Estimate the order of your algorithms. Get a feel for how long things are likely to take before you write code.", "", "- Andrew Hunt and David Thomas" },
		{ "Refactor early, refactor often. Just as you might weed and rearrange a garden, rewrite, rework, and re-architect code when it needs it. Fix the root of the problem.", "", "- Andrew Hunt and David Thomas" },
		{ "Test your software, or your users will. Test ruthlessly. Don't make your users find bugs for you.", "", "- Andrew Hunt and David Thomas" },
		{ "Don't gather requirements - dig for them. Requirements rarely lie on the surface. They're buried deep beneath layers of assumptions, misconceptions, and politics.", "", "- Andrew Hunt and David Thomas" },
		{ "Abstractions live longer than details. Invest in the abstraction, not the implementation. Abstractions can survive the barrage of changes from different implementations and new technologies.", "", "- Andrew Hunt and David Thomas" },
		{ "Some things are better done than described. Don't fall into the specification spiral - at some point you need to start coding.", "", "- Andrew Hunt and David Thomas" },
		{ "Costly tools don't produce better designs. Beware of vendor hype, industry dogma, and the aura of the price tag. Judge tools on their merits.", "", "- Andrew Hunt and David Thomas" },
		{ "Don't use manual procedures. A shell script or batch file will execute the same instructions, in the same order, time after time.", "", "- Andrew Hunt and David Thomas" },
		{ "Test state coverage, not code coverage. Identify and test significant program states. Just testing lines of code isn't enough.", "", "- Andrew Hunt and David Thomas" },
		{ "English is just a programming language. Write documents as you would write code: honor the DRY principle, use metadata, MVC, automatic generation, and so on.", "", "- Andrew Hunt and David Thomas" },
		{ "Gently exceed your users' expectations. Come to understand your users' expectations, then deliver just that little bit more.", "", "- Andrew Hunt and David Thomas" },
		{ "Think! about your work. Turn off the autopilot and take control. Constantly critique and appraise your work.", "", "- Andrew Hunt and David Thomas" },
		{ "Don't live with broken windows. Fix bad designs, wrong decisions, and poor code when you see them.", "", "- Andrew Hunt and David Thomas" },
		{ "Remember the big picture. Don't get so engrossed in the details that you forget to check what's happening around you.", "", "- Andrew Hunt and David Thomas" },
		{ "It's both what you say and the way you say it. There's no point in having great ideas if you don't communicate them effectively.", "", "- Andrew Hunt and David Thomas" },
		{ "Make it easy to reuse. If it's easy to reuse, people will. Create an environment that supports reuse.", "", "- Andrew Hunt and David Thomas" },
		{ "There are no final decisions. No decision is cast in stone. Instead, consider each as being written in the sand at the beach, and plan for change.", "", "- Andrew Hunt and David Thomas" },
		{ "Prototype to learn. Prototyping is a learning experience. Its value lies not in the code you produce, but in the lessons you learn.", "", "- Andrew Hunt and David Thomas" },
		{ "Estimate to avoid surprises. Estimate before you start. You'll spot potential problems up front.", "", "- Andrew Hunt and David Thomas" },
		{ "Keep knowledge in plain text. Plain text won't become obsolete. It helps leverage your work and simplifies debugging and testing.", "", "- Andrew Hunt and David Thomas" },
		{ "Use a single editor well. The editor should be an extension of your hand; make sure your editor is configurable, extensible, and programmable.", "", "- Andrew Hunt and David Thomas" },
		{ "Fix the problem, not the blame. It doesn't really matter whether the bug is your fault or someone else's - it is still your problem, and it still needs to be fixed.", "", "- Andrew Hunt and David Thomas" },
		{ '"select" isn\'t broken. It is rare to find a bug in the OS or the compiler, or even a third-party product or library. The bug is most likely in the application.', "", "- Andrew Hunt and David Thomas" },
		{ "Learn a text manipulation language. You spend a large part of each day working with text. Why not have the computer do some of it for you?", "", "- Andrew Hunt and David Thomas" },
		{ "You can't write perfect software. Software can't be perfect. Protect your code and users from the inevitable errors.", "", "- Andrew Hunt and David Thomas" },
		{ "Crash early. A dead program normally does a lot less damage than a crippled one.", "", "- Andrew Hunt and David Thomas" },
		{ "Use exceptions for exceptional problems. Exceptions can suffer from all the readability and maintainability problems of classic spaghetti code. Reserve exceptions for exceptional things.", "", "- Andrew Hunt and David Thomas" },
		{ 'Minimize coupling between modules. Avoid coupling by writing "shy" code and applying the Law of Demeter.', "", "- Andrew Hunt and David Thomas" },
		{ "Put abstractions in code, details in metadata. Program for the general case, and put the specifics outside the compiled code base.", "", "- Andrew Hunt and David Thomas" },
		{ "Design using services. Design in terms of services - independent, concurrent objects behind well-defined, consistent interfaces.", "", "- Andrew Hunt and David Thomas" },
		{ "Separate views from models. Gain flexibility at low cost by designing your application in terms of models and views.", "", "- Andrew Hunt and David Thomas" },
		{ "Don't program by coincidence. Rely only on reliable things. Beware of accidental complexity, and don't confuse a happy coincidence with a purposeful plan.", "", "- Andrew Hunt and David Thomas" },
		{ "Test your estimates. Mathematical analysis of algorithms doesn't tell you everything. Try timing your code in its target environment.", "", "- Andrew Hunt and David Thomas" },
		{ "Design to test. Start thinking about testing before you write a line of code.", "", "- Andrew Hunt and David Thomas" },
		{ "Don't use wizard code you don't understand. Wizards can generate reams of code. Make sure you understand all of it before you incorporate it into your project.", "", "- Andrew Hunt and David Thomas" },
		{ "Work with a user to think like a user. It's the best way to gain insight into how the system will really be used.", "", "- Andrew Hunt and David Thomas" },
		{ "Use a project glossary. Create and maintain a single source of all the specific terms and vocabulary for a project.", "", "- Andrew Hunt and David Thomas" },
		{ "Start when you're ready. You've been building experience all your life. Don't ignore niggling doubts.", "", "- Andrew Hunt and David Thomas" },
		{ "Don't be a slave to formal methods. Don't blindly adopt any technique without putting it into the context of your development practices and capabilities.", "", "- Andrew Hunt and David Thomas" },
		{ "Organize teams around functionality. Don't separate designers from coders, testers from data modelers. Build teams the way you build code.", "", "- Andrew Hunt and David Thomas" },
		{ "Test early. Test often. Test automatically. Tests that run with every build are much more effective than test plans that sit on a shelf.", "", "- Andrew Hunt and David Thomas" },
		{ "Use saboteurs to test your testing. Introduce bugs on purpose in a separate copy of the source to verify that testing will catch them.", "", "- Andrew Hunt and David Thomas" },
		{ "Find bugs once. Once a human tester finds a bug, it should be the last time a human tester finds that bug. Automatic tests should check for it from then on.", "", "- Andrew Hunt and David Thomas" },
		{ "Sign your work. Craftsmen of an earlier age were proud to sign their work. You should be, too.", "", "- Andrew Hunt and David Thomas" },
		-- https://www.cs.utexas.edu/~EWD/transcriptions/EWD03xx/EWD340.html
		{ "The purpose of abstracting is not to be vague, but to create a new semantic level in which one can be absolutely precise.", "", "- Edsger W. Dijkstra" },
		-- Epigram 2: https://www.cs.yale.edu/homes/perlis-alan/quotes.html
		{ "Functions delay binding; data structures induce binding. Moral: Structure data late in the programming process.", "", "- Alan Perlis" },
		-- Not authenticated as Einstein. De Broglie recalled him discussing explanations that
		-- "even a child could understand", but not the six-year-old test.
		-- https://archive.org/details/newperspectivesi00brog/page/184/mode/2up
		{ "If you can't explain something to a six-year-old, you really don't understand it yourself.", "", "- Unattributed" },
		-- The Mythical Man-Month, p. 153: https://en.wikiquote.org/wiki/Fred_Brooks
		{ "How does a project get to be a year late? ... One day at a time.", "", "- Fred Brooks" },
		-- Stroustrup confirms saying this around 1990 but does not claim originality.
		-- https://www.stroustrup.com/quotes.html
		{ "I have always wished for my computer to be as easy to use as my telephone; my wish has come true because I can no longer figure out how to use my telephone.", "", "- Bjarne Stroustrup" },
		-- Epigram 93: https://www.cs.yale.edu/homes/perlis-alan/quotes.html
		{ 'When someone says "I want a programming language in which I need only say what I wish done," give him a lollipop.', "", "- Alan Perlis" },
		-- Epigram 30: https://www.cs.yale.edu/homes/perlis-alan/quotes.html
		{ "In programming, everything we do is a special case of something more general - and often we know it too quickly.", "", "- Alan Perlis" },
		-- "Structured Programming with go to Statements", ACM Computing Surveys 6(4), p. 268.
		-- https://doi.org/10.1145/356635.356640
		{
			"We should forget about small efficiencies, say about 97% of the time: premature optimization is the root of all evil.",
			"",
			"- Donald Knuth",
		},
		-- Turing Award lecture, "The Emperor's Old Clothes", CACM 24(2), 1981.
		-- https://doi.org/10.1145/358549.358561
		{
			"There are two ways of constructing a software design: one way is to make it so simple that there are obviously no deficiencies, and the other way is to make it so complicated that there are no obvious deficiencies.",
			"",
			"- C. A. R. Hoare",
		},
		-- "How Do Committees Invent?", Datamation, April 1968 (Conway's law).
		-- https://www.melconway.com/Home/Conways_Law.html
		{
			"Organizations which design systems are constrained to produce designs which are copies of the communication structures of these organizations.",
			"",
			"- Melvin Conway",
		},
		-- Systemantics (1975), chapter 11 (Gall's law).
		{
			"A complex system that works is invariably found to have evolved from a simple system that worked.",
			"",
			"- John Gall",
		},
		-- https://www.cs.utexas.edu/~EWD/transcriptions/EWD04xx/EWD498.html
		{
			"The tools we use have a profound and devious influence on our thinking habits, and therefore on our thinking abilities.",
			"",
			"- Edsger W. Dijkstra",
		},
		-- Notes on Programming in C, rule 5: https://www.lysator.liu.se/c/pikestyle.html
		{
			"Data dominates. If you've chosen the right data structures and organized things well, the algorithms will almost always be self-evident.",
			"",
			"- Rob Pike",
		},
		-- QCon London 2009, "Null References: The Billion Dollar Mistake".
		-- https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare/
		{
			"I call it my billion-dollar mistake: the invention of the null reference in 1965. I couldn't resist the temptation to put in a null reference, simply because it was so easy to implement.",
			"",
			"- C. A. R. Hoare",
		},
		-- https://www.cs.utexas.edu/~EWD/transcriptions/EWD04xx/EWD498.html
		{
			"It is practically impossible to teach good programming to students that have had a prior exposure to BASIC: as potential programmers they are mentally mutilated beyond hope of regeneration.",
			"",
			"- Edsger W. Dijkstra",
		},
		-- https://www.cs.utexas.edu/~EWD/transcriptions/EWD04xx/EWD498.html
		{
			"FORTRAN, the infantile disorder, by now nearly 20 years old, is hopelessly inadequate for whatever computer application you have in mind today.",
			"",
			"- Edsger W. Dijkstra",
		},
		-- https://www.cs.utexas.edu/~EWD/transcriptions/EWD08xx/EWD896.html
		{
			"Simplicity is a great virtue but it requires hard work to achieve it and education to appreciate it. And to make matters worse: complexity sells better.",
			"",
			"- Edsger W. Dijkstra",
		},
		-- 2007 message to the git mailing list.
		-- https://lore.kernel.org/git/Pine.LNX.4.64.0709060800270.13653@woody.linux-foundation.org/
		{
			"C++ is a horrible language. It's made more horrible by the fact that a lot of substandard programmers use it.",
			"",
			"- Linus Torvalds",
		},
		-- https://www-cs-faculty.stanford.edu/~knuth/email.html
		{
			"Email is a wonderful thing for people whose role in life is to be on top of things. But not for me; my role is to be on the bottom of things.",
			"",
			"- Donald Knuth",
		},
		-- Credited to ESR across quotation lists but not found in his own writings
		-- (e.g. "How To Become A Hacker"); provenance weak.
		{ "Computer science education cannot make anybody an expert programmer any more than studying brushes and pigment can make somebody an expert painter.", "", "- Attributed to Eric S. Raymond" },
		-- Attributed to Jim McCarthy's Dynamics of Software Development (Microsoft
		-- Press, 1995); exact wording not confirmed against the source text.
		{ "You can't have great software without a great team, and most software teams behave like dysfunctional families.", "", "- Attributed to Jim McCarthy" },
		-- Internet paraphrase; the "wall of mini stones" imagery is not traceable to
		-- any Knuth publication or interview.
		{ "People think that computer science is the art of geniuses but the actual reality is the opposite, just many people doing things that build on each other, like a wall of mini stones.", "", "- Attributed to Donald Knuth" },
		-- Martin Fowler, Refactoring (1999), p. 15.
		-- https://en.wikiquote.org/wiki/Martin_Fowler
		{ "Any fool can write code that a computer can understand. Good programmers write code that humans can understand.", "", "- Martin Fowler" },
		-- Weinberg's second law, traced to The CoEvolution Quarterly no. 8 (1975).
		-- https://quoteinvestigator.com/2019/09/19/woodpecker/
		{ "If builders built buildings the way programmers wrote programs, then the first woodpecker that came along would destroy civilization.", "", "- Gerald Weinberg" },
		-- Stewart Brand, The Media Lab: Inventing the Future at MIT (1987).
		{ "Once a new technology starts rolling, if you're not part of the steamroller, you're part of the road.", "", "- Stewart Brand" },
		-- Play on the "teach a man to fish" proverb credited to quant researcher
		-- David Leinweber; no originating publication located.
		{ "Give someone a program; you frustrate them for a day; teach them how to program, and you frustrate them for a lifetime.", "", "- Attributed to David Leinweber" },
		-- Widely reproduced as Dan Salomon; no original context or publication located.
		{ "Sometimes it pays to stay in bed on Monday, rather than spending the rest of the week debugging Monday's code.", "", "- Attributed to Dan Salomon" },
		-- Andrew Hunt and David Thomas, The Pragmatic Programmer (1999). Co-authored,
		-- though popularly credited to Hunt alone.
		{ "No one in the brief history of computing has ever written a piece of perfect software. It's unlikely that you'll be the first.", "", "- Andrew Hunt and David Thomas" },
		-- Steve McConnell, Rapid Development (Microsoft Press, 1996).
		{ "It's better to wait for a productive programmer to become available than it is to wait for the first available programmer to become productive.", "", "- Steve McConnell" },
		-- Steve Jobs, 1995 interview (Computerworld Smithsonian oral history), later
		-- released as "Steve Jobs: The Lost Interview".
		{ "Everybody in this country should learn to program a computer because it teaches you how to think.", "", "- Steve Jobs" },
		-- Ubiquitously credited to Gates but absent from his documented speeches and
		-- writings, including the Wikiquote misattributed section.
		{ "Measuring programming progress by lines of code is like measuring aircraft building progress by weight.", "", "- Attributed to Bill Gates" },
		-- Consistent with Graham's essays but not matched to a specific essay; exact
		-- wording and source unconfirmed.
		{ "In programming, the hard part isn't solving problems but deciding what problems to solve.", "", "- Attributed to Paul Graham" },
		-- Frequently credited to McIlroy in quotation lists; no talk, paper, or
		-- interview confirming it located.
		{ "As a programmer, it is your job to put yourself out of business. What you do today can be automated tomorrow.", "", "- Attributed to Doug McIlroy" },
		-- Attributed to the activist Jeremy Hammond and widely circulated, but the
		-- original context could not be located. Editorial repair: added "someone".
		{ "Your mind is programmable - if you're not programming your mind, someone else will program it for you.", "", "- Attributed to Jeremy Hammond" },
		-- Commonly credited to Cray but absent from his documented interviews.
		{ "The trouble with programmers is that you can never tell what a programmer is doing until it's too late.", "", "- Attributed to Seymour Cray" },
		-- Appears only in aggregated quotation lists credited to "Aaron Lozier"; no
		-- verifiable original. Editorial repair: "Making code does" -> "Making code do".
		{ "Making code do what it's supposed to do is the easy part. Handling the myriad ways it can go wrong is the real work.", "", "- Unattributed" },
		-- Herb Sutter and Andrei Alexandrescu, C++ Coding Standards (2004), item 8.
		{ "It is far, far easier to make a correct program fast than to make a fast program correct.", "", "- Herb Sutter and Andrei Alexandrescu" },
		-- Consistent with McKenzie's ("patio11") career advice, but the exact wording
		-- is not pinned to a specific post or tweet.
		{ "Every great developer you know got there by solving problems they were unqualified to solve until they actually did it.", "", "- Attributed to Patrick McKenzie" },
		-- Not found in the E. W. Dijkstra Archive or his Wikiquote page; unsourced
		-- folklore falsely attached to his name.
		{ "If debugging is the process of removing software bugs, then programming must be the process of putting them in.", "", "- Unattributed" },
		-- Credited to Andrew Clark (React core team) as a tweet; original not located.
		{ "In programming, if someone tells you you're overcomplicating it, they're either 10 steps behind you or 10 steps ahead of you.", "", "- Attributed to Andrew Clark" },
		-- Peter Drucker, "Managing for Business Effectiveness", Harvard Business
		-- Review, May 1963. The original reads "surely nothing quite so useless as
		-- doing with great efficiency what should not be done at all".
		{ "There is nothing quite so useless as doing with great efficiency something that should not be done at all.", "", "- Peter Drucker" },
		-- Condensation of Dijkstra's recurring "complexities of our own making" theme
		-- (e.g. EWD1243a); not a verbatim line from any single EWD.
		{ "The computing scientist's main challenge is not to get confused by the complexities of his own making.", "", "- Edsger W. Dijkstra" },
		-- In Kay's idiom and universally credited to him, but the original venue is
		-- unverified.
		{ "Progress in a fixed context is almost always a form of optimization. Creative acts generally don't stay in the context that they are in.", "", "- Attributed to Alan Kay" },
		-- In Wadler's voice and widely attached to him, but no specific paper or slide
		-- confirmed as the source.
		{ "The essence of XML is this: the problem it solves is not hard, and it does not solve the problem well.", "", "- Attributed to Phil Wadler" },
		-- Characteristic of Pike and consistently attributed to him, but the original
		-- posting could not be located.
		{ "dd is horrible on purpose. It's a joke about OS/360 JCL. But today it's an internationally standardized joke. I guess that says it all.", "", "- Attributed to Rob Pike" },
		-- In Milewski's voice; the exact source post on his concurrency blog is
		-- unverified.
		{ "If programmers were electricians, parallel programmers would be bomb disposal experts. Both cut wires.", "", "- Attributed to Bartosz Milewski" },
		-- Dennie van Tassel, The Compleat Computer (1976).
		{ "I've finally learned what \"upward compatible\" means. It means we get to keep all our old mistakes.", "", "- Dennie van Tassel" },
		-- Credited to Jeremy S. Anderson in quotation compilations; no primary source.
		{ "There are two major products that come out of Berkeley: LSD and UNIX. We don't believe this to be a coincidence.", "", "- Attributed to Jeremy S. Anderson" },
		-- Genuinely Torvalds and in his register (c. 2007 patent commentary), but the
		-- exact archived message was not pinned down.
		{ "The bulk of all patents are crap. Spending time reading them is stupid. It's up to the patent owner to do so, and to enforce them.", "", "- Attributed to Linus Torvalds" },
		-- A jokey eponymous "law" with no identifiable individual author.
		{ "Don't worry if it doesn't work right. If everything did, you'd be out of a job.", "", "- Mosher's Law of Software Engineering" },
		-- Jon Acuff, Finish: Give Yourself the Gift of Done (2017).
		{ "Developing tolerance for imperfection is the key factor in turning chronic starters into consistent finishers.", "", "- Jon Acuff" },
		-- Consistent with Bernstein's design philosophy and widely credited to him,
		-- but the original page was not confirmed.
		{ "The average user doesn't give a damn what happens, as long as (1) it works and (2) it's fast.", "", "- Attributed to Daniel J. Bernstein" },
		-- Strongly in Swartz's voice and commonly credited to him, but the exact essay
		-- or post is unverified.
		{ "Be curious. Read widely. Try new things. I think a lot of what people call intelligence boils down to curiosity.", "", "- Attributed to Aaron Swartz" },
	},
}
