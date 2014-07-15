#!/usr/bin/perl
# pkg-comp xml formatter.

use XML::Parser;

my @formats=qw(deb rpm tgz slp pkg);

sub _handle_char {
	my $val=$_[1];
	my $tag=$tagstack[-1];

	if ($tag eq 'title') {
		$title.=$val;
	}
	elsif ($tag eq 'intro') {
		$intro.=$val;
	}
	elsif ($tag eq 'copyright') {
		$copyright.=$val;
	}
	elsif ($tag eq 'todo') {
		$todo[$#todo].=$val;
	}
	elsif ($tag eq 'item') {
		push @items, $name;
	}
	elsif ($tag eq 'description') {
		if ($tagstack[-2] eq 'group') {
			$groupdesc[$#groups].=$val;
		}
		elsif ($tagstack[-2] eq 'item') {
			$itemdesc[$#groups][$#{$items[$#groups]}].=$val;
		}
		else {
			die "Description illegally nested in $tagstack[-2] tag"; 
		}
	}
	elsif (grep {$tag eq $_} @formats) {
		$data[$#groups][$#{$items[$#groups]}]{$tag}.=$val;
	}
	elsif ($tag eq 'p') {
		$paragraph.=$val;
	}
	elsif ($tag eq 'a') {
		$link.=$val;
	}
	elsif ($tag eq 'footnote') {
		$footnote.=$val;
	}
	elsif ($tag eq 'command') {
		$command.=$val;
	}
	elsif ($tag ne 'pkgcomp' && $tag ne 'group') {
		die "Unknown tag '$tag'";
	}
}

sub _handle_start {
	shift;
	push @tagstack,lc(shift);
	my %attrs=@_;
	
	if ($tagstack[-1] eq 'a') {
		$href=$attrs{href};
		$link='';
	}
	elsif ($tagstack[-1] eq 'group') {
		push @groups, $attrs{name};
	}
	elsif ($tagstack[-1] eq 'item') {
		$items[$#groups][$#{$items[$#groups]}+1] = $attrs{name};
	}
	elsif ($tagstack[-1] eq 'todo') {
		push @todo, '';
	}
	elsif ($tagstack[-1] eq 'p') {
		$paragraph='';
	}
	elsif ($tagstack[-1] eq 'footnote') {
		$footnote='';
	}
	elsif ($tagstack[-1] eq 'command') {
		$command='';
	}
}

sub _handle_end {
	my $old=pop(@tagstack);
	if ($old eq 'p') {
		_handle_char(undef, "<p>$paragraph</p>\n");
	}
	elsif ($old eq 'a') {
		_handle_char(undef, "<a href=\"$href\">$link</a>");
	}
	elsif ($old eq 'footnote') {
		$footnotes{$footnote}=++$num_footnotes unless exists $footnotes{$footnote};
		my $footnum=$footnotes{$footnote};
		_handle_char(undef, "[<a name=\"footref".$footnum.
			"\" href=\"#foot".$footnum."\">".
			$footnum."</a>]");
	}
	elsif ($old eq 'command') {
		_handle_char(undef, "<i>$command</i>");
	}
}

my $parser=XML::Parser->new(Handlers => {Start => \&_handle_start,
					 End   => \&_handle_end,
					 Char  => \&_handle_char});
$parser->parsefile("pkg-comp.xml");

# Now output the page.

# Page header.
print "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\">
<html>
<head>
<title>$title</title>
</head>
<body>
<h1>$title</h1>
$intro
";

# The table.
print "
<h2>Package format comparison table.</h2>
<table border=1>
<tr><th>feature</th>";
print "<th>$_</th>" foreach @formats;
print "</tr>";
foreach $group (0..$#groups) {
	print "<tr><th colspan=".(scalar(@formats)+1)."><a name=\"grouptab$group\" href=\"#groupdesc$group\">$groups[$group]</a></th></tr>\n";
	foreach $item (0..$#{$items[$group]}) {
		print "<tr><td><a name=\"itemtab$group+$item\" href=\"#itemdesc$group+$item\">$items[$group][$item]</a></td>";
		foreach $tag (@formats) {
			print "<td>$data[$group][$item]{$tag}</td>"
		}
		print "</tr>\n";
	}
}
print "</table>\n";

# Explanations of everything on the table.
print "<h2>What is compared.</h2>\n";
foreach $group (0..$#groups) {
	print "<h3><a name=\"groupdesc$group\" href=\"#grouptab$group\">$groups[$group].</a></h3>\n$groupdesc[$group]\n<dl>\n";
	foreach $item (0..$#{$items[$group]}) {
		print "<dt><a name=\"itemdesc$group+$item\" href=\"#itemtab$group+$item\">$items[$group][$item]</a></dt>\n";
		print "<dd>$itemdesc[$group][$item]</dd>\n";
	}
	print "</dl>\n";
}

# Todo.
print "<h2>Todo.</h2>\n<ul>\n<li>".join("\n<li>", @todo)."</ul>\n"
	if @todo;

# Footnotes.
if (%footnotes) {
	print "<h2>Footnotes.</h2>\n";
	foreach $footnote (sort { $footnotes{$a} <=> $footnotes{$b} } keys %footnotes) {
		my $num = $footnotes{$footnote};
		print "<a href=\"#footref$num\" name=\"foot$num\">$num.</a> ".
		      "$footnote<br>\n";
	}
}

# Page footer.
print "
<hr>
$copyright
<hr>Last modified at ".localtime(time - -M "pkg-comp.xml").";
generated from <a href=pkg-comp.xml>this source XML</a> by 
<a href=pkg-comp.pl>this program</a>.
</body>
</html>
";

