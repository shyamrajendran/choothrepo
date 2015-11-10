import sys
import datetime
arg_list = str(sys.argv);

# filename = arg_list[0]
# maj_file = arg_list[1]
# start_file = arg_list[2]
# end_file = arg_list[3]

maj_file = 'maj'
start_file = 'beg'
end_file = 'end'	


maj = []
start = []
end = []


with open(maj_file,'r') as f:
    for line in f:
		maj.append(line.strip())
		print maj


with open(start_file,'r') as f:
    for line in f:
		start.append(line.strip())

with open(end_file,'r') as f:
    for line in f:
		end.append(line.strip())

print start,end,maj
# print maj

# for i in xrange(1,len(a)):
# 	f.write(str(i))
# 	f.write('\n')
# 	start = str(datetime.timedelta(seconds=int(b[i])))
# 	f.write(start)
# 	f.write(',000 --> ')
# 	endt = str(datetime.timedelta(seconds=int(c[i])))
# 	f.write(endt)
# 	f.write(',000')
# 	f.write('\n')
# 	f.write(str(a[i]))
# 	f.write('\n')
# 	f.write('\n')

# f.close()