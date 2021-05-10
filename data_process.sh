#!/bin/bash
awk '
BEGIN {
    in_  = 0;
    out_ = 0;
}

{
    split($1, a, ",");
    in_  += a[1];
    out_ += a[2];
}

function output(data) {
	unit[0] = "B";
	unit[1] = "KB";
	unit[2] = "MB";
	unit[3] = "GB";
	unit[4] = "TB";
	unit[5] = "PB";
	unit[6] = "STOP";

	u = 0;
	for(i = 1; unit[i] != "STOP" && data >= 1024; i++){
	    u = i;
        data /= 1024;
	}
    printf "%.1f %s", data, unit[u]
}
END {
    printf "Incoming Size: "; output(in_); printf ", "
    printf "Outgoing Size: "; output(out_);
}
'
