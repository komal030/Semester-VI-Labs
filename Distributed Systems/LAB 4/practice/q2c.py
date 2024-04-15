#reverse word using TCP
import socket
host=socket.gethostname()
port=11111
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect((host,port))
while True:
	msg=input("Enter word: ")
	s.send(msg.encode())
	if(msg=='end'):
		break
	rev=s.recv(1024).decode()
	print("Reversed word: "+rev)
print("End of client")
s.close()	
	
