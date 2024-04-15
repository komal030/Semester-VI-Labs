import random
def ring():
	nodes=['P1','P2','P3','P4','P5']
	coordinator=random.choice(nodes)
	print(coordinator+" is the coordinator")
	curr_node=coordinator
	while curr_node== coordinator:
		curr_node=random.choice(nodes)
	print(curr_node+" notices that the coordinator failed")
	start=nodes.index(curr_node)
	n=len(nodes)
	candidates=[curr_node]
	i=(start+1)%n
	prev=start
	while (i!=start):
		if(nodes[prev]!=coordinator and nodes[i]!=coordinator):
			print(nodes[prev]+" sends election message to "+nodes[i])
			candidates.append(nodes[i])
			i=(i+1)%n
			prev=(prev+1)%n
		elif(nodes[prev]==coordinator):
			prev=(prev+1)%n
		else:
			i=(i+1)%n	

	print(nodes[(start-1)%n]+" sends election message to "+nodes[i])	
	max_coordinator=max(candidates)
	print("New coordinator is "+max_coordinator)
	
if __name__=='__main__':
	ring()		 	
