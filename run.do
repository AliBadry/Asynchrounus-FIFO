
vlog ./AND2.v
vlog ./Binary_counter.v
vlog ./Binary2Gray.v
vlog ./Empty.v
vlog ./FIFO.v
vlog ./Memory.v
vlog ./Full.v
vlog ./Synchronizer.v
vlog ./XOR2.v
vlog ./FIFO_TB.v

vsim -voptargs="+acc" work.FIFO_TB 
add wave *
add wave -position insertpoint  \
sim:/FIFO_TB/DUT/Full_sig

add wave -position insertpoint  \
sim:/FIFO_TB/DUT/Empty_sig

add wave -position insertpoint  \
sim:/FIFO_TB/DUT/And_out_Rd

add wave -position insertpoint  \
sim:/FIFO_TB/DUT/And_out_Wr

add wave -position insertpoint  \
sim:/FIFO_TB/DUT/E1/Rd_point

add wave -position insertpoint  \
sim:/FIFO_TB/DUT/E1/Synch_Wr_point

add wave -position insertpoint  \
sim:/FIFO_TB/DUT/Mem1/Wr_addr

add wave -position insertpoint  \
sim:/FIFO_TB/DUT/Mem1/Rd_addr

add wave -position insertpoint  \
sim:/FIFO_TB/DUT/F1/Wr_point

add wave -position insertpoint  \
sim:/FIFO_TB/DUT/F1/Synch_Rd_point

add wave -position insertpoint  \
sim:/FIFO_TB/DUT/Mem1/Mem
run -all
