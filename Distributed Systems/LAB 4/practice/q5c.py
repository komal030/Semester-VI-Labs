#exam question using TCP
import socket
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
host=socket.gethostname()
port=44450
s.connect((host,port))
words=input("Enter numbers: ")
s.send(words.encode())
even,odd=s.recv(1024).decode().split("\n",1)
print("Even sum: ",even)
print("Odd sum: ",odd)
s.close()
