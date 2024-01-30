import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

udp_host = '127.0.0.1'
udp_port = 31621

sock.bind((udp_host, udp_port))

print("####### Server is listening #######")

while True:
    msg, client_address = sock.recvfrom(1024)
    print(f"2. Server received: {msg.decode()}")

    reply = input("Type some text to send => ")
    sock.sendto(reply.encode(), client_address)
    print(f"1. Server sent: {reply}")
