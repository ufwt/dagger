# RUN: llvm-mc -triple x86_64--darwin -filetype=obj -o - %s | llvm-dec - -dc-translate-unknown-to-undef -enable-dc-reg-mock-intrin | FileCheck %s

# XFAIL: *

## VEXTRACTPSmr
vextractps	$2, %xmm13, 2(%r11,%rbx,2)
## VEXTRACTPSrr
vextractps	$2, %xmm9, %r8d
retq
