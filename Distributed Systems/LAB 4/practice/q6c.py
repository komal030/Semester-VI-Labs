#multithreading in TCP chatbot
import socket
from _thread import *
s=socket.socket()
host=socket.gethostname()
port=12222
s.connect((host,port))
while True:
	msg=input("Client 1:")
	s.send(msg.encode())
	data=s.recv(1024).decode()
	print(f"Server: {data}")
s.close()	
