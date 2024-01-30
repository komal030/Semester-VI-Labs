import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

udp_host = socket.gethostname()
udp_port = 12345

msg = "Requesting Time"
sock.sendto(msg.encode(), (udp_host, udp_port))  # Encode the string to bytes before sending

data, addr = sock.recvfrom(1024)

print('Current time from Server:', data.decode())

sock.close()

