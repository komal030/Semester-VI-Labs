#multithreading in TCP chatbot
import socket
from _thread import *
thread_count=0
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
host=socket.gethostname()
port=12222
s.bind((host,port))
s.listen(5)
print("Server is running")

def threaded_connection(conn,thread_count):
	while True:
		msg=conn.recv(1024).decode()
		print(f"Client {thread_count+1}: {msg}")
		data=input("You: ")
		conn.send(data.encode())

while True:
	conn,addr=s.accept()				
	start_new_thread(threaded_connection,(conn,thread_count))
	thread_count+=1
s.close()
		
