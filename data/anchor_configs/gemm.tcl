set_directive_pipeline -off bbgemm/loopjj
set_directive_pipeline -off bbgemm/loopkk
set_directive_pipeline -off bbgemm/loopi
set_directive_pipeline -off bbgemm/loopk
set_directive_pipeline -off bbgemm/loopj

set_directive_pipeline -off bbgemm

set_directive_loop_flatten -off bbgemm/loopkk
set_directive_loop_flatten -off bbgemm/loopi
set_directive_loop_flatten -off bbgemm/loopk
set_directive_loop_flatten -off bbgemm/loopj
