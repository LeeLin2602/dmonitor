#!/bin/bash

port=$1
data=$2
proc=$3

header="HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n"
html_start="<html><head><title>dmonitor panel</title><style><style>@media screen and (max-width: 520px) {\t.txt{font-size: 9pt;}}@media screen and (min-width: 521px) and (max-width: 720px) {\t.txt{font-size: 13pt;}}@media screen and (min-width: 721px) and (max-width: 1200px) {\t.txt{font-size: 21pt;}}@media screen and (min-width: 1201px) {\t.txt{font-size: 24pt;}}table{width: 100%; height:100%; magin:auto;} td{ vertical-align: middle; text-align: center; height: 2em; }</style></style></head><body>"
html_end="</body></html>"


hour="3600"
day="86400"
while true
do
    body=""
    body="${body}<h2>dmonitor</h2><br>"
    body="${body}<p>Overall: $(cat $data | tail -n +7 | $proc)</p>"
    body="${body}<p>Recent 1 Day: $(cat $data | tail -n +7 | tail -n $day | $proc)</p>"
    body="${body}<p>Recent 1 Hour: $(cat $data | tail -n +7 | tail -n $hour | $proc)</p>"
    body="${body}<br>"
    body="${body}<p>dmonitor: network traffic monitor powered by <a style='text-decoration:none;' href='https://github.com/LeeLin2602'>Lin Lee</a></p>"
	echo -e "${header}${html_start}<table><tr><td><div class='txt'>${body}</div></td></tr></table>${html_end}" | timeout 10 nc -l -p $1 -q 0 2>/dev/null >/dev/null
done
