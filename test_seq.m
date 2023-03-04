# not function file
1;

clear;

##----------------Configuration--------------##
# The number to test the collatz conjecture on
num = 5000;


# Setting this to 1, collects data only for one sequence where
# the number is set by num.
# For 0, the programs collects data for every series between 1 and num.
single_run_flag = 0;
## run mode:
# 0 : collect and plot stop time data
# 1 : collect and plot series data


## only applies when single_run_flag = 1
show_animate      = 0;   # write the sequence on the output (terminal) before plotting

## only applies when single_run_flag = 0
## sequential run: enabling this option requirs a lot of memory
plot_collatz_data = 0;  # collect series data along with stop time data

## -----------START PROGRAM------------------##
# DO NOT EDIT ANYTHING BELOW THIS!!!

#initialise
t_interval = 0.1; # pause interval for writing to output
num = uint64(num);

if(single_run_flag)
	mode_  = 1; ## colect series data
	result = collatz_run(num, mode_);
	if(show_animate)
		if(!t_interval)
			disp("Error: t_interval must be non-zero");
			exit;
		endif
		for n = result.X
			printf("a(%d) = %d\r", n, result.Y(n+1));
			pause(t_interval);
			winc = terminal_size()(2);
			for m = 1:1:winc
				printf(" "); # clear extra charaters
			endfor
			printf("\r");        # return curser to starting position
		endfor
		printf("a(%d) = %d\n", n, result.Y(n+1));

		clear n m winc;
	endif
	printf("Stopping Time:\t\t%d\n", result.stop_time);
	printf("Total stopping time:\t%d\n", result.total_stop_time);

	close all;
	figure;
	clf;

	plot(result.X, result.Y,"-k","markersize",10);
	legend("a(n)");
	title(sprintf("Collaz Conjecture\nStopping time:%d\ntotal stop time:%d",
			result.stop_time, result.total_stop_time),"fontsize", 10);
	grid("on");
	xlabel("n");
	ylabel("a(n)");
else

	close all;
	figure(1);
	clf;

	mode_ = 0; # do not collect series data
	if(plot_collatz_data)
		hold;
		mode_ = 1; ## colect series data
	endif
	## stop time data series forward declaration
	n_values         = 1:1:num;
	stop_times       = 0;
	total_stop_times = 0;

	for number = n_values
		n = uint64(number);
		result = collatz_run(n,mode_);

		stop_times(n)       = result.stop_time;
		total_stop_times(n) = result.total_stop_time;

		if(plot_collatz_data)
			## plot series data
			plot(result.X, result.Y,"-k","markersize",5);
		endif
	endfor
	clear result;

	if(plot_collatz_data)
		title(sprintf("Collaz Conjecture\na(n) vs n for n=1,2,3..%d",num), "fontsize", 10);
		grid("on");
		xlabel("n");
		ylabel("a(n)");

		figure(2);
		clf;
	endif

	subplot (2, 1, 1);

	plot (n_values, stop_times, "*k", "markersize",5);
	title("Stop time vs n", "fontsize", 10);
	grid("on");
	xlabel("n");
	ylabel("stop time");

	subplot (2, 1, 2);

	plot (n_values, total_stop_times, "*k", "markersize",5);
	title("Total stop time vs n", "fontsize", 10);
	grid("on");
	xlabel("n");
	ylabel("total stop time");

endif
