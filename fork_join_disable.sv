// Task A. This task runs for 50us
task sub_run_a();
  while ($time < 50us) begin
    #1us;
    $display("sub_run_a(): ping at time %d", $time);
  end
endtask : sub_run_a

// Task B. This task runs for 5us
task sub_run_b();
  #5us;
  $display("sub_run_b() finished");
endtask : sub_run_b

// Task C. This task runs for 10us
task sub_run_c();
  #10us;
  $display("sub_run_c() finished");
endtask : sub_run_c

// You have the following task that forks off the tasks above.
// 1) assuming we start at time 0, how much time elapses before we reach "disable fork"
// 2) when we execute the "disable fork", which tasks get killed?
task run();

  process p1;
  process p2;

  fork
  fork
    sub_run_a();
  join_none
  join

  	fork
      begin
        p1=process::self();
  	  sub_run_b();
      end
      begin
        p2 = process::self();
   	 sub_run_c();
      end
  	join_any

  if (p1.status != process::FINISHED)
    p1.kill();
  if (p2.status != process::FINISHED)
    p2.kill();

  $display("time before disable fork: %d", $time);

  //disable fork;  this will kill the all child processes.

  #10us;

endtask : run

module top;
  initial begin
    run();
  end
endmodule



// 3) how do you prevent sub_run_a() task from getting killed in this scenario?
