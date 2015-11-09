
import datetime
filename = '/tmp/a.txt'
f = open(filename, 'w')


a = [1,2,3,1]
b = [1.4,4.5,10.4,17.8]
c = [2.8,6.2,11.2,24.8]
for i in xrange(1,len(a)):
	f.write(str(i))
	f.write('\n')
	start = str(datetime.timedelta(seconds=int(b[i])))
	f.write(start)
	f.write(',000 --> ')
	endt = str(datetime.timedelta(seconds=int(c[i])))
	f.write(endt)
	f.write(',000')
	f.write('\n')
	f.write(str(a[i]))
	f.write('\n')
	f.write('\n')

f.close()