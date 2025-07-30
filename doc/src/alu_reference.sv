`include "defines.sv"

class alu_reference;
  mailbox #(alu_transaction) m_dr;
  mailbox #(alu_transaction) m_rs;
  alu_transaction t4;
  virtual alu_interface.REF v1;
  bit got_valid;
  function new(mailbox #(alu_transaction) mbx_dr,
               mailbox #(alu_transaction) mbx_rs,
               virtual alu_interface r_vif);
    m_dr = mbx_dr;
    m_rs = mbx_rs;
    v1 = r_vif;
  endfunction

  task start();
    for (int i = 0; i < `no_of_transactions; i++) begin
      t4 = new();
      m_dr.get(t4);
      repeat(1) @(v1.ref_cb);

      if (v1.ref_cb.RST) begin
        t4.RES   = 1'bz;
        t4.OFLOW = 1'bz;
        t4.COUT  = 1'bz;
        t4.G     = 1'bz;
        t4.L     = 1'bz;
        t4.E     = 1'bz;
        t4.ERR   = 1'bz;
      end
      else if (t4.CE) begin


          got_valid = 0;
           if (t4.INP_VALID != 2'b11)
             begin
        for (int j = 0; j < 16; j++)
          begin
          if (t4.INP_VALID == 2'b11) begin
            got_valid = 1;
            break;
          end
        end
          end

//       if (!got_valid) begin
//         t4.ERR = 1;

        //end
        if (t4.MODE) begin
          case (t4.CMD)
            `ADD:      begin repeat(1)@(v1.ref_cb); t4.RES = t4.OPA + t4.OPB; t4.COUT = t4.RES[`N]; end
            `SUB:      begin repeat(1)@(v1.ref_cb); t4.RES = t4.OPA - t4.OPB; t4.OFLOW = (t4.OPA < t4.OPB); end
            `ADD_CIN:  begin repeat(1)@(v1.ref_cb); t4.RES = t4.OPA + t4.OPB + t4.CIN; t4.COUT = t4.RES[`N]; end
            `SUB_CIN:  begin repeat(1)@(v1.ref_cb); t4.RES = t4.OPA - t4.OPB - t4.CIN; t4.OFLOW = (t4.OPA < t4.OPB); end
            `CMP:      begin repeat(1)@(v1.ref_cb); t4.E = (t4.OPA == t4.OPB); t4.G = (t4.OPA > t4.OPB); t4.L = (t4.OPA < t4.OPB); end
            `INC_MUL:  begin repeat(2)@(v1.ref_cb); t4.RES = (t4.OPA + 1) * (t4.OPB + 1); end
            `SHIFT_MUL:begin repeat(2)@(v1.ref_cb); t4.RES = (t4.OPA << 1) * t4.OPB; end
            `INC_A:    begin repeat(1)@(v1.ref_cb); t4.RES = t4.OPA + 1; end
            `DEC_A:    begin repeat(1)@(v1.ref_cb); t4.RES = t4.OPA - 1; end
            `INC_B:    begin repeat(1)@(v1.ref_cb); t4.RES = t4.OPB + 1; end
            `DEC_B:    begin repeat(1)@(v1.ref_cb); t4.RES = t4.OPB - 1; end
            default:   t4.ERR = 1;
          endcase
        end else begin
          case (t4.CMD)
            `AND:     begin repeat(1)@(v1.ref_cb); t4.RES = {1'b0, t4.OPA & t4.OPB}; end
            `NAND:    begin repeat(1)@(v1.ref_cb); t4.RES = {1'b0, ~(t4.OPA & t4.OPB)}; end
            `OR:      begin repeat(1)@(v1.ref_cb); t4.RES = {1'b0, t4.OPA | t4.OPB}; end
            `NOR:     begin repeat(1)@(v1.ref_cb); t4.RES = {1'b0, ~(t4.OPA | t4.OPB)}; end
            `XOR:     begin repeat(1)@(v1.ref_cb); t4.RES = {1'b0, t4.OPA ^ t4.OPB}; end
            `XNOR:    begin repeat(1)@(v1.ref_cb); t4.RES = {1'b0, ~(t4.OPA ^ t4.OPB)}; end
               `ROL_A_B: begin
              repeat(1)@(v1.ref_cb);
              if (t4.OPB >= `N) t4.ERR = 1;
              else t4.RES = {1'b0, (t4.OPA << t4.OPB) | (t4.OPA >> (`N - t4.OPB))};
            end
            `ROR_A_B: begin
              repeat(1)@(v1.ref_cb);
              if (t4.OPB >= `N) t4.ERR = 1;
              else t4.RES = {1'b0, (t4.OPA >> t4.OPB) | (t4.OPA << (`N - t4.OPB))};
            end
            `NOT_A:   begin repeat(1)@(v1.ref_cb); t4.RES = {1'b0, ~t4.OPA}; end
            `NOT_B:   begin repeat(1)@(v1.ref_cb); t4.RES = {1'b0, ~t4.OPB}; end
            `SHL1_A:  begin repeat(1)@(v1.ref_cb); t4.RES = {1'b0, t4.OPA << 1}; end
            `SHR1_A:  begin repeat(1)@(v1.ref_cb); t4.RES = {1'b0, t4.OPA >> 1}; end
            `SHL1_B:  begin repeat(1)@(v1.ref_cb); t4.RES = {1'b0, t4.OPB << 1}; end
            `SHR1_B:  begin repeat(1)@(v1.ref_cb); t4.RES = {1'b0, t4.OPB >> 1}; end
            default:  t4.ERR = 1;
          endcase
        end
      end

      m_rs.put(t4);
    end

  endtask
endclass
