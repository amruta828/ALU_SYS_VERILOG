class alu_test;
  virtual alu_interface mon_viff;
  virtual alu_interface drv_viff;
  virtual alu_interface ref_viff;

  alu_environment env;

  function new( virtual alu_interface m_vif,virtual alu_interface d_vif,virtual alu_interface r_vif);

    mon_viff=m_vif;
    drv_viff=d_vif;
     ref_viff=r_vif;
    endfunction

  task run();
    env=new(mon_viff,drv_viff,ref_viff);
    env.build();
    env.start();
  endtask

endclass

class test1 extends alu_test;
alu_transaction_1 trans1;
  function new(virtual alu_interface mon_viff,virtual alu_interface drv_viff,virtual alu_interface ref_viff);

    super.new(mon_viff,drv_viff,ref_viff);
  endfunction
  task run();
    env=new(mon_viff,drv_viff,ref_viff);
    env.build;
    begin
    trans1 = new();
    env.gen.blueprint= trans1;
    end
    env.start;
  endtask
endclass

class test2 extends alu_test;
alu_transaction_2 trans2;
  function new(virtual alu_interface mon_viff,virtual alu_interface drv_viff,virtual alu_interface ref_viff);

    super.new(mon_viff,drv_viff,ref_viff);
  endfunction
  task run();
    $display("child test");
    env=new(mon_viff,drv_viff,ref_viff);
    env.build;
    begin
    trans2 = new();
    env.gen.blueprint= trans2;
    end
    env.start;
  endtask
endclass

class test3 extends alu_test;
alu_transaction_3 trans3;
  function new(virtual alu_interface mon_viff,virtual alu_interface drv_viff,virtual alu_interface ref_viff);

    super.new(mon_viff,drv_viff,ref_viff);
  endfunction
  task run();
    $display("child test");
    env=new(mon_viff,drv_viff,ref_viff);
    env.build;
    begin
    trans3 = new();
    env.gen.blueprint= trans3;
    end
    env.start;
  endtask
endclass

class test4 extends alu_test;
alu_transaction_4 trans4;
  function new(virtual alu_interface mon_viff,virtual alu_interface drv_viff,virtual alu_interface ref_viff);

    super.new(mon_viff,drv_viff,ref_viff);
  endfunction
  task run();
   // $display("child test");
    env=new(mon_viff,drv_viff,ref_viff);
    env.build;
    begin
    trans4 = new();
env.gen.blueprint= trans4;
    end
    env.start;
  endtask
endclass


class test_regression extends alu_test;
alu_transaction  trans;
alu_transaction_1 trans1;
alu_transaction_2 trans2;
alu_transaction_3 trans3;
alu_transaction_4 trans4;
  function new(virtual alu_if mon_viff,
               virtual alu_if drv_viff,
               virtual alu_if ref_viff);
    super.new(mon_viff,drv_viff,ref_viff);
  endfunction

  task run();
    //$display("child test");
    env=new(mon_viff,drv_viff,ref_viff);
    env.build;

    begin
    trans = new();
    env.gen.blueprint= trans;
    end
    env.start;

    begin
    trans1 = new();
    env.gen.blueprint= trans1;
    end
    env.start;

    begin
    trans2 = new();
    env.gen.blueprint= trans2;
    end
    env.start;

    begin
    trans3 = new();
    env.gen.blueprint= trans3;
    end
    env.start;

    begin
    trans4 = new();
    env.gen.blueprint= trans4;
    end
    env.start;


  endtask
endclass

