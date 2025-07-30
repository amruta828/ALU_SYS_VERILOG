class alu_environment;

  virtual alu_interface m_vif;
  virtual alu_interface d_vif;
  virtual alu_interface r_vif;

  mailbox #(alu_transaction) mbx_gd;
  mailbox #(alu_transaction) mbx_dr;
  mailbox #(alu_transaction) mbx_ms;
  mailbox #(alu_transaction) mbx_rs;

  alu_generator gen;
  alu_driver dri;
  alu_monitor mon;
  alu_reference refe;
  alu_scoreboard sco;

  function new( virtual alu_interface m_viff,virtual alu_interface d_viff,virtual alu_interface r_viff);

    m_vif=m_viff;
    d_vif=d_viff;
     r_vif=r_viff;
    mbx_gd=new();
    mbx_dr=new();
    mbx_ms=new();
    mbx_rs=new();

  endfunction

  task build();
    begin
    gen = new(mbx_gd);
    dri = new(mbx_gd,mbx_dr,d_vif);
    mon = new(mbx_ms,m_vif);
    refe= new(mbx_dr,mbx_rs,r_vif);
    sco = new(mbx_rs,mbx_ms);
    end

  endtask

  task start();
    fork
      gen.start();
      dri.start();
      mon.start();
      refe.start();
      sco.start();
    join

sco.compare_report();
  endtask

endclass
