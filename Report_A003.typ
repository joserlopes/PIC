#show heading: it => {
  if it.level == 1 {
    set text(17pt, navy)
    align(center)[#it]
  } else if it.level == 2 {
    set text(15pt, navy)
    align(center)[#it]
  } else if it.level == 3 {
    set text(14pt, navy)
    it
  }
}

#show link: it => {
  set text(blue)
  underline(it)
} 

#set par(justify: true, hanging-indent: -1em)

#show raw: it => {
  if it.block {
    it
  } else {
    highlight(fill: rgb("#4444"), it)
  }
}

= Projecto Integrador de 1º Ciclo em Engenharia Informática e de Computadores

== Relatório final - Grupo A-003

\
#box(height: 22pt,
  columns(2)[
    #align(center)[
    Tomás Filipe Rocha e Cruz \
    ist1103425
    
    José António Ribeiro da Silva Lopes\
    ist1103938
    ]
  ] 
)

=== Introdução

No âmbito da UC PLIC (_Projecto Integrador de 1º Ciclo em Engenharia Informática e de Computadores_)
decidimos contribuir para o projeto Open-Source _*Typst*_, um sistema de typesetting desenhado
com o objetivo de ser tão poderoso como LaTex sendo mais fácil de aprender e utilizar.

=== Desenvolvimento de uma nova funcionalidade

Para tal, um dos desafios da UC era submeter uma nova funcionalidade original dos alunos ou presente 
no feature backlog do próprio projeto. Nós optamos pela segunda, mais precisamente, tentámos implementar
esta feature (https://github.com/typst/typst/issues/3963).

Infelizmente, não fomos capazes de implementar a feature até ao fim e, por conseguinte, os testes respetivos.
No entanto, já tínhamos uma ideia sobre como resolver os problemas com os quais nos fomos deparando, mas por
falta de organização e por acharmos que a implementação seria mais fácil do que acabou por ser, não conseguimos
levá-la até ao fim.

=== Interação com a comunidade Open-Source

Apesar de tudo, um dos pontos mais positivos, foi a interação com a comunidade Open-Source do projeto em questão.
Falando principalmente dos main developers, estes mostraram-se sempre prontos a responder respeitando sempre
a nossa falta de experiência em contribuir para projetos de larga escala.

=== Desafios enfrentados

Sem dúvida que a maior dificuldade encontrada foi compreender a lógica inerente ao fluxo de controlo do programa,
agravado pelo facto deste projeto ser no fundo um compilador composto por distintas etapas, cada uma dependente da anterior.

