#! perl 

use File::Find;

find(\&wanted, $ENV{PWD});

sub wanted {
    my $source = my $filename = $File::Find::name;
    return unless $filename =~ 'py$';
    return if $source =~ /__init/;
    return if $source =~ m-./tests-; 

    $filename =~ s-^$ENV{PWD}/--;
    (my $import = $filename) =~ s/\.py$//;
    $import =~ s-/-.-;
    $filename =~ s-/-_-g;
    $filename = "$ENV{PWD}/tests/$filename";
    ($classname = $source) =~ s=(?:^$ENV{PWD})?[-/](.)=\U$1=g; 
    $classname =~ s/.py$// or return;

    -e "$filename" and next; 
    print "From $source to $filename into $classname\n";
    open my $out, ">", $filename; 
    #open my $out, ">&STDOUT";
    print $out qq(""" Tests against $import  """\n), 
        "import unittest\n\nimport $import\n\n",
        "class ${classname}Test(unittest.TestCase):\n",
        '    """ """', "\n",
        "    def test_something(self):\n",
        '        """ """', "\n",
        "        pass\n",
        ;
    print "Generated $filename\n" 
}

