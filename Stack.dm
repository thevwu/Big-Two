Stack
	var/size
	var/topElement
	var/list/elements

	New(var/creatingSize)
		size = creatingSize
		elements = new/list(creatingSize)
		topElement = 1

	proc
		push(var/item)  // use this to put items onto the stack
			if(!(size >= topElement))
				world << "resizing"
				resize()

			elements[topElement] = item
			topElement++

		pop() // use this to take items off the stack
			if(!isEmpty())
				topElement--

				return elements[topElement]

		peek() // this is to check the top item of the stack without removing
			return elements[topElement]

		size() // this returns the size
			return size

		isEmpty()
			if(topElement > 0) return FALSE
			else return TRUE

		resize() // this is so that if you did not make the stack the right size, it will make it larger for you.
			size = size * 2
			elements.len = size
