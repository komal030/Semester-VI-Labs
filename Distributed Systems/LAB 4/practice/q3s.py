#sum of digits from UDP
import socket
host=socket.gethostname()
port=22222
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
s.bind((host,port))
data,conn=s.recvfrom(1024)
msg=data.decode()
n=int(msg)
sum=0
while n!=0:
	sum=sum+n%10
	n//=10
sum=str(sum)	
s.sendto(sum.encode(),conn)
s.close()	
