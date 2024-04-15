#reverse a word in UDP
import socket
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
host=socket.gethostname()
port=33333
while True:
	msg=input("Enter a word ")
	s.sendto(msg.encode(),(host,port))
	if msg=='end':
		print("End of client")
		break
	rev,addr=s.recvfrom(1024)
	rev=rev.decode()
	print(f"Reverse of word {rev}")
s.close()	
	 
