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
		maj.append(line.strip())

print beg_file, "beg file"
with open(beg_file,'r') as f:
    for line in f:
		beg.append(line.strip())

print end_file, "end file"
with open(end_file,'r') as f:
    for line in f:
		end.append(line.strip())

print maj
print beg 
print end 

print filename, "out file"
f =  open(filename, 'w+')
for i in xrange(1,min(len(maj),len(end),len(beg))):
	f.write(str(i))
	f.write('\n')
	sec = beg[i]
	# print sec, "beg"
	start = str(time.strftime("%H:%M:%S",time.gmtime(int(sec))))
	f.write(start)
	f.write(',000 --> ')
	sec = end[i]
	# print sec, "end"
	endt = str(time.strftime("%H:%M:%S",time.gmtime(int(sec))))
	f.write(endt)
	f.write(',000')
	f.write('\n')
	f.write(str(maj[i]))
	f.write('\n')
	f.write('\n')
f.close()