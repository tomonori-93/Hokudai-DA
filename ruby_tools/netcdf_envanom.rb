#!/usr/bin/ruby
# automatically caluclate netcdf_envanom

ifile = ARGV[0]
ofile = ARGV[1]

f_in = open("netcdf_envanom_temp.txt","r").read.gsub("TEMPLATE_IN",ifile).gsub("TEMPLATE_OUT",ofile)
out_file = open("netcdf_envanom.txt","w")
out_file.write(f_in)
out_file.close
system("./netcdf_envanom netcdf_envanom.txt")
#system("rm netcdf_envanom.txt")
