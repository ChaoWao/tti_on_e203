digraph cpu_top_interface {
label = "cpu_top_interface";
define(`digraph',`subgraph')
include(`cpu_top_input.dot');

include(`cpu_top_output.dot');

include(`cpu_top_inout.dot');

}