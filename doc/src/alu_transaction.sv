`include "defines.sv"

class alu_transaction;
  rand bit [1:0]INP_VALID;
  rand bit [`M-1:0]CMD;
  rand bit CE,CIN,MODE;
  rand bit [`N-1:0]OPA,OPB;

  bit ERR,OFLOW,COUT,E,G,L;
  bit [`N:0] RES;

  constraint c1{ if(MODE==1) CMD inside {[0:10]};
                else CMD inside {[0:10]};
               }
  constraint c2{CE==1;
               }

  virtual function alu_transaction copy();
  copy = new();
  copy.INP_VALID=this.INP_VALID;
  copy.CMD=this.CMD;
  copy.CE=this.CE;
  copy.CIN=this.CIN;
  copy.MODE=this.MODE;
  copy.OPA=this.OPA;
  copy.OPB=this.OPB;
  return copy;
  endfunction
endclass

class alu_transaction_1 extends alu_transaction;
        constraint mode {MODE == 0;}
        constraint cmd {CMD inside {[6:11]};}
       // constraint inp_valid {INP_VALID == 2'b11;}

        virtual function alu_transaction_1 copy();
                copy = new();
                copy.CE = this.CE;
                copy.MODE = this.MODE;
                copy.CMD = this.CMD;
                copy.INP_VALID = this.INP_VALID;
                copy.OPA = this.OPA;
                copy.OPB = this.OPB;
                copy.CIN = this.CIN;
                return copy;
        endfunction
endclass

//arithmetic operation with single inputs
class alu_transaction_2 extends alu_transaction;
        constraint mode {MODE == 1;}
        constraint cmd {CMD inside {[4:7]};}
        constraint inp_valid{INP_VALID == 2'b11;}

        virtual function alu_transaction_2 copy();
                copy = new();
                copy.CE = this.CE;
                copy.MODE = this.MODE;
                copy.CMD = this.CMD;
                copy.INP_VALID = this.INP_VALID;
                copy.OPA = this.OPA;
                copy.OPB = this.OPB;
                copy.CIN = this.CIN;
                return copy;
endfunction
endclass

//logical operation with two operands
class alu_transaction_3 extends alu_transaction;
        constraint mode{MODE == 0;}
        constraint cmd {CMD inside {[0:6],12,13};}
        constraint inp_valid {INP_VALID == 2'b11;}

        virtual function alu_transaction_3 copy();
                copy = new();
                copy.CE = this.CE;
                copy.MODE = this.MODE;
                copy.CMD = this.CMD;
                copy.INP_VALID = this.INP_VALID;
                copy.OPA = this.OPA;
                copy.OPB = this.OPB;
                copy.CIN = this.CIN;
                return copy;
        endfunction
endclass

//arithmetic operation with two operands
class alu_transaction_4 extends alu_transaction;
        constraint mode{MODE == 1;}
        constraint cmd {CMD inside {[0:3], [8:10]};}
        constraint inp_valid {INP_VALID == 2'b11;}

        virtual function alu_transaction_4 copy();
                copy = new();
                  copy.CE = this.CE;
                copy.MODE = this.MODE;
                copy.CMD = this.CMD;
                copy.INP_VALID = this.INP_VALID;
                copy.OPA = this.OPA;
                copy.OPB = this.OPB;
                copy.CIN = this.CIN;
                return copy;
        endfunction
endclass
