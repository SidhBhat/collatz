# _mode = 0 : collect only stop times
# _mode = 1 : collect data of the collatz series
function result = collaz_run(num, _mode)

	## process only int values
	if(!isinteger(num))
		printf("number has to of integral type.\n");;
		result.X = uint64(0);
		result.Y = uint64(0);
		result.stop_time = uint64(0);
		result.total_stop_time = uint64(0);
		result.error = uint64(1);
		return;
	endif

	## stop_times
	result.stop_time       = int32(0);
	result.total_stop_time = int32(0);
	result.stop_time_flag  = 0;
	# the series
	n      = int32(0);
	number = num = uint64(num);
	if (_mode)
		while(num != uint64(1))
			result.X(n+1)=n;
			result.Y(n+1)=num;
			if(num < number && !result.stop_time_flag)
				result.stop_time_flag = 1;
				result.stop_time      = n;
			endif
			num = collaz(num);
			n++;
		endwhile
		result.X(n+1) = n;
		result.Y(n+1) = num;
	else
		while(num != uint64(1))
			if(num < number && !result.stop_time_flag)
				result.stop_time_flag = 1;
				result.stop_time      = n;
			endif
			num = collaz(num);
			n++;
		endwhile
		result.X = uint64(0);
		result.Y = uint64(0);
	endif
	result.total_stop_time = n;

endfunction
