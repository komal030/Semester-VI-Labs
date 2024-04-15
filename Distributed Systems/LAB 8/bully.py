import random
import time
def bully():
	nodes=['P1','P2','P3','P4','P5']
	coordinator=random.choice(nodes)
	print("Initially, coordinator is "+coordinator)
	curr_node=coordinator
	while(curr_node==coordinator):
		curr_node=random.choice(nodes)
	print(curr_node+" sent a message to coordinator")
	time.sleep(3)
	print("Timeout, coordinator has crashed")	
	done_nodes=[]
	candidates=[curr_node]
	while True:
		curr_node=candidates.pop()
		if(curr_node in done_nodes):
			continue
		flag=False	
		print(curr_node+" is holding elections")
		done_nodes.append(curr_node)
		for node in nodes:
			if(node>curr_node and node!=coordinator):
				flag=True
				print(curr_node+" sent an election message to "+node)
				time.sleep(2)
				print(node+" sent an OK message to "+curr_node)
				candidates.append(node)
		if(flag==False):
			print(curr_node+" is the new Coordinator")
			for node in nodes:
				if(node!=coordinator and node!=curr_node):
					print(curr_node+" sends coordinator message to "+node)
			break						
if __name__ == '__main__':
	obj=bully()						
				 
