# RUN: llvm-mc -triple x86_64--darwin -filetype=obj -o - %s | llvm-dec - -dc-translate-unknown-to-undef -enable-dc-reg-mock-intrin | FileCheck %s

## VPHADDBQrm
# CHECK-LABEL: call void @llvm.dc.startinst
# CHECK-NEXT: call void @llvm.trap()
# CHECK-NEXT: unreachable
vphaddbq	2(%rbx,%r14,2), %xmm8

## VPHADDBQrr
# CHECK-LABEL: call void @llvm.dc.startinst
# CHECK-NEXT: call void @llvm.trap()
# CHECK-NEXT: unreachable
vphaddbq	%xmm9, %xmm8

retq
