import csv

result = [["decomp_type_id", "point_num", "proc_num", "overlapping_rate", "new algorithm", "new algorithm", "old algorithm", "old algorithm"]]
with open("record_time", "r") as f:
	lines = f.readlines()
	i = 0
	while(i < len(lines)):
		line1 = lines[i].strip().split(" ")
		line22 = []
		for ii in range(0,len(line1)):
			if(line1[ii] <> ''):
				line22.append(line1[ii])
		temp1 = float(lines[i+1].strip().split(" ")[5])
		temp2 = float(lines[i+3].strip().split(" ")[5])
		if(temp1 > temp2):
			line22.append(temp1)
		else:
			line22.append(temp2)
                temp1 = float(lines[i+2].strip().split(" ")[5])
                temp2 = float(lines[i+4].strip().split(" ")[5])
		if(temp1 > temp2):
			line22.append(temp1)
		else:
                	line22.append(temp2)
		i=i+5
		result.append(line22)
csv_writer = csv.writer(open("recordatm.csv","w"))
csv_writer.writerows(result)
