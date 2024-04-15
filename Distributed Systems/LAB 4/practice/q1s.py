#sum of digits using TCP
import socket

host=socket.gethostname()
port=12346

s=socket.socket(socket.AF_INET,socket.SOCK_STREAM,0)
s.bind((host,port))
s.listen(5)
print("Server running")
conn,addr=s.accept()
num=conn.recv(1024).decode()
n=int(num)
sum=0
while n!=0:
	sum=sum+(n%10)
	n//=10
sum=str(sum)
conn.send(sum.encode())
conn.close()
s.close()	
