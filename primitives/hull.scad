module multiHull(){
	assert($children > 1, str("children count should be more than one, ", $children, " given"));
    for (i = [1 : $children-1])
		hull(){
			children(0);
			children(i);
		}
}

module sequentialHull(){
    assert($children > 1, str("children count should be more than one, ", $children, " given"));
	for (i = [0: $children-1])
    hull(){
        if (i != undef && i > 0){
            children(i);
            children(i+1);
        }
    }
}