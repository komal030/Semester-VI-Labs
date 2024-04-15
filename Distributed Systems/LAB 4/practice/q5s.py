#exam question using TCP
import socket
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
host=socket.gethostname()
port=44450
s.bind((host,port))
s.listen(5)
print("Server running")
conn,addr=s.accept()
data=conn.recv(1024).decode()
data=data.strip()
words=data.split(" ")
even=""
odd=""
for num in words:
	num=int(num)
	copy=num
	sum=0
	while copy!=0:
		sum=sum+copy%10
		copy//=10
	print(f"Sum of digits of {num} : {sum}")
	if(sum%2==0):
		even=even+" "+str(sum)
	else:
		odd=odd+" "+str(sum)
combinedmsg=even+"\n"+odd
conn.send(combinedmsg.encode())
conn.close()
s.close()		 	
