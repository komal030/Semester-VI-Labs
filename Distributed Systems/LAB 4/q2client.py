import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
udp_host = '127.0.0.1'
udp_port = 31621

while True:
    msg = input("Type some text to send => ")
    s.sendto(msg.encode(), (udp_host,udp_port))
    print(f"1. Client Sent: {message}")

    data, addr = s.recvfrom(1024)
    print(f"2. Client received: {data.decode()}")

