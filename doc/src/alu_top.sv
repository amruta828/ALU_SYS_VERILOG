//`include "alu_test.sv"
`include "design.sv"
`include "alu_package.sv"
// `include "alu_interface.sv"
// `include "alu_environment.sv"
//import alu_pkg::*;
`include "alu_interface.sv"
module top();
  import alu_pkg::*;
  bit CLK,RST;
  parameter int N = 8;
  parameter int M = 4;
  alu_interface intf(CLK,RST);

    alu_test dut=new(intf.MON,intf.DRV,intf.REF);

  initial
    begin
      forever #10 CLK=~CLK;
    end

  initial begin
    @(posedge CLK)
    RST=1;
     repeat(1) @(posedge CLK)
      RST=0;

      end


    //dut instaintaion
  ALU_DESIGN  #(  .DW(N) , .CW(M) ) dut1(.INP_VALID(intf.INP_VALID),.OPA(intf.OPA),.OPB(intf.OPB),.CIN(intf.CIN),.CLK(intf.CLK),.RST(intf.RST),.CMD(intf.CMD),.CE(intf.CE),.MODE(intf.MODE),.COUT(intf.COUT),.OFLOW(intf.OFLOW),.RES(intf.RES),.G(intf.G),.E(intf.E),.L(intf.L),.ERR(intf.ERR));

    initial begin
    dut.run();
    $finish;
    end

//Calling the test's run task which starts the execution of the testbench architecture
  alu_test tb;

  test1 tb1;

  test2 tb2;

  test3 tb3;

  test4 tb4;

  test_regression tb_regression;
  // Create objects in initial block

  initial begin

    tb  = new(intrf.MON, intrf.DRV, intrf.REF);

    tb1 = new(intrf.MON, intrf.DRV, intrf.REF);


    tb2 = new(intrf.MON, intrf.DRV, intrf.REF);


    tb3 = new(intrf.MON, intrf.DRV, intrf.REF);


    tb4 = new(intrf.MON, intrf.DRV, intrf.REF);


    tb_regression = new(intrf.MON, intrf.DRV, intrf.REF);

    // Call one or more test run() tasks

    tb_regression.run();

   tb.run();

    tb1.run();

    tb2.run();

    tb3.run();

    tb4.run();

    #2000;

    $finish();

  end

endmodule
