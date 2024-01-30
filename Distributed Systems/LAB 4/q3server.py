import socket

host = '0.0.0.0'  # Bind to all available network interfaces
port = 3000
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((host, port))
s.listen(5)
conn, addr = s.accept()
print(f"Connection from {addr}")

while True:
    data = conn.recv(1024)
    if not data or str(data).find('exit') != -1:
        break
    print("The sender sent:", data.decode('utf-8'))
    msg = input("Enter a message to send: ")
    if msg.find('exit') != -1:
        break
    conn.sendall(str.encode(msg, encoding='utf-8'))

conn.close()

