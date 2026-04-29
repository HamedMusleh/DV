import transaction_pkg::*;

program test(mem_if mif);

    Transaction gen_q[$];
    Transaction drv_q[$];
    Transaction mon_q[$];

    task gen_transaction();
        Transaction t;

        repeat (10) begin
            t = new();
            t.expected_data = {^t.data_in, t.data_in};
            gen_q.push_back(t.copy());

            $display("[GEN] time=%0t addr=%0h data_in=%0h expected=%0h",
                     $time, t.address, t.data_in, t.expected_data);
        end
    endtask

    task driver();
        Transaction t;

        while (gen_q.size() > 0) begin
            t = gen_q.pop_front();

            // WRITE transaction
            mif.cb.address <= t.address;
            mif.cb.data_in <= t.data_in;
            mif.cb.write   <= 1;
            mif.cb.read    <= 0;
            @(mif.cb);

            mif.cb.write <= 0;
            @(mif.cb);

            // READ transaction
            mif.cb.address <= t.address;
            mif.cb.read    <= 1;
            mif.cb.write   <= 0;
            @(mif.cb);

            mif.cb.read <= 0;

            drv_q.push_back(t.copy());
        end
    endtask

    task monitor();
        Transaction t;

        repeat (10) begin
            wait (drv_q.size() > 0);
            t = drv_q.pop_front();

            @(mif.cb);
            t.data_out = mif.cb.data_out;
            t.print_data_out();

            mon_q.push_back(t.copy());
        end
    endtask

    task checker();
        Transaction t;

        repeat (10) begin
            wait (mon_q.size() > 0);
            t = mon_q.pop_front();
            t.check();
        end

        Transaction::print_error();
    endtask

    initial begin
        mif.cb.write <= 0;
        mif.cb.read  <= 0;
        mif.cb.address <= 0;
        mif.cb.data_in <= 0;

        @(mif.cb);

	gen_transaction();

        fork
            driver();
            monitor();
            checker();
        join

        #100;
        $finish;
    end

endprogram
