#reverse word using TCP
import socket
host=socket.gethostname()
port=11111
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.bind((host,port))
s.listen(5)
print("Server running")
conn,addr=s.accept()
while True:
	msg=conn.recv(1024).decode()
	rev=msg[::-1]
	conn.send(rev.encode())
conn.close()
s.close()	
