# Idea here is 
# 1.) Record the time
# 2.) Receive time from server
# 3.) record the time
# 4.) get actual time
# 5.) tclient = 2.) + {1.) - 3.)}/ 2
# 6.) error = tclient - 4.)

import socket
import datetime
from dateutil import parser
from timeit import default_timer as timer

def synchronizeTime(s):
	t0 = timer()
	tserver = s.recv(1024).decode()
	tserver = parser.parse(tserver)
	t1 = timer()
	tactual = datetime.datetime.now()
	diff = datetime.timedelta(seconds = (t1 - t0))
	tclient = tserver + diff / 2
	error = tactual - tclient
	return tclient, tactual, error

if __name__ == "__main__":
	host = socket.gethostname()
	port = 8011
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	s.connect((host, port))
	tclient, tactual, error = synchronizeTime(s)
	print(str(tclient) + "\n" + str(tactual) + "\n" + str(error))
	
	

