`include "defines.sv"
class alu_scoreboard;
  mailbox #(alu_transaction) m_rs;
  mailbox #(alu_transaction) m_ms;
  alu_transaction rs,ms;
  int MATCH, MISMATCH;

  function new( mailbox #(alu_transaction) mbx_rs,
               mailbox #(alu_transaction) mbx_ms);
    m_rs=mbx_rs;
    m_ms=mbx_ms;
    rs=new();
    ms=new();
  endfunction


  task start();
    for(int i=0;i<`no_of_transactions;i++)
      begin
      begin
        m_rs.get(rs);

        $display("%0t TO SCOREBOARD FROM REFERENCE DATA - ERR=%d,COUT=%d,OFLOW=%d,E=%d,G=%d,L=%d,RES=%d,RES=%b",$time,rs.ERR,rs.COUT,rs.OFLOW,rs.E,rs.G,rs.L,rs.RES,rs.RES);
     // end
   // begin
      m_ms.get(ms);

      $display ("%0t TO SCOREBOARD FROM MONITOR DATA - ERR=%d,COUT=%d,OFLOW=%d,E=%d,G=%d,L=%d,RES=%d,RES=%b",$time,ms.ERR,ms.COUT,ms.OFLOW,ms.E,ms.G,ms.L,ms.RES,ms.RES);

    end
        compare_report();
      end
  endtask

  task compare_report();
    if( rs.ERR == ms.ERR && rs.COUT == ms.COUT && rs.OFLOW == ms.OFLOW && rs.E == ms.E && rs.G == ms.G && rs.L ==ms.L && rs.RES == ms.RES)
      begin
        MATCH++;
        $display("MATCH SUCCESSFUL - %0d",MATCH);

        $display("___________________________");end
    else begin
      MISMATCH++;
      $display("MATCH UNSUCCESSFUL-%0d",MISMATCH);
      $display("___________________________");end
  endtask


endclass
