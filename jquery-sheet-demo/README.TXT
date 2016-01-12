Sample jquery.sheet SQL save/load backend v1.0
Made by Vladimir Ivashchenko <vi@maks.net> http://www.hazard.maks.net, free to use and redistribute without restriction.

Requirements: web-server (e.g. Apache HTTP server), Perl with DBI::MySQL module, MySQL

Installation:

1) Put jQuery.sheet v3.1 into the same directory as html/spreadsheet.html
2) Web-server should be configured to execute cgi-bin/jquery-sheet-handler.pl as a Perl CGI script
3) Adjust html/spreadsheet.html if CGI script URL is not /cgi-bin/jquery-sheet-handler.pl
4) Create MySQL table as in sqlschema.txt. All sheets will be stored in this table in XML format
5) Adjust cgi-bin/jquery-sheet-handler.pl to use correct MySQL DSN, username, pass
6) Create your page, pass sheet name as "sheet_name" URL parameter to spreadsheet.html

Example of inclusion of a spreadsheet from within a page:

<iframe scrolling="no" style="overflow:hidden" height=500px width=100% src="spreadsheet.html?&sheet_name=test">

