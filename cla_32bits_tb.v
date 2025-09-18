{\rtf1\ansi\ansicpg1252\cocoartf2865
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 module cla_32bits_tb;\
    parameter WIDTH = 6'd32;\
\
    logic [WIDTH-1:0] a;\
    logic [WIDTH-1:0] b;\
    logic ci;\
    logic [WIDTH-1:0] s;\
    logic co;\
\
    // For verification\
    logic [WIDTH:0] result;\
    integer i;\
    integer j;\
    integer k;\
    logic flag;\
\
    assign result = a + b + ci;\
\
    cla_32bits u_cla_32bits(.*);\
\
    initial begin\
        $display("Verifying %d bits CLA...", WIDTH);\
        a = 'b0;\
        b = 'b0;\
        ci = 1'b0;\
        flag = 1'b1;\
\
        // Spend too much time if you set 2**WIDTH\
        for (i = 0; i < 2**10; i++) begin\
            for (j = 0; j < 2**10; j++) begin\
                for (k = 0; k < 2; k++) begin\
                    #1\
                    assert (co == result[WIDTH] && s == result[WIDTH-1:0]) else begin\
                        flag = 1'b0;\
                        $error("Error: %d'h%h + %d'h%h + 1'h%h = %d'h%h + 1'h%h, which should be: %d'h%h + 1'h%h", \
                            WIDTH, a, WIDTH, b, ci,\
                            WIDTH, s, co,\
                            WIDTH, result[WIDTH-1:0], result[WIDTH]\
                        );\
                    end\
                    ci = !ci;\
                end\
                b = b + 1'b1;\
            end\
            a = a + 1'b1;\
        end\
        \
        if (flag)\
            $display("PASSED");\
        else\
            $display("FAILED");\
        \
        $finish;\
    end\
\
endmodule}