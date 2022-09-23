module multiHull(){
	for (i = [1 : $children-1])
		hull(){
			children(0);
			children(i);
		}
}

module sequentialHull(){
	for (i = [0: $children-2])
		hull(){
			children(i);
			children(i+1);
		}
}