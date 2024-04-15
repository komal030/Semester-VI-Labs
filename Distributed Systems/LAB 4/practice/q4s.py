#reverse a word in UDP
import socket
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
host=socket.gethostname()
port=33333
s.bind((host,port))
print("Server is running")
while True:
	msg,addr=s.recvfrom(1024)
	msg=msg.decode()
	if(msg=='end'):
		print("End of server")
		break
	rev=msg[::-1]
	s.sendto(rev.encode(),addr)
s.close()	
