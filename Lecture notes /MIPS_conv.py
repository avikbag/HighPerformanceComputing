#!/usr/bin/python
# Mips Conversion into binary or hex

import argparse
import re

instr_dict = {"add": 0b000000,
              "sub": 0b000000,
              "lw" : 0b100011,
              "sw" : 0b101011
              }
func_dict =  {"add": 0b100000,
              "sub": 0b100010
              }
reg_dict   = {"$zero" :0,
              "$at"   :1,
              "$v0"   :2,
              "$v1"   :3,
              "$a0"   :4,
              "$a1"   :5,
              "$a2"   :6,
              "$a3"   :7,
              "$t0"   :8,
              "$t1"   :9,
              "$t2"   :10,
              "$t3"   :11,
              "$t4"   :12,
              "$t5"   :13,
              "$t6"   :14,
              "$t7"   :15,
              "$s0"   :16,
              "$s1"   :17,
              "$s2"   :18,
              "$s3"   :19,
              "$s4"   :20,
              "$s5"   :21,
              "$s6"   :22,
              "$s7"   :23,
              "$t8"   :24,
              "$t9"   :25
              }
r_type = {"add", "sub"}
i_type = {"lw", "sw"}

def instr(inp):
  if inp[0] in instr_dict:
    opcode = instr_dict[inp[0]]
  
  if inp[0] == "lw" or inp[0] == "sw":
    rs = reg_dict[inp[3]]
    immd = int(inp[2])
    rt = reg_dict[inp[1]]
    result =  (opcode << 26) + (rs << 21) + (rt << 16) + (immd)
  elif inp[0] in r_type:
    rs = reg_dict[inp[2]]
    rt = reg_dict[inp[3]]
    rd = reg_dict[inp[1]]
    func = func_dict[inp[0]]
    result =  (opcode << 26) + (rs << 21) + (rt << 16) + (rd << 11) + (func)
  
  return result
  


def main():
  parser = argparse.ArgumentParser(description="To convert MIPS to machine code")
  parser.add_argument("-s", "--src", type=str, help="Source Destination")
  parser.add_argument("-x", "--hex", type=int, help="hex(1)/binary(0)")

  args = parser.parse_args();
  src = args.src
  conv = args.hex
  
  f = open(src, 'r')
  
  line = f.readline()
  while(line):
    line = line.replace('\n', '').replace(')', '')
    data = re.split('[,() ]+', line)
    #print data
    final = instr(data)
    if conv == 1:
      print hex(final)
    else:
      print bin(final)
    line = f.readline()
  
  f.close()

if __name__ == "__main__":
  main()

