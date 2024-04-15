#sum of digits from UDP
import socket
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
host=socket.gethostname()
port=22222
num=input("Enter a number ")
num=str(num)
s.sendto(num.encode(),(host,port))
msg,addr=s.recvfrom(1024)
print("Sum of digits: ",msg.decode())
s.close()
s
