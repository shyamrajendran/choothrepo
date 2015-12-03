import time,sys
arg_list = sys.argv;

# filename = '/tmp/b.srt'
filename = arg_list[1]
maj_file = arg_list[2]
beg_file = arg_list[3]
end_file = arg_list[4]


# maj_file = 'maj'
# beg_file = 'beg'
# end_file = 'end'	


maj = []
beg= []
end = []

print maj_file ,"maj file"
with open(maj_file,'r') as f:
    for line in f:
		if len(line) == 0:
			break
		maj.append(line.strip())

print beg_file, "beg file"
with open(beg_file,'r') as f:
    for line in f:
		if len(line) == 0:
			break
		beg.append(line.strip())

print end_file, "end file"
with open(end_file,'r') as f:
    for line in f:
		if len(line) == 0:
			break
		end.append(line.strip())

print maj
print beg 
print end 

print filename, "out file"
f =  open(filename, 'w+')
for i in xrange(1,min(len(maj),len(end),len(beg))):
	f.write(str(i))
	f.write('\n')

	sec = float(beg[i])
	m = sec-int(sec)
	milli = '%03d' % int(float(format(m,'3.3f'))*1000)
	print m
	print milli
	print sec
	# print sec, "beg"
	start = str(time.strftime("%H:%M:%S",time.gmtime(int(float(sec)))))
	f.write(start)
	f.write(',')
	f.write(str(milli))
	f.write(' --> ')
	sec = float(end[i])
	m = sec-int(sec)
	milli = '%03d' % int(float(format(m,'3.3f'))*1000)
	print m
	print m
	print milli
	print sec
	endt = str(time.strftime("%H:%M:%S",time.gmtime(int(float(sec)))))
	f.write(endt)
	f.write(',')
	f.write(str(milli))
	f.write('\n')
	f.write(str(maj[i]))
	f.write('\n')
	f.write('\n')
f.close()
