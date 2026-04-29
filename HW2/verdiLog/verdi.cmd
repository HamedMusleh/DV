verdiSetActWin -dock widgetDock_<Decl._Tree>
simSetSimulator "-vcssv" -exec "/home/st4/HW2/simv" -args
debImport "-dbdir" "/home/st4/HW2/simv.daidir"
debLoadSimResult /home/st4/HW2/waves.fsdb
wvCreateWindow
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcSignalView -on
verdiSetActWin -dock widgetDock_<Signal_List>
srcSignalViewSelect "tb_my_mem.clk"
srcSignalViewSelect "tb_my_mem.i\[31:0\]"
srcSignalViewSelect "tb_my_mem.address_array\[0:0\]" \
           "tb_my_mem.data_to_write_array\[0:0\]" \
           "tb_my_mem.data_read_expect_assoc\[8:0\]" \
           "tb_my_mem.data_read_queue\[8:0\]" "tb_my_mem.error_count\[31:0\]" \
           "tb_my_mem.i\[31:0\]"
srcSignalViewSelect "tb_my_mem.address\[15:0\]" "tb_my_mem.data_out\[8:0\]" \
           "tb_my_mem.address_array\[0:0\]" \
           "tb_my_mem.data_to_write_array\[0:0\]" \
           "tb_my_mem.data_read_expect_assoc\[8:0\]" \
           "tb_my_mem.data_read_queue\[8:0\]" "tb_my_mem.error_count\[31:0\]" \
           "tb_my_mem.i\[31:0\]"
srcSignalViewSelect "tb_my_mem.data_in\[7:0\]" "tb_my_mem.address\[15:0\]" \
           "tb_my_mem.data_out\[8:0\]" "tb_my_mem.address_array\[0:0\]" \
           "tb_my_mem.data_to_write_array\[0:0\]" \
           "tb_my_mem.data_read_expect_assoc\[8:0\]" \
           "tb_my_mem.data_read_queue\[8:0\]" "tb_my_mem.error_count\[31:0\]" \
           "tb_my_mem.i\[31:0\]"
srcSignalViewSelect "tb_my_mem.read" "tb_my_mem.data_in\[7:0\]" \
           "tb_my_mem.address\[15:0\]" "tb_my_mem.data_out\[8:0\]" \
           "tb_my_mem.address_array\[0:0\]" \
           "tb_my_mem.data_to_write_array\[0:0\]" \
           "tb_my_mem.data_read_expect_assoc\[8:0\]" \
           "tb_my_mem.data_read_queue\[8:0\]" "tb_my_mem.error_count\[31:0\]" \
           "tb_my_mem.i\[31:0\]"
srcSignalViewSelect "tb_my_mem.write" "tb_my_mem.read" "tb_my_mem.data_in\[7:0\]" \
           "tb_my_mem.address\[15:0\]" "tb_my_mem.data_out\[8:0\]" \
           "tb_my_mem.address_array\[0:0\]" \
           "tb_my_mem.data_to_write_array\[0:0\]" \
           "tb_my_mem.data_read_expect_assoc\[8:0\]" \
           "tb_my_mem.data_read_queue\[8:0\]" "tb_my_mem.error_count\[31:0\]" \
           "tb_my_mem.i\[31:0\]"
srcSignalViewSelect "tb_my_mem.clk" "tb_my_mem.write" "tb_my_mem.read" \
           "tb_my_mem.data_in\[7:0\]" "tb_my_mem.address\[15:0\]" \
           "tb_my_mem.data_out\[8:0\]" "tb_my_mem.address_array\[0:0\]" \
           "tb_my_mem.data_to_write_array\[0:0\]" \
           "tb_my_mem.data_read_expect_assoc\[8:0\]" \
           "tb_my_mem.data_read_queue\[8:0\]" "tb_my_mem.error_count\[31:0\]" \
           "tb_my_mem.i\[31:0\]"
srcSignalViewAddSelectedToWave -win $_nTrace1 -clipboard
wvDrop -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
verdiSetActWin -dock widgetDock_<Signal_List>
debExit
