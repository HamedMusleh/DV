module tb_my_mem;
    logic        clk;
    logic        write;
    logic        read;
    logic [7:0]  data_in;
    logic [15:0] address;
    logic [8:0]  data_out;

    // ─── DUT instantiation ─────────────────────────────────────────
    my_mem dut (
        .clk      (clk),
        .write    (write),
        .read     (read),
        .data_in  (data_in),
        .address  (address),
        .data_out (data_out)
    );

    // ─── Clock generation ──────────────────────────────────────────
    initial clk = 0;
    always #5 clk = ~clk;

    // ─── Dynamic arrays (module-level) ─────────────────────────────
    logic [15:0] address_array      [];
    logic [7:0]  data_to_write_array[];

    // ─── Associative array ─────────────────────────────────────────
    logic [8:0]  data_read_expect_assoc [logic [15:0]];

    // ─── Queue ─────────────────────────────────────────────────────
    logic [8:0]  data_read_queue [$];

    // ─── Error counter & loop var (module-level) ───────────────────
    int error_count;
    int i;

    // ─── FSDB Dump ─────────────────────────────────────────────────
    initial begin
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0, tb_my_mem);
    end

    // ═══════════════════════════════════════════════════════════════
    // Main test
    // ═══════════════════════════════════════════════════════════════
    initial begin
        // Init
        write       = 0;
        read        = 0;
        data_in     = '0;
        address     = '0;
        error_count = 0;

        // ── Allocate dynamic arrays ────────────────────────────────
        address_array       = new[6];
        data_to_write_array = new[6];

        // ── Generate 6 random addresses and data ───────────────────
        for (i = 0; i < 6; i++) begin
            address_array[i]       = $urandom;
            data_to_write_array[i] = $urandom;
        end

        // ════════════════════════════════════════════════════════════
        // PHASE 1 — 6 Writes
        // ════════════════════════════════════════════════════════════
        $display("\n===== WRITE PHASE =====");
        for (i = 0; i < 6; i++) begin
            @(negedge clk);
            write   = 1;
            read    = 0;
            address = address_array[i];
            data_in = data_to_write_array[i];

            @(posedge clk);
            #1;

            data_read_expect_assoc[address_array[i]] =
                {^data_to_write_array[i], data_to_write_array[i]};

            $display("WRITE[%0d]: addr=0x%04h  data_in=0x%02h  expected=0x%03h",
                     i, address_array[i], data_to_write_array[i],
                     data_read_expect_assoc[address_array[i]]);
        end

        @(negedge clk);
        write = 0;

        // ════════════════════════════════════════════════════════════
        // PHASE 2 — 6 Reads in REVERSE order
        // ════════════════════════════════════════════════════════════
        $display("\n===== READ PHASE (reverse order) =====");
        for (i = 5; i >= 0; i--) begin
            @(negedge clk);
            read    = 1;
            write   = 0;
            address = address_array[i];

            @(posedge clk);
            #1;
            @(posedge clk);
            #1;

            data_read_queue.push_back(data_out);

            if (data_out !== data_read_expect_assoc[address_array[i]]) begin
                $display("ERROR[%0d]: addr=0x%04h  expected=0x%03h  got=0x%03h",
                         i, address_array[i],
                         data_read_expect_assoc[address_array[i]], data_out);
                error_count++;
            end else begin
                $display("READ [%0d]: addr=0x%04h  data_out=0x%03h  [PASS]",
                         i, address_array[i], data_out);
            end
        end

        @(negedge clk);
        read = 0;

        // ════════════════════════════════════════════════════════════
        // PHASE 3 — Print queue and error count
        // ════════════════════════════════════════════════════════════
        $display("\n===== data_read_queue contents =====");
        for (i = 0; i < data_read_queue.size(); i++)
            $display("  data_read_queue[%0d] = 0x%03h", i, data_read_queue[i]);

        $display("\n===== RESULT =====");
        $display("Error count = %0d", error_count);

        if (error_count == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED — %0d error(s)", error_count);

        $finish;
    end

    // ─── Timeout watchdog ──────────────────────────────────────────
    initial begin
        #10000;
        $display("TIMEOUT");
        $finish;
    end

endmodule
