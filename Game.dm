Game
	var/list/mob/players[4]
	var/Deck/deck
	var/list/Hand/hands[4]
	var/turn

	proc
		joinGame(var/mob/joiner, var/spotToJoin)
			if(spotToJoin != 0)
				players[spotToJoin] = joiner
			else
				players.Add(joiner)

		leaveGame(var/leaver)
			var/delete = players.Find(leaver)
			players[delete] = null

		createDeck()
			var/DeckFactory/deckCreator = new /DeckFactory()
			deckCreator.shuffleCards()
			deckCreator.shuffleCards()
			deck = deckCreator.createDeck()

		dealCards()
			for(var/i = 1, i <= 13, i++)
				for(var/Hand/playersHand in hands)
					playersHand.push(deck.pop())

		incrementTurn()
			if(turn == 4) turn = 1
			else          turn++

		startGame()


		isGameOver()
			for(var/Hand/playersHand in hands)
				if(playersHand.size() == 0)
					return TRUE

			return FALSE