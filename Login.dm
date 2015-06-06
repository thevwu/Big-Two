// Well how the heck do I use this thing?  Here's a test code for you guys.

mob
	Login()
		var/DeckFactory/j = new /DeckFactory() // first you must initalize the cards


		world << "<font size = 5>Deck before shuffling."
		j.listCards()

		world << "<font size = 5>Shuffling deck..."
		j.shuffleCards() // this will shuffle the cards, you can use this whenever

		world << "<font size = 5>Shuffling deck..."
		j.shuffleCards()

		world << "<font size = 5>Deck after shuffling."
		j.listCards() // this makes a list of cards

		world << "<font size = 5>Making the deck of cards."
		var/Deck/deck = j.createDeck() // and then the stack, this will be your deck of cards

		for(var/i = 1, i <= 52, i++)
			var/Card/test = deck.pop()  //if you want to take a card out, simply use the pop() method
			world << "Popping off card: [test.returnCard()]" //and use returnCard() to get its suit and values
																   //  use any of the get or set methods as well!

mob
	player
		var/Hand/yourHand

		proc
			getHand()
				return yourHand
			setHand(var/Hand/newHand)
				yourHand = newHand

/*  When using this, you must initialize the deckfactory and stack.
    Shuffle the cards if you wish, if not then just insert the cards into the stack.
    Whenever you want to take a card out of the stack, just pop it out.
    If you want to take a look at it beforehand, use peek.

    Feel free to apply your own implementations to this code.
    Remember that since a deck of cards is 52 cards, you want to use inclusive loops such as <= 52 when looping through it.
    Give me credit if you use this thing.
*/