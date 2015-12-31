#!/usr/bin/env python3
#Author: Robert Markl
#This program prepares the Memory.hex 
#First it writes the program hex code into Memory.hex
#Then it fills up the remaining space with 000 which is required by the bootloader
#USAGE: memory_generate.py
#           [program.hex] [Memory.hex] [--Size 4076]

import os.path
import sys

path_program = "program.hex"
path_memory = "Memory.hex"
memory_size = 4076

if len(sys.argv) > 1:
	path_program = sys.argv[1]

if len(sys.argv) > 2:
	path_memory = sys.argv[2]

if len(sys.argv) > 3:
    if len(sys.argv) > 4:
            if sys.argv[3] == "--Size":
                memory_size = int(sys.argv[4])
            else:
                print("Unknown Parameter", sys.argv[3])
                sys.exit(1)
    else:
        print("Missing Parameter after", sys.argv[3])        
        

if os.path.exists(path_program) == False:
    print("Could not find program hex-file")
    sys.exit(1)
    
if os.path.exists(path_memory) == False:
    print("Could not find memory hex-file")
    sys.exit(1)

#if True:
try:
    file_memory = open(path_memory, 'w')   
    
    with open(path_program) as file_program:
        i = 0
        linenr = 0
        for line in file_program:
                linenr = linenr +1
                if len(line) != 4:
                        print("Skipping line {0}: wrong length".format(linenr))
                        continue
                file_memory.write(line)
                i = i+1
                if i > memory_size:
                        print("Program must not be larger than {0} words!".format(memory_size))
                        sys.exit(1)
    print("Program size = {0} words".format(i))
    for j in range(i, memory_size):
            file_memory.write("000\n")
            
    file_memory.close()
    print("End success")
    sys.exit(0)
except IOError as e:
    print ("I/O error({0}): {1}".format(e.errno, e.strerror))
    sys.exit(1)
except Exception as e:
    print ("Unknown error", e)
    sys.exit(1)
