function a = collaz(val = uint64(1))
	if(!isinteger(val))
		printf("number has to of integral type.\n");
		a = 0;
		return;
	endif
	if(mod(val, 2))
		a = uint64(3*val + 1);
	else
		a = uint64(bitshift(val, -1));
	endif
	return;
endfunction
