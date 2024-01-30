import socket
import time

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

udp_host = socket.gethostname()
udp_port = 12345

sock.bind((udp_host, udp_port))

while True:
    print("Waiting for client...")
    data, addr = sock.recvfrom(1024)  
    current_time = time.ctime(time.time()) 
    sock.sendto(current_time.encode(), addr)

