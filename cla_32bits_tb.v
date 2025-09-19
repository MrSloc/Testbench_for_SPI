`timescale 1ns/1ns

// 用于32位超前进位加法器 (CLA) 的测试平台
module cla_32bits_tb;
    // 参数定义，用于设置加法器的位宽 
    parameter WIDTH = 32;

    // 测试平台的变量
    // 使用 'reg' 类型作为待测设计(DUT)的输入激励 
    reg [WIDTH-1:0] a;
    reg [WIDTH-1:0] b;
    reg ci;
    
    // 使用 'wire' 类型接收DUT的输出 
    wire [WIDTH-1:0] s;
    wire co;
    
    // 用于验证的变量
    // 黄金模型的计算结果，使用 'wire' 接收 'assign' 语句的输出 
    wire [WIDTH:0] result;
    integer i, j, k;
    
    // 标志位，用于追踪测试是通过还是失败 
    reg flag;

    // 黄金模型：使用Verilog内建的加法运算符作为正确性的参照 
    assign result = a + b + ci;

    // 实例化待测设计(DUT - cla_32bits)
    // 将SystemVerilog的(.*)隐式连接改为Verilog的命名端口显式连接 
    cla_32bits u_cla_32bits (
        .a(a), 
        .b(b), 
        .ci(ci), 
        .s(s), 
        .co(co)
    );

    // 激励和检查模块
    initial begin
        $display("Verifying %d bits CLA...", WIDTH); 
        
        // 初始化输入信号
        a = 32'h0; 
        b = 32'h0; 
        ci = 1'b0; 
        flag = 1'b1; // 初始化标志位为1 (通过) 

        // 为了在合理的时间内完成仿真，仅测试所有可能输入的一个子集
        for (i = 0; i < 1024; i = i + 1) begin 
            for (j = 0; j < 1024; j = j + 1) begin 
                for (k = 0; k < 2; k = k + 1) begin 
                    #1; // 延时1ns，等待组合逻辑电路稳定
      
                    // 使用 'if' 语句替代 SystemVerilog 的 'assert' 来检查输出结果 
                    if (co !== result[WIDTH] || s !== result[WIDTH-1:0]) begin
                        flag = 1'b0; // 如果结果不匹配，将标志位设为0 (失败) 
                        // 显示更清晰的错误信息 
                        $display("ERROR: Mismatch found at time %t", $time);
                        $display("  Inputs:  a = %h, b = %h, ci = %b", a, b, ci);
                        $display("  DUT Out: s = %h, co = %b", s, co);
                        $display("  Expected:s = %h, co = %b", result[WIDTH-1:0], result[WIDTH]); 
                    end
                    ci = ~ci; // 翻转进位输入，用于下一次迭代 
                end
                b = b + 1; 
            end
            a = a + 1; 
        end
        
        // 根据最终的标志位状态，报告测试结果
        if (flag)
            $display("PASSED"); 
        else
            $display("FAILED"); 
        
        $finish; // 结束仿真
    end

    // 生成波形文件以便后续查看
    initial begin
        $dumpfile("cla_32bits.vcd");
        $dumpvars(0, cla_32bits_tb);
    end

endmodule