/* Generated by Yosys 0.32+66 (git sha1 2f901a829, clang 14.0.0-1ubuntu1.1 -fPIC -Os) */

(* top =  1  *)
(* src = "blocking_caveat.v:1.1-8.10" *)
module blocking_caveat(a, b, c, d);
  wire _0_;
  (* src = "blocking_caveat.v:1.31-1.32" *)
  wire _1_;
  (* src = "blocking_caveat.v:1.41-1.42" *)
  wire _2_;
  (* src = "blocking_caveat.v:1.52-1.53" *)
  wire _3_;
  (* src = "blocking_caveat.v:1.66-1.67" *)
  wire _4_;
  (* src = "blocking_caveat.v:1.31-1.32" *)
  input a;
  wire a;
  (* src = "blocking_caveat.v:1.41-1.42" *)
  input b;
  wire b;
  (* src = "blocking_caveat.v:1.52-1.53" *)
  input c;
  wire c;
  (* src = "blocking_caveat.v:1.66-1.67" *)
  output d;
  wire d;
  sky130_fd_sc_hd__o21a_1 _5_ (
    .A1(_2_),
    .A2(_1_),
    .B1(_3_),
    .X(_4_)
  );
  assign _2_ = b;
  assign _1_ = a;
  assign _3_ = c;
  assign d = _4_;
endmodule
