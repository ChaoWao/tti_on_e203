digraph cpu_interface {
label = "cpu_interface";
define(`digraph',`subgraph')
include(`cpu_input.dot');

include(`cpu_output.dot');

include(`cpu_inout.dot');

}