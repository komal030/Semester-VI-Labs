# Basically Server ko apna time record karke bhejna hain

import socket
import datetime

def clockServer():
	host = socket.gethostname()
	port = 8011
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	s.bind((host, port))
	s.listen(5)
	while True:
		conn, addr = s.accept()
		time = datetime.datetime.now()
		time = str(time)	
		conn.send(time.encode())
	conn.close()

if __name__ == "__main__":
	clockServer()		
