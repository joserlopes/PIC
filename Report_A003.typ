#set text(lang: "por")

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

#set list(indent: 1em)

#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
)

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

Apesar disso, conseguimos perceber e até mesmo realizar algumas adições para o fim de implementar a feature:

Inicialmente, pensámos em implementar um novo atributo com dois parâmetros: `(before:x, after: y)` (tal como se referiu na nossa _feature proposal_), mas depois de alguma consideração, decidimos adicionar apenas um novo atributo à função de formatação de parágrafos - `par()`. Assim, para além de facilitar o seu uso ao utilizador habitual, simplifica também a sua implementação. O objetivo, então, com este novo atributo é fornecer apenas um inteiro que indica o número máximo de linhas de a página atual pode ter do parágrafo em questão. O resto do parágrafo seria passado para a página seguinte.

#text(size: 13pt)[*Exemplo*:]

Input: 
```typ 
#set par(before: 1)
  #lorem(40)
```

Output: 
#figure(image("output.png"))

```rs
//typst/src/model/par.rs

  #[elem(title = "Paragraph", Debug, Construct)]
  pub struct ParElem {
      /// The spacing between lines.
      #[resolve]
      #[ghost]
      #[default(Em::new(0.65).into())]
      pub leading: Length,
  
      [...]
  
      /// The paragraph's before parameter.
      /// Maximum number of lines that must be on the current page.
      /// The remaining number of lines get placed on the next page.
      #[ghost]
      pub before: Option<usize>,  
  }
```

De seguida, passámos para a lógica da _feature_:
- Caso haja um parágrafo que tenha de ser cortado para outra página, o programa lê o valor do `before` (se estiver presente; se não estiver, o seu valor por omissão é 0).

- A seguir, vê o limite de linhas que a própria página pode ter, para não haver linhas que possam sair da página ou desformatar a página. Se o valor do `before` for menor que o número de linhas que cabem na página, este não se altera. Caso o valor do `before` for maior, este passa a ter o número de linhas que cabem na página.

A lógica que se conseguiu implementar foi precisamente a primeira condição: deteta-se o número de linhas que cabem na página e o número de linhas do parágrafo, e verifica-se se é necessário criar um novo _frame_, isto é, uma nova página para conter o texto restante (ao terminar uma _region_, o programa cria um novo _frame_).

```rs
// typst/src/layout/flow.rs

  fn layout_par(
    [...]
  ) -> SourceResult<()> {
    let align = AlignElem::alignment_in(styles).resolve(styles);
    [...]
    let before_lines = ParElem::before_in(styles).unwrap_or(0);
  
    let lines = par .layout(engine, styles, consecutive,
        self.regions.base(), self.regions.expand.x)?.into_frames();
  
            
    // Logic for the 'before' parameter
    if before_lines > 0 {
        let mut total_height = 0;
        let mut line_count = 0;
  
        for line in &lines {
            total_height += line.height();
            line_count += 1;
            if line_count >= before_lines {
                break;
            }
        }
  
        // If the lines don't fit in the current region, move to the next region
        if !self.regions.size.y.fits(total_height) {
            self.finish_region(engine, false)?;
        }
    }
  
  [...]
  
}
```

=== Interação com a comunidade Open-Source

Apesar de tudo, um dos pontos mais positivos, foi a interação com a comunidade Open-Source do projeto em questão. Falando principalmente dos main developers, estes mostraram-se sempre prontos a responder respeitando sempre a nossa falta de experiência em contribuir para projetos de larga escala.

=== Desafios enfrentados

Sem dúvida que a maior dificuldade encontrada foi compreender a lógica inerente ao fluxo de controlo do programa, agravado pelo facto deste projeto ser no fundo um compilador composto por distintas etapas, cada uma dependente da anterior, tornando necessária uma compreensão mais profunda sobre as várias etapas.

=== Documentação do Projeto

O repositório do projeto contém informação bastante detalhada sobre a estrutura do código e a função de cada um dos módulos. A criação de novos testes e a interação com os já existentes encontra-se também bastante bem documentada.

=== Principais conclusões

Como primeira experiência de contribuição num projeto Open-Source e de larga escala, a impressão com que ambos ficámos foi bastante positiva, abrindo espaço para futuras contribuições para este projeto e outros com os quais nos iremos deparar no futuro. Aliás, o documento deste relatório foi escrito usando _*Typst*_.
