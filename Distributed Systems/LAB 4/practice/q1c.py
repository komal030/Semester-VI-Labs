#sum of digits using TCP
import socket
host=socket.gethostname()
port=12346
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM,0)
s.connect((host,port))
n=input("Enter a number: ")
s.send(n.encode())
sum=s.recv(1024).decode()
print("Sum of digits: ",sum)
s.close()
