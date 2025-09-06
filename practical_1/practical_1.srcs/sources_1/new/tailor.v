`timescale 1ns / 1ps

module tailor(

    );

function automatic real real_sin;
    input real x;
    
    real sing, x_loc, sum;
    
    begin
        sing = 1.0;
        x_loc = x;
        
        if (x < 0)
        begin
            x_loc = -x;
            sing = -1.0;
        end
        
        while (x_loc > 3.141592652 / 2.0)
        begin
            x_loc = x_loc - 3.141592652;
            sing = -1.0 * sing;
        end
        
        sum = x_loc - (x_loc ** 3)/6 + (x_loc**5)/120 - (x_loc**7)/5040 + (x_loc**9)/362880 - (x_loc**11)/39916800;
        real_sin = sing * sum;
    end

endfunction

function automatic real real_cos;
    input real x;
    
    real cosg, x_loc, sum;
    
    begin
        cosg = 1.0;
        x_loc = x;
        
        if (x < 0)
        begin
            x_loc = -x;
        end
        
        while (x_loc > 3.141592652)
        begin
            x_loc = x_loc - 3.141592652;
            cosg = -1.0 * cosg;
        end
        
        sum = 1 - (x_loc ** 2)/2 + (x_loc**4)/24 - (x_loc**6)/720 + (x_loc**8)/40320 - (x_loc**10)/3628880;
        real_cos = cosg * sum;
    end
endfunction

endmodule
