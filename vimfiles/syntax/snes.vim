syntax iskeyword @,48-57,192-255,$,_,.

syntax match snesLabel "\.*\w\+"

" syntax region snesMacroDef start="macro" end="endmacro"

syntax keyword snesDirective db dw dl org base incsrc incbin lorom hirom exhirom exlorom skip warnpc pushpc pullpc

syntax match impreciseInstruction "ASL"
syntax match impreciseInstruction "DEC"
syntax match impreciseInstruction "INC"
syntax match impreciseInstruction "LSR"
syntax match impreciseInstruction "ROL"
syntax match impreciseInstruction "ROR"

syntax keyword impreciseInstruction
  \ ADC
  \ AND
  \ BIT
  \ CMP
  \ CPX
  \ CPY
  \ EOR
  \ LDA
  \ LDX
  \ LDY
  \ ORA
  \ SBC
  \ STA
  \ STX
  \ STY
  \ STZ
  \ TRB
  \ TSB

syntax match preciseInstruction "ASL A"
syntax match preciseInstruction "DEC A"
syntax match preciseInstruction "INC A"
syntax match preciseInstruction "LSR A"
syntax match preciseInstruction "ROL A"
syntax match preciseInstruction "ROR A"

syntax keyword preciseInstruction
  \ ADC.b
  \ ADC.w
  \ ADC.l
  \ AND.b
  \ AND.w
  \ AND.l
  \ ASL.b
  \ ASL.w
  \ BCC
  \ BCS
  \ BEQ
  \ BIT.b
  \ BIT.w
  \ BMI
  \ BNE
  \ BPL
  \ BRA
  \ BRK
  \ BRL
  \ BVC
  \ BVS
  \ CLC
  \ CLD
  \ CLI
  \ CLV
  \ CMP.b
  \ CMP.w
  \ CMP.l
  \ COP
  \ CPX.b
  \ CPX.w
  \ CPY.b
  \ CPY.w
  \ DEC.b
  \ DEC.w
  \ DEX
  \ DEY
  \ EOR.b
  \ EOR.w
  \ EOR.l
  \ INC.b
  \ INC.w
  \ INX
  \ INY
  \ JMP
  \ JMP.w
  \ JML
  \ JSR
  \ JSL
  \ LDA.b
  \ LDA.w
  \ LDA.l
  \ LDX.b
  \ LDX.w
  \ LDY.b
  \ LDY.w
  \ LSR.b
  \ LSR.w
  \ MVN
  \ MVP
  \ NOP
  \ ORA.b
  \ ORA.w
  \ ORA.l
  \ PEA
  \ PEI
  \ PER
  \ PHA
  \ PHB
  \ PHD
  \ PHK
  \ PHP
  \ PHX
  \ PHY
  \ PLA
  \ PLB
  \ PLD
  \ PLP
  \ PLX
  \ PLY
  \ REP
  \ ROL.b
  \ ROL.w
  \ ROR.b
  \ ROR.w
  \ RTI
  \ RTL
  \ RTS
  \ SBC.b
  \ SBC.w
  \ SBC.l
  \ SEC
  \ SED
  \ SEI
  \ SEP
  \ STA.b
  \ STA.w
  \ STA.l
  \ STP
  \ STX.b
  \ STX.w
  \ STY.b
  \ STY.w
  \ STZ.b
  \ STZ.w
  \ TAX
  \ TAY
  \ TCD
  \ TCS
  \ TCD
  \ TRB.b
  \ TRB.w
  \ TSB.b
  \ TSB.w
  \ TSC
  \ TSX
  \ TXA
  \ TXS
  \ TXY
  \ TYA
  \ TYX
  \ WAI
  \ WDM
  \ XBA
  \ XCE

syntax keyword errorInstruction
  \ ASL.l
  \ BIT.l
  \ CPX.l
  \ CPY.l
  \ DEC.l
  \ INC.l
  \ LDX.l
  \ LDY.l
  \ LSR.l
  \ ROL.l
  \ ROR.l
  \ STX.l
  \ STY.l
  \ STZ.l
  \ TRB.l
  \ TSB.l

syntax match snesNumber "\d\+"
syntax match snesNumber "\$\x\+"

syntax match snesImmediate "#\d\+"
syntax match snesImmediate "#$\x\+"

syntax match snesComment ";.*$"

syntax match snesPrint "print.*$"

syntax match snesMacro "%\w\+"
syntax match snesLabelDef "^\s*?\?\w\+:"
syntax match snesLabelDef "^\s*?\?\.\+\w\+"
syntax match snesLabelDef "\(\s\|^\)?\?+\+\(\s\|$\)"
syntax match snesLabelDef "\(\s\|^\)?\?-\+\(\s\|$\)"

highlight default link snesComment Comment
highlight default link snesImmediate Constant
highlight default link snesNumber Number
highlight default link preciseInstruction Operator
highlight default link impreciseInstruction Keyword
highlight default link snesDirective Keyword
highlight default link errorInstruction Error
highlight default link snesMacro PreProc
highlight default link snesLabelDef Function
highlight default link snesLabel Identifier
highlight default link snesPrint Macro

highlight impreciseInstruction gui=underline
highlight snesLabelDef gui=bold guifg=darkgreen
