// Interview Question
// Fill in the code below

class my_sequencer;
  int id;
endclass : my_sequencer

class my_sequence;
  task start (my_sequencer seqr);
    int delay = $urandom_range(1,10);
    $display("time: %d, starting sequence on sequencer with id:%d", $time, seqr.id);
    #(delay * 1us);
    $display("time: %d, finishing sequence on sequencer with id:%d", $time, seqr.id);
  endtask : start
endclass : my_sequence


module top;
  initial begin
    process p[];
    my_sequencer seqr;
    my_sequencer seqr_q[$];
    static int num_of_seqr = $urandom_range(3,5);

    for (int i = 0; i < num_of_seqr; i++) begin
      seqr = new;
      seqr.id = i;
      seqr_q.push_back(seqr);
    end

    // write SV code to start a new instance of my_sequence on each of the sequencers in seqr_q
    // conditions:
    // 1) all sequences must start simultaneously (at time 0)
    // 2) code must wait until all sequences are finished before reaching "end" of initial block

    $display("num of sequencers = %d", num_of_seqr);

    p = new[num_of_seqr];

    for(int i=0;i<num_of_seqr;i++) begin
      automatic int si = i;
      fork
        begin
          my_sequence myseq = new();
          p[si] = process::self();
          myseq.start(seqr_q[si]);
        end
      join_none
    end

	wait fork ;//wait for all child threads to finish

    $display("time: %d, end reached", $time);
  end
endmodule
