digraph cluster_core {
label="core";
define(`digraph',`subgraph')
include(`core_interface.dot')

include(`ifu.dot')

include(`exu.dot')

include(`lsu.dot')

include(`biu.dot')
// core_input
// core_output
// core_inout
// wire
}