#define DIAMONDS 1
#define CLUBS 2
#define HEARTS 3
#define SPADES 4

#define STRAIGHT
#define FLUSH
#define FULL HOUSE
#define FOURS
#define ROYAL FLUSH

DeckFactory
	var/list/cards[52] // make a list for your 52 cards

	New()  // this creates the deck of cards right here
		for(var/i = 52, i >= 1, i--)
			if(i <= 13)
				cards[i] = new /Card(DIAMONDS, i)  // this makes the diamonds
			else if(i <= 26)
				cards[i] = new /Card(CLUBS, i-13) // this makes the clubs
			else if(i <= 39)
				cards[i] = new /Card(HEARTS, i-26) // this makes the hearts
			else if(i <= 52)
				cards[i] = new /Card(SPADES, i-39) // and this makes the spades

	proc
		listCards()  // this is just a test proc, if you want to see how it shuffles
			for(var/Card/j in cards)
				world << "[j.returnCard()]"

		shuffleCards()  // this is an efficient shuffling algorithm, it works well if you shuffle once, but you can shuffle more than once
			for(var/k = 0, k < 1, k++)
				for(var/i = cards.len, i >= 1; i--)
					var/j = rand(0, i)
					var/temporary = cards[j]

					cards[j] = cards[i]
					cards[i] = temporary

		createDeck()  // use this to push your cards onto the stack
			var/Deck/deck = new /Deck(52)
			for(var/i = 1, i < cards.len+1; i++)
				deck.push(cards[i])

			return deck

Deck
	parent_type = /Stack

Hand
	parent_type = /Stack
	elements = new/list(13)

	var/mob/player

Card
	var/value
	var/suit

	var/list/values = list("Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King")
	var/list/suits = list("Diamonds", "Clubs", "Hearts", "Spades")

	New(var/newSuit, var/newValue)
		suit = newSuit
		value = newValue

	proc
		setValue(var/newValue)
			value = newValue

		getValue()
			return value

		setSuit(var/newSuit)
			suit = newSuit

		getSuit()
			return suit

		returnCard()
			return "[values[value]] of [suits[suit]]"

CardCombination
	var/list/Card/cards[5]
	var/size = 0

	proc
		addCard(var/Card/newCard)
			cards.Add(newCard)
			size++

		removeCard(var/Card/oldCard)
			cards.Remove(oldCard)
			size--

		size()
			return size

		getCards()
			return cards

		compareTo(var/CardCombination/opponent)
			var/list/Card/opponentCards = opponent.getCards()

			if(size == 1)
				return singleCards(opponentCards)
			if(size == 2)
				return pairOfCards(opponentCards)
			if(size == 3)
				return tripleCards(opponentCards)
			if(size == 5)
				return fiveCards(opponentCards)

		isValid()
			var/Card/card1 = cards[1]
			var/Card/card2 = cards[2]
			var/Card/card3 = cards[3]

			if(size == 1)
				return TRUE
			if(size == 2)
				return (card1.getValue() == card2.getValue())
			if(size == 3)
				return (card1.getValue() == card2.getValue() == card3.getValue())
			if(size == 5)
				if(isFlush()) return TRUE
				if(isStraight()) return TRUE
				if(isFullHouse()) return TRUE
				if(isFours()) return TRUE

				return FALSE

		isFlush()
			var/Card/firstCard = cards[1]
			var/suit = firstCard.getSuit()

			for(var/Card/yourCards in cards)
				if(yourCards.getSuit() != suit)
					return FALSE

			return TRUE

		isStraight()
			var/Card/firstCard
			var/Card/nextCard

			for(var/i = 1, i <= 5, i++)
				firstCard = cards[i]
				for(var/j = 1, j <= 5, j++)
					nextCard = cards[j]
					if(firstCard.getValue() == nextCard.getValue())
						return TRUE

			return FALSE

		isFours()


		singleCards(var/list/Card/opponentCards)
			var/Card/yourCard = cards[1]
			var/Card/opponentCard = cards[1]

			if(yourCard.getValue() > opponentCard.getValue())
				return TRUE
			else if(yourCard.getValue() == opponentCard.getValue())
				return (yourCard.getSuit() > opponentCard.getSuit())
			else
				return FALSE

		pairOfCards(var/list/Card/opponentCards)
			var/Card/yourCard = cards[1]
			var/Card/opponentCard = cards[1]

			if(yourCard.getValue() > opponentCard.getValue())
				return TRUE
			else if(yourCard.getValue() == opponentCard.getValue())
				var/yourSuitValue
				var/opponentSuitValue

				for(var/Card/yourCardValue in cards)
					yourSuitValue += yourCardValue.getSuit()

				for(var/Card/opponentCardValue in opponentCards)
					opponentSuitValue += opponentCardValue.getSuit()

				return (yourSuitValue > opponentSuitValue)
			else
				return FALSE

		tripleCards(var/list/Card/opponentCards)
			return singleCards(opponentCards)

		fiveCards(var/list/Card/opponentCards)
