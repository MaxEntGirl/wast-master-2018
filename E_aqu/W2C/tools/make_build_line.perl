#!/usr/bin/perl
# get latest extended XML Files from BERGEN
#

use strict 'vars';

my ($HOME,@sec_dirs,$file,$dir,$cmd,$to_dir);
my ($WAB,$WAB_XML);
my ($Debug);

$Debug = 0;

print "get latest SECURE XML Files from BERGEN\n";

$WAB= "http://wab.uib.no/cost-a32_xmlx/";
$HOME = "../../../../SECW2C/CISWAB/geheim/secure_nachlass/";

if (!-d $HOME) {
print "ERROR !!! No ACCESS to $HOME! It doesn't exist \n";
exit;
}

@sec_dirs = (
"Ms-101_OA",
"Ms-102_OA","Ms-103_OA","Ms-104_OA","Ms-105_OA",
"Ms-106_OA","Ms-107_OA","Ms-108_OA","Ms-109_OA","Ms-110_OA",
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
"Ts-302_OA","Ts-303_OA","Ts-304_OA","Ts-305_OA","Ts-306_OA","Ts-309_OA");


my $line='<get src="http://wab.uib.no/cost-a32_xmlx/Ms-101_OA.xml" dest="${ciswab.oadir}/Ms-101_OA.xml"/>';
my ($in,$out);

print "$line\n";
for $dir (@sec_dirs) {
    $in='<get src="http://wab.uib.no/cost-a32_xmlx/'.$dir.'.xml"';
    $out='dest="${ciswab.oadir}/'.$dir.'.xml"/>';
    print "$in $out\n";
}

