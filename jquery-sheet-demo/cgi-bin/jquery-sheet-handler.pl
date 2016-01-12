#!C:/Perl64/bin/perl.exe
# Made by Vladimir Ivashchenko <hazard@hazard.maks.net> http://www.hazard.maks.net. Free to use and redistribute without restriction.

use Data::Dumper;
use CGI qw(:cgi-lib :standard);
use DBI;
use strict;

#### CONFIGURATION PARAMETERS #####

our $dsn = "DBI:mysql:dbname=test;host=localhost";	
our $db_user = "root";
our $db_pwd = "";

my $DEBUG = 0;

###################################
	
my $dbh = DBI->connect($dsn, $db_user, $db_pwd,
          { RaiseError => 0, AutoCommit => 1, PrintError => $DEBUG }) 
          || die "Could not connect to $dsn";

our %in;
	
&ReadParse(%in); 

print header;
		
print STDERR "jquery-sheet-handler form data: ".Dumper(\%in) if $DEBUG;

if (param('cmd') eq 'save') {
    exit(1) unless $in{'sheet_name'};

    $dbh->do("REPLACE INTO jqs_data VALUES (now(), ?, ?)", undef, $in{'sheet_name'}, $in{'sheet_value'});

    if ($DBI::errstr) {
	print $DBI::errstr."\n";
	warn $DBI::errstr if $DEBUG;
	exit(1);
    };

    print "Data saved.";
};

if (param('cmd') eq "get") {

    exit(1) unless $in{'sheet_name'};

    my $data=($dbh->selectrow_array("SELECT sheet_value FROM jqs_data WHERE sheet_name=?", undef, $in{'sheet_name'}))[0];

    if ($data eq "") {
    	# If this is a new sheet, initialize with a default sheet template
	$data='<?xml version="1.0" encoding="UTF-8"?><spreadsheets xmlns="http://www.w3.org/1999/xhtml"><spreadsheet title=""><rows><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row><row height="18"><columns><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column><column></column></columns></row></rows><metadata><widths><width>120</width><width>120</width><width>120</width><width>120</width><width>120</width><width>120</width><width>120</width><width>120</width><width>120</width></widths></metadata></spreadsheet></spreadsheets>';
    };

    print $data;
    print STDERR "jquery-sheet-handler obtained spreadsheet ".$in{'sheet_name'}." value: $data\n" if $DEBUG;
};

