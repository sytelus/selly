print "content-type=text/html\n";
print "\n";
foreach $EnvKey (keys(%ENV)) {
	print $EnvKey;
	print " = $ENV{$EnvKey}" ;
	print " <br>";
}