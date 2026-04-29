simSetSimulator "-vcssv" -exec "/home/st4/HW3/simv" -args
debImport "-dbdir" "/home/st4/HW3/simv.daidir"
debLoadSimResult /home/st4/HW3/waves.fsdb
wvCreateWindow
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiWindowResize -win $_Verdi_1 "8" "31" "879" "782"
srcSignalViewSelect "adder_tb.clk"
verdiSetActWin -dock widgetDock_<Signal_List>
srcSignalViewSelect "adder_tb.clk" "adder_tb.reset"
srcSignalViewSelect "adder_tb.clk" "adder_tb.reset" "adder_tb.in1\[7:0\]"
srcSignalViewSelect "adder_tb.clk" "adder_tb.reset" "adder_tb.in1\[7:0\]" \
           "adder_tb.in2\[7:0\]"
srcSignalViewSelect "adder_tb.clk" "adder_tb.reset" "adder_tb.in1\[7:0\]" \
           "adder_tb.in2\[7:0\]" "adder_tb.sum\[8:0\]"
srcSignalViewAddSelectedToWave -win $_nTrace1 -clipboard
wvDrop -win $_nWave2
verdiSetActWin -win $_nWave2
debExit
