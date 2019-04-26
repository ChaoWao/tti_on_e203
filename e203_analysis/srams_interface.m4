digraph cluster_srams_interface {
label = "srams_interface";
define(`digraph',`subgraph')
include(`srams_input.dot')

include(`srams_output.dot')

include(`srams_inout.dot')

}