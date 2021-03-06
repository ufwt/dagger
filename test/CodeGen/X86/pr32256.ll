; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -fast-isel -mtriple=i686-unknown-unknown -O0 -mcpu=skx | FileCheck %s

@c = external global i8, align 1

; Function Attrs: noinline nounwind
define void @_Z1av() {
; CHECK-LABEL: _Z1av:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    pushl %ebx
; CHECK-NEXT:  .Lcfi0:
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    subl $8, %esp
; CHECK-NEXT:  .Lcfi1:
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:  .Lcfi2:
; CHECK-NEXT:    .cfi_offset %ebx, -8
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    movb %al, %cl
; CHECK-NEXT:    movb $1, %dl
; CHECK-NEXT:    movb c, %ch
; CHECK-NEXT:    # implicit-def: %EAX
; CHECK-NEXT:    movb %ch, %al
; CHECK-NEXT:    andl $1, %eax
; CHECK-NEXT:    kmovw %eax, %k0
; CHECK-NEXT:    kmovq %k0, %k1
; CHECK-NEXT:    kxnorw %k0, %k0, %k2
; CHECK-NEXT:    kshiftrw $15, %k2, %k2
; CHECK-NEXT:    kxorw %k2, %k0, %k0
; CHECK-NEXT:    kmovb %k0, %ebx
; CHECK-NEXT:    testb $1, %bl
; CHECK-NEXT:    kmovb %ecx, %k0
; CHECK-NEXT:    kmovw %k1, {{[0-9]+}}(%esp) # 2-byte Spill
; CHECK-NEXT:    movb %dl, {{[0-9]+}}(%esp) # 1-byte Spill
; CHECK-NEXT:    kmovw %k0, (%esp) # 2-byte Spill
; CHECK-NEXT:    jne .LBB0_1
; CHECK-NEXT:    jmp .LBB0_2
; CHECK-NEXT:  .LBB0_1: # %land.rhs
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    movb %al, %cl
; CHECK-NEXT:    kmovb %ecx, %k0
; CHECK-NEXT:    kmovw %k0, (%esp) # 2-byte Spill
; CHECK-NEXT:    jmp .LBB0_2
; CHECK-NEXT:  .LBB0_2: # %land.end
; CHECK-NEXT:    kmovw (%esp), %k0 # 2-byte Reload
; CHECK-NEXT:    kmovb %k0, %eax
; CHECK-NEXT:    andb $1, %al
; CHECK-NEXT:    movb %al, {{[0-9]+}}(%esp)
; CHECK-NEXT:    addl $8, %esp
; CHECK-NEXT:    popl %ebx
; CHECK-NEXT:    retl
entry:
  %b = alloca i8, align 1
  %0 = load i8, i8* @c, align 1
  %tobool = trunc i8 %0 to i1
  %lnot = xor i1 %tobool, true
  br i1 %lnot, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %entry
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %1 = phi i1 [ false, %entry ], [ false, %land.rhs ]
  %conv = zext i1 %1 to i8
  store i8 %conv, i8* %b, align 1
  ret void
}
