#!/usr/bin/perl
# All XML_OA orig files are converted with xslt Scripts to
# their NORM, DIPLO and txt Files
#


use strict 'vars';

my ($HOME,@dirs,$file,$cmd,$to_dir,$saxon_cmd,$from_dir,$to_file);
my (@sec_dirs,$document_dir,$target_dir);
my ($WAB,$WAB_XML,$saxoncmd,$type,$from_file,$xsl_file,$text_form);
my ($Debug);
our $count;
our $cmd_limit = 6;

$Debug = 1;
$count = 0;

print "get latest XML Files from BERGEN\n";

$WAB= "http://wab.uib.no/cost-a32_xml/";
$HOME = "../../../geheim/secure_nachlass/" ;
$saxoncmd = "java -jar ../saxon/saxon9he.jar";

if (!-d $HOME) {
print "ERROR !!! No ACCESS to $HOME! It doesn't exist \n";
exit;
}


## -s:CISWAB/Ms-153a_OA/orig/Ms-153a_OA.xml -xsl:wab2cis_normalized.xsl -o:Ms-153a_norm.xml

##Ms-141_OA.xml
@sec_dirs = (
"Ms-101_OA"
,"Ms-102_OA","Ms-103_OA","Ms-104_OA","Ms-105_OA",
"Ms-106_OA","Ms-107_OA","Ms-108_OA","Ms-109_OA",
"Ms-110_OA" ,
"Ms-111_OA","Ms-112_OA","Ms-113_OA","Ms-116_OA","Ms-117_OA","Ms-118_OA",
"Ms-119_OA","Ms-120_OA","Ms-121_OA","Ms-122_OA","Ms-123_OA","Ms-124_OA","Ms-125_OA",
"Ms-126_OA","Ms-127_OA","Ms-128_OA","Ms-129_OA","Ms-130_OA","Ms-131_OA","Ms-132_OA",
"Ms-133_OA","Ms-134_OA","Ms-135_OA","Ms-136_OA","Ms-137_OA","Ms-138_OA","Ms-139b_OA",
"Ms-140_OA","Ms-142_OA","Ms-143_OA","Ms-144_OA","Ms-145_OA","Ms-146_OA","Ms-147_OA",
"Ms-151_OA","Ms-156b_OA","Ms-157a_OA","Ms-157b_OA","Ms-158_OA","Ms-159_OA","Ms-160_OA",
"Ms-161_OA","Ms-162a_OA","Ms-162b_OA","Ms-163_OA","Ms-164_OA","Ms-165_OA","Ms-166_OA",
"Ms-167_OA","Ms-168_OA","Ms-169_OA","Ms-170_OA","Ms-171_OA","Ms-172_OA","Ms-173_OA",
"Ms-174_OA","Ms-175_OA","Ms-176_OA","Ms-177_OA","Ms-178a_OA","Ms-178b_OA","Ms-178c_OA",
"Ms-178d_OA","Ms-178e_OA","Ms-178f_OA","Ms-178g_OA","Ms-178h_OA","Ms-179_OA","Ms-180a_OA",
"Ms-180b_OA","Ms-181_OA","Ms-182_OA","Ms-183_OA","Ms-301_OA","Ts-202_OA","Ts-203_OA",
"Ts-204_OA","Ts-205_OA","Ts-206_OA","Ts-208_OA","Ts-209_OA","Ts-210_OA","Ts-211_OA",
"Ts-214a1_OA","Ts-214a2_OA","Ts-214b1_OA","Ts-214b2_OA","Ts-214c1_OA","Ts-214c2_OA",
"Ts-215a_OA","Ts-215b_OA","Ts-215c_OA","Ts-216_OA","Ts-217_OA","Ts-218_OA","Ts-219_OA",
"Ts-220_OA","Ts-221a_OA","Ts-221b_OA","Ts-222_OA","Ts-223_OA","Ts-224_OA","Ts-225_OA",
"Ts-226_OA","Ts-227a_OA","Ts-227b_OA","Ts-228_OA","Ts-229_OA","Ts-230a_OA","Ts-230b_OA",
"Ts-230c_OA","Ts-231_OA","Ts-232_OA","Ts-233a_OA","Ts-233b_OA","Ts-235_OA","Ts-236_OA",
"Ts-237_OA","Ts-238_OA","Ts-239_OA","Ts-240_OA","Ts-241a_OA","Ts-241b_OA","Ts-242a_OA",
"Ts-242b_OA","Ts-243_OA","Ts-244_OA","Ts-245_OA","Ts-246_OA","Ts-247_OA","Ts-248_OA",
"Ts-302_OA","Ts-303_OA","Ts-304_OA","Ts-305_OA","Ts-306_OA","Ts-309_OA"

);



@dirs = (
"Ms-114_OA",
"Ms-139a_OA",
"Ms-141_OA",
"Ms-149_OA",
"Ms-152_OA",
"Ms-153b_OA",
"Ms-155_OA",
"Ts-201a1_OA",
"Ts-207_OA",
"Ts-213_OA",
"Ms-115_OA",
"Ms-140,39v_OA",
"Ms-148_OA",
"Ms-150_OA",
"Ms-153a_OA",
"Ms-154_OA",
"Ms-156a_OA",
"Ts-201a2_OA",
"Ts-212_OA",
"Ts-310_OA"
);

foreach $file (@sec_dirs) {
    $document_dir = $HOME."/"."$file";
    $from_dir = $document_dir."/"."orig";
    $from_file = $from_dir."/"."$file".".xml";
    print "$file ::: From_file=$from_file \n" if ($Debug >= 2);
###    foreach $type ("norm","diplo") {
foreach $type ("norm","diplo","text") {
###    foreach $type ("text") {
    $target_dir =  $HOME."$file"."/"."$type";
    if (!-d $target_dir) {
        $cmd = "mkdir $target_dir";
        print "perform $cmd \n";
        system ($cmd);
        }
        
        if ($type eq "norm") {
            $xsl_file = "wab2cis_normalized.xsl";
            $to_file = "$target_dir"."/".$file."_NORM.xml";   
        }
        if ($type eq "diplo") {
            $xsl_file = "wab2cis_diplomatic.xsl";
            $to_file = $target_dir."/".$file."_DIPL.xml";   
        }
    if ($type eq "norm" || $type eq "diplo") {
        $cmd = "$saxoncmd -s:".$from_file." -xsl:$xsl_file -o:$to_file";
        print "\nTYPE: $type XSL File >$xsl_file< \nFROM File = >$from_file< \nTO_file = >$to_file< \n" if ($Debug >= 2);
        &do_system($file,$type,"$cmd");
        }
 
        if ($type eq "text") {
            foreach $text_form ("sentence-text","siglum-text","text") {
                $xsl_file = "wab2cis_"."$text_form".".xsl";
                $to_file = $HOME."/$file"."/$type"."/".$file."_".$text_form.".txt";   
                $to_file = $HOME."/$file"."/$type"."/".$file."_".$text_form.".xml" if ($text_form =~ /sentence/) ;   
                $cmd = "$saxoncmd -s:".$from_file." -xsl:$xsl_file -o:$to_file ";
                print "\nTYPE: $type XSL File >$xsl_file< \nFROM File = >$from_file< \nTO_file = >$to_file< \n" if ($Debug >= 2);
                &do_system($file,$type,"$cmd");
           }
        }
 
    }
}

sub do_system($$$) {
my $l_file=$_[0];
my $l_type=$_[1];
my $l_cmd=$_[2];

return if ($l_cmd eq "");

if ($count < $cmd_limit) {
  print "\n$l_file, $l_type \t==> Count=$count \n\t\tCMD=$l_cmd \n" if ($Debug >= 1);
  system("$l_cmd &");
  $count ++;
  }
  else  {
  $count = 0;
  print "\n\n$l_file, $l_type \t==> WAIT for Count=$count \n\t\tCMD=$l_cmd and sleep 30 sec\n" if ($Debug >= 1);
  system("$l_cmd; sleep 30");
  }
}  
  
my $local_cmd = @_[0];
if ($count < 5) {
    print "COUNT= $count, BACKGROUND CMD=$local_cmd \n" if ($Debug >= 1);
    system("$local_cmd &");
    $count ++;
    } else  {
    $count = 0;
    print "WAIT for CMD=$local_cmd and sleep 30 sec\n" if ($Debug >= 1);
    system("$local_cmd; sleep 30");    
    }
    

 
