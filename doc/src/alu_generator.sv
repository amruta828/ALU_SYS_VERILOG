`include "defines.sv"
class alu_generator;
  alu_transaction t1;
  mailbox #(alu_transaction) m_gd;

  function new(mailbox #(alu_transaction) mbx_gd);
    t1=new();
    m_gd=mbx_gd;
  endfunction

  task start();
    for(int i=0;i<`no_of_transactions;i++)
      begin
        t1.randomize();
        m_gd.put(t1.copy);
        $display("GENERATOR RANDOMIZED VALUES AT TIME=[%0t] ,INP_VALID =%b,CMD=%b,CE=%b,CIN=%b,MODE=%b,OPA=%d,OPB=%d",$time,t1.INP_VALID,t1.CMD,t1.CE,t1.CIN,t1.MODE,t1.OPA,t1.OPB);

      end
     $display("___________________________");
  endtask
endclass
