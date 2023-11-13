# Genômica e Bioinformática - CEN5789 
Aulas práticas da disciplina ["CEN5789 - Genômica e Bioinformática"](https://uspdigital.usp.br/janus/componente/disciplinasOferecidasInicial.jsf?action=3&sgldis=CEN5789)

__Criador e Instrutor__
Diego M. Riaño-Pachón

# Bioinformática

Os exercícios serão realizados nos computadores da sala de computadores da central de aulas do CENA/USP. Por favor, entre no computador usando o sistema operacional Ubuntu e o usuário cen5789.

## Bioinfo 1 - Operacoes básicas em Bioinformática

### Ferramentas do Unix úteis na bioinformática.

Após adquirir alguma familiaridade com os fundamentos do [sistema operacional Linux](unix.md), vamos explorar como alguns de seus comandos mais básicos podem ser extremamente úteis na área de bioinformática. Você entenderá por que o Linux é o sistema operacional de escolha na bioinformática.

Para realizar esses exercícios, você precisa usar o arquivo [file1.tar.gz](files/file1.tar.gz). Após baixá-lo, o arquivo deve estar na sua pasta "Downloads". Você deve descompactá-lo em seu diretório HOME.

```
cd
mv ~/Downloads/file1.tar.gz ~/
tar xvzf file1.tar.gz
```

#### Algumas operações básicas com arquivos.

Usando alguns comandos do UNIX, podemos obter informações sobre arquivos e o conteúdo deles de forma rápida e eficiente, muitas vezes sem a necessidade de abrir o arquivo, que pode ser muito grande, para obter essas informações.

No subdiretório "~/dia1/", encontre o arquivo "TAIR10_pep_20101214_updated.fasta.gz", que corresponde à base de dados de sequências de proteínas previstas no genoma da planta modelo _Arabidopsis thaliana_. Para saber quantas linhas este arquivo possui, descomprioma o arquivo e conte o número de linhas com os comandos:

```
cd 
cd ~/dia1
gunzip TAIR10_pep_20101214_updated.fasta.gz
wc -l TAIR10_pep_20101214_updated.fasta
```
Pode conhecer o tamnho do arquivo com o comando _ls_:

```
ls -l -h TAIR10_pep_20101214_updated.fasta
```

O que faz a opção -h no comando 'ls'? Consulte a página de manual do _ls_ para saber."

Na maioria das vezes, é importante visualizar o conteúdo do arquivo, seja no início ou no final.  No entanto, devido ao grande tamanho dos arquivos com os quais normalmente se trabalha, não é conveniente abrir o arquivo com nenhum editor de texto, pois isso pode reduzir o tempo de resposta do computador. Podemos visualizar as primeiras ou ultimas linahs de um arquivo de texto com os comandos  _head_ e _tail_ respetivamente

```
head TAIR10_pep_20101214_updated.fasta
tail TAIR10_pep_20101214_updated.fasta
```
Esses comandos mostram as primeirais ou ultimas 10 linhas do arquivo. O que você pode fazer para mostrar um número maior de linhas? Consulte a página de manual do  _head_ 

Repare na saída do comando `head`. Está mostrando um registro de sequência no formato 'fasta'. Este formato é o mais simples para armazenar sequências, tanto de ácidos nucleicos quanto de proteínas. Sua estrutura é muito simples. Cada registro começa com uma linha que tem no seu início o sinal _>_ seguido de uma cadeia de caracteres de comprimento arbitrário que funciona como o identificador da sequência. Em seguida, nas linhas subsequentes, aparece a sequência em si, em quantas linhas forem necessárias.

Pode usar o comando _grep_ para localizar todas as linhas que tem um padrão de texto específico, ou seja, uma cadeia de texto específica. Vamos identificar todas a linas que comecam com o sinal _>_

```
grep ">" TAIR10_pep_20101214_updated.fasta
```

São muitas linhas, vamos usar o _pipe_ para examinar só as primeiras 4 linas com o padrão de texto:

```
grep ">" TAIR10_pep_20101214_updated.fasta | head -n 4
```

#### Formatos de sequências

Existem diferentes formatos para sequências, geralmente em texto simples. Isso significa que elas podem ser visualizadas e editadas com qualquer editor de texto, como vi ou pico. Alguns desses formatos são mais comuns do que outros, e muitos programas de bioinformática aceitam vários dos formatos mais comuns ([Leonard et al., 2007](https://pubmed.ncbi.nlm.nih.gov/18428774/)).

Todos os formatos de sequências têm uma característica (campo) em comum: um identificador para cada sequência, para que esta possa ser reconhecida de forma única.

##### Fasta

O formato mais simples é conhecido como Fasta. Nele, uma entrada, que é uma sequência, é dividida em duas partes: a linha de identificação, que deve começar com o símbolo ">" seguido imediatamente pelo identificador da sequência, que pode ser qualquer cadeia de caracteres sem espaços. As linhas imediatamente após o identificador correspondem à própria sequência.

O formato Fasta é o formato de sequências mais amplamente utilizado em aplicações de bioinformática.

```
>gi|110742030|dbj|BAE98952.1| putative NAC domain protein [Arabidopsis thaliana]
MEDQVGFGFRPNDEELVGHYLRNKIEGNTSRDVEVAISEVNICSYDPWNLRFQSKYKSRDAMWYFFSRRE
NNKGNRQSRTTVSGKWKLTGESVEVKDQWGFCSEGFRGKIGHKRVLAFLDGRYPDKTKSDWVIHEFHYDL
LPEHQRTYVICRLEYKGDDADILSAYAIDPTPAFVPNMTSSAGSVVNQSRQRNSGSYNTYSEYDSANHGQ
QFNENSNIMQQQPLQGSFNPLLEYDFANHGGQWLSDYIDLQQQVPYLAPYENESEMIWKHVIEENFEFLV
DERTSMQQHYSDHRPKKPVSGVLPDDSSDTETGSMIFEDTSSSTDSVGSSDEPGHTRIDDIPSLNIIEPL
HNYKAQEQPKQQSKEKVISSQKSECEWKMAEDSIKIPPSTNTVKQSWIVLENAQWNYLKNMIIGVLLFIS
VISWIILVG
```

##### GenBank

O formato GenBank é utilizado pelo 'National Center for Biotechnology Information' ([NCBI](https://www.ncbi.nlm.nih.gov/)), o maior repositório de sequências de ácidos nucleicos e proteínas do mundo. O NCBI, juntamente com o [EMBL-EBI](https://www.ebi.ac.uk/) e o [DDBJ](https://www.ddbj.nig.ac.jp/), mantém conjuntamente o 'The International Nucleotide Sequence Database' ([Mizrachi, 2008](https://pubmed.ncbi.nlm.nih.gov/27896718/)).

Uma entrada neste formato é composta por duas partes. A primeira parte abrange as posições de 1 a 10 e geralmente contém o nome do campo, como LOCUS, DEFINITION, ACCESSION ou SOURCE. A segunda parte de cada entrada contém informações correspondentes ao campo em questão. Cada entrada é finalizada com o símbolo '//'. Você pode encontrar mais informações sobre esse tipo de arquivo [aqui](http://www.ncbi.nlm.nih.gov/Sitemap/samplerecord.html).

```
LOCUS       BAE98952                 429 aa            linear   PLN 27-JUL-2006
DEFINITION  putative NAC domain protein [Arabidopsis thaliana].
ACCESSION   BAE98952
VERSION     BAE98952.1
DBSOURCE    accession AK226863.1
KEYWORDS    .
SOURCE      Arabidopsis thaliana (thale cress)
  ORGANISM  Arabidopsis thaliana
            Eukaryota; Viridiplantae; Streptophyta; Embryophyta; Tracheophyta;
            Spermatophyta; Magnoliopsida; eudicotyledons; Gunneridae;
            Pentapetalae; rosids; malvids; Brassicales; Brassicaceae;
            Camelineae; Arabidopsis.
REFERENCE   1
  AUTHORS   Totoki,Y., Seki,M., Ishida,J., Nakajima,M., Enju,A., Morosawa,T.,
            Kamiya,A., Narusaka,M., Shin-i,T., Nakagawa,M., Sakamoto,N.,
            Oishi,K., Kohara,Y., Kobayashi,M., Toyoda,A., Sakaki,Y.,
            Sakurai,T., Iida,K., Akiyama,K., Satou,M., Toyoda,T., Konagaya,A.,
            Carninci,P., Kawai,J., Hayashizaki,Y. and Shinozaki,K.
  TITLE     Large-scale analysis of RIKEN Arabidopsis full-length (RAFL) cDNAs
  JOURNAL   Unpublished
REFERENCE   2  (residues 1 to 429)
  AUTHORS   Totoki,Y., Seki,M., Ishida,J., Nakajima,M., Enju,A., Morosawa,T.,
            Kamiya,A., Narusaka,M., Shin-i,T., Nakagawa,M., Sakamoto,N.,
            Oishi,K., Kohara,Y., Kobayashi,M., Toyoda,A., Sakaki,Y.,
            Sakurai,T., Iida,K., Akiyama,K., Satou,M., Toyoda,T., Konagaya,A.,
            Carninci,P., Kawai,J., Hayashizaki,Y. and Shinozaki,K.
  TITLE     Direct Submission
  JOURNAL   Submitted (26-JUL-2006) Motoaki Seki, RIKEN Plant Science Center;
            1-7-22 Suehiro-cho, Tsurumi-ku, Yokohama, Kanagawa 230-0045, Japan
            (E-mail:mseki@psc.riken.jp, URL:http://rarge.gsc.riken.jp/,
            Tel:81-45-503-9625, Fax:81-45-503-9586)
COMMENT     An Arabidopsis full-length cDNA library was constructed essentially
            as reported previously (Seki et al. (1998) Plant J. 15:707-720;
            Seki et al. (2002) Science 296:141-145).
            This clone is in a modified pBluescript vector.
            Please visit our web site (http://rarge.gsc.riken.jp/) for further
            details.
FEATURES             Location/Qualifiers
     source          1..429
                     /organism="Arabidopsis thaliana"
                     /db_xref="taxon:3702"
                     /chromosome="1"
                     /clone="RAFL08-19-M04"
                     /ecotype="Columbia"
                     /note="common name: thale cress"
     Protein         1..429
                     /product="putative NAC domain protein"
     Region          5..137
                     /region_name="NAM"
                     /note="No apical meristem (NAM) protein; pfam02365"
                     /db_xref="CDD:426740"
     CDS             1..429
                     /gene="At1g01010"
                     /coded_by="AK226863.1:89..1378"
ORIGIN      
        1 medqvgfgfr pndeelvghy lrnkiegnts rdvevaisev nicsydpwnl rfqskyksrd
       61 amwyffsrre nnkgnrqsrt tvsgkwkltg esvevkdqwg fcsegfrgki ghkrvlafld
      121 grypdktksd wvihefhydl lpehqrtyvi crleykgdda dilsayaidp tpafvpnmts
      181 sagsvvnqsr qrnsgsynty seydsanhgq qfnensnimq qqplqgsfnp lleydfanhg
      241 gqwlsdyidl qqqvpylapy enesemiwkh vieenfeflv dertsmqqhy sdhrpkkpvs
      301 gvlpddssdt etgsmifedt ssstdsvgss depghtridd ipslniiepl hnykaqeqpk
      361 qqskekviss qksecewkma edsikippst ntvkqswivl enaqwnylkn miigvllfis
      421 viswiilvg
//
```

#### Algumas operações básicas com sequências no formato Fasta

Durante o restante desta seção e na próxima, usaremos apenas sequências no formato Fasta. Por favor, verifique se as sequências de _A. thaliana_ no arquivo 'TAIR10_pep_20101214_updated.fasta' estão neste formato. Você pode usar o comando `head nome_do_arquivo` ou o comando `less nome_do_arquivo` para fazer isso.

Você já teve que contar o número de sequências num arquivo ou alterar o identificador das sequências no formato Fasta? Se fossem apenas algumas sequências, isso poderia ser feito facilmente em qualquer editor de texto. No entanto, quando se trata de milhares de sequências, a opção de usar um editor de texto deixa de ser viável. Felizmente, alguns comandos do Unix nos permitem realizar essas tarefas simples de forma rápida.

Como observado anteriormente, o comando `grep` pode nos ajudar a contar o número de sequências em um arquivo Fasta. O modificador `-c` conta o número de linhas que contêm um padrão específico em um arquivo, e podemos aproveitar o fato de que em um arquivo Fasta o símbolo _>_ aparece uma única vez para cada sequência. Para contar o número de sequencias armazenadas no arquivo pode usar o comando:

```
grep -c ">" TAIR10_pep_20101214_updated.fasta
```

Em outras situações, é importante modificar o identificador de cada sequência para incluir, por exemplo, uma abreviatura que represente o nome da espécie à qual a sequência pertence. Novamente, o Unix nos permite fazer essa alteração rapidamente usando o comando `sed`. Vamos adicionar a partícula 'ATH' a cada um dos identificadores do arquivo, aproveitando o fato de que à esquerda de cada identificador temos o símbolo '>'. Observe que os resultados desta operação estão sendo armazenados em um novo arquivo:

```
sed 's/>/>ATH_/' TAIR10_pep_20101214_updated.fasta > TAIR10_pep_20101214_updated.mod.fasta
```
As linhas com os identificadores neste arquivo são muito extensas, para muitos programas isto não é desejável. Vamos eliminar tudo que aparecer depois do primeiro ' |'. Para isso vamos usar [regular expressions](https://www.gnu.org/software/sed/manual/html_node/Regular-Expressions.html).

```
sed -r 's/ | .*$//' TAIR10_pep_20101214_updated.mod.fasta > TAIR10_pep_20101214_updated.mod2.fasta
```
## Bioinfo 2 - Análise de Sequências

### Dotplots - Matrices de pontos

Eu recomendo que você trabalhe na pasta `~/dia2`.

As matrizes de pontos ('Dot Plot') são ferramentas exploratórias para a comparação de cadeias de texto, ou seja, sequências. Entre outras funcionalidades, elas nos permitem facilmente identificar regiões repetidas em uma sequência ao compará-la com ela mesma. Também podemos obter uma ideia bastante clara da estrutura de um gene ao comparar a sequência de sua região codificante com a sequência do locus onde ele se encontra.

Os dotplots são frequentemente usados para ilustrar comparações de genomas ou cromossomos, como exemplificado na Figura 1 [deste artigo](https://academic.oup.com/nar/article/39/10/e68/1310457) ou na Figura 2 [deste outro](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-021-07534-0).

Nesta seção, utilizaremos a implementação de matrizes de pontos do Instituto Suíço de Bioinformática, conhecida como [Dotlet JS](https://dotlet.vital-it.ch/), para realizar comparações de pequenas sequências, conforme ilustrado na Figura:

![Dotlet screenshot 1](images/dotlet_1.png)

Em seguida, estudaremos alguns exemplos provenientes da documentação do [DotLet](https://myhits.sib.swiss/util/dotlet/doc/dotlet_help.html).

#### Sequências repetidas

Faça uma comparação da sequência [SLIT_DROME](files/slit_drome.fa) contra ela mesma . Copie a sequência, em seguida clique no botão 'SEQUENCE 1', faz o mesmo para o botão 'SEQUENCE 2'.

À direita dos botões onde você carregou a sequência, encontrará uma lista suspensa que permite a seleção da matriz de substituição. Logo abaixo, há outra lista suspensa que permite escolher os tamanhos da janela a serem utilizados na comparação das duas sequências.

Após o cálculo da matriz de pontos, a tela será semelhante à figura anterior. No centro da página, à esquerda, encontra-se a matriz de pontos propriamente dita, na qual padrões de linhas diagonais podem ser observados. À direita, há um histograma das pontuações das comparações dos aminoácidos.

O tamanho da janela (_window size_) afeta a visualização na matriz de pontos, pois determina o tamanho da área que está sendo analisada de cada vez. Janelas maiores podem mostrar uma visão mais ampla e suavizada da comparação, enquanto janelas menores podem mostrar detalhes finos e repetições mais curtas.

A linha vermelha no histograma de pontuações representa os mesmos valores das barras azuis, mas em uma escala logarítmica. Essa escala é frequentemente empregada para realçar as pontuações extremamente altas, que, de outra forma, seriam menos visíveis devido à sua baixa frequência. Isso ajuda a identificar áreas de interesse na matriz de pontos.

Este dotplot é da proteína [__SLIT__ de _Drosophila melanogaster_](https://www.uniprot.org/uniprotkb/P24014/entry) em relação a si mesma. Ela possui várias regiões repetidas. Na parte N-terminal (A), observamos quatro regiões repetidas, que são compostas por unidades menores repetidas (neste caso, repetições ricas em leucina). Em seguida, há outro domínio que se repete pelo menos seis vezes em um aglomerado compacto (B), com uma ocorrência adicional próxima ao C-terminus. Este último é um domínio EGF (fator de crescimento epidérmico).

A figura abaixo mostra a disposição dos domínios ao longo da sequência da proteína, conforme descrito na entrada do [Swiss-Prot](https://www.uniprot.org/uniprotkb/P24014/entry).

![Dotlet screenshot 1](https://myhits.sib.swiss/util/dotlet/doc/slit_drome.gif)

#### Domínios proteicos conservados

Agora carregue as sequencias [MS2_HUMAN](https://www.uniprot.org/uniprotkb/MS2_HUMAN) e [ADAM_CROAD](https://www.uniprot.org/uniprotkb/ADAM_CROAD).

A sequência horizontal representa o antígeno de superfície celular MS2 humano, enquanto a vertical representa a adamalisina II, uma metaloprotease proveniente do veneno da serpente _Crotalus adamanteus_ (cascavel de cauda de chocalho do leste). Ambos contêm um domínio de metaloprotease de zinco; como a imagem mostra, a adamalisina consiste apenas deste domínio, enquanto ele representa aproximadamente um quarto da proteína MS2.

![Dotlet screenshot 2](images/dotlet_2.png)

Modifique os valores de _Window Size_ para 15, 25, 35 e 45, por exemplo, e a _Scoring Matrix_ para cada uma das matrizes BLOSUM. Como esses parâmetros afetam o dotplot?

#### Éxons e Íntrons

O [ANAC092](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3001574/) é um fator de transcrição da família NAC em _Arabidopsis thaliana_, identificado com o código [AT5G39610.1](https://www.arabidopsis.org/servlets/TairObject?id=133421&type=locus) no genoma da planta. O gene que codifica este produto gênico tem três éxons e dois íntrons.

Carregue a sequência genômica do [ANAC092](files/ANAC092_genomic.fasta) como 'SEQUENCE 1' e a sequência de [cDNA](files/ANAC092_cDNA.fasta) como 'SEQUENCE 2' no Dotlet. Selecione a matriz Identity como Scoring Matrix e utilize vários valores de Window Size na análise. Como este parâmetro afeta a análise?

![Dotlet screenshot 3](images/dotlet_3.png)

Pode identificar algum valor do parâmetro Window Size que permita visualizar sequências repetitivas no cDNA?"

#### Dotplots com EMBOSS e outros applicativos

O European Molecular Biology Open Software Suite [EMBOSS](http://emboss.open-bio.org/) é uma suite de software com mais de 200 aplicativos para a análise de sequências.

Nesta seção, vamos refazer os dotplots anteriores usando um aplicativo do EMBOSS. Qual aplicativo usar? Na linha de comandos, você pode usar o programa `wossname` para procurar aplicativos que tenham na sua descrição uma palavra-chave específica. Por exemplo, você pode procurar a palavra _dotplot_. Para obter mais informações sobre um aplicativo específico, você pode utilizar a página de manual `man` ou o comando `tfm`, seguido do nome do aplicativo.

Antes de utilizar os aplicativos do EMBOSS, é necessário ativar o ambiente onde o software foi instalado. Execute o seguinte comando no seu terminal. Os pacotes do EMBOSS estarão disponíveis nesse terminal. Se trocar de terminal, será necessário ativar o ambiente novamente.

```
conda activate emboss
```

Quando terminar de usar os aplicativos do EMBOSS, é importante desativar o ambiente para evitar conflitos com outros aplicativos que possam ser utilizados.


```
conda deactivate
```

Tanto o Dotlet JS quanto os programas de dotplot em EMBOSS têm algumas limitações, talvez a mais importante seja que não conseguem detectar facilmente repetições invertidas, como as que aparecem em estruturas secundárias de RNA.

Vamos usar o programa [Re-Dot-Table](https://www.bioinformatics.babraham.ac.uk/projects/redotable/) para comparar a sequência do arquivo [secondarystructure.fasta](files/secondatystructure.fasta) com ela mesma. 

Esta sequência adquire a estrutura secundária que aparece abaixo. Nesta estrutura, as regiões que formam _stems_ correspondem a repetições invertidas, que podem ser visualizadas como diagonais com inclinação oposta à diagonal principal no dotplot.

![secondary structure](images/secondarystructure.png)

Para gerar o dotplot com o software __Re-Dot-Table__, é necessário ativar um ambiente Conda no qual o software foi previamente instalado e, em seguida, executar o aplicativo:

```
conda activate redotable
redotable
```
A seguinte figura mostra o resultado dessa comparação. Explore o efeito do tamanho da janela para gerar o dotplot.

![redotable screenshot 1](images/redotable_1.png)

Lembre-se de desativar seu ambiente.

```
conda deactivate
```


### Alinhamentos exatos de pares de sequências

#### cDNA vs Genoma

Além da substituição de um resíduo (aminoácido ou nucleotídeo) por outro, as sequências podem sofrer perdas ou ganhos de resíduos, ou seja, deleções ou inserções, comumente chamadas em conjunto de _indels_. Os dotplots não permitem incluir esse tipo de variações nas análises. Para isso, precisamos de algoritmos mais sofisticados de comparação de sequências, é aí que entram os algoritmos exatos de comparação de pares de sequências. Esses algoritmos podem ser globais ou locais. 

O algoritmo para alinhamento global exato foi proposto por [Needleman e Wuhsch em 1970](https://pubmed.ncbi.nlm.nih.gov/5420325/), usa a estratégia de [programação](https://www.spiceworks.com/tech/devops/articles/what-is-dynamic-programming/) [dinâmica](https://www.nature.com/articles/nbt0704-909) e, para um conjunto selecionado de parâmetros, garante encontrar o melhor alinhamento possível, por isso é considerado _exato_. É chamado de global porque seu objetivo é encontrar o alinhamento que envolve todos os resíduos das duas sequências sendo comparadas.

O algoritmo para alinhamento local foi proposto por [Smith e Waterman](https://www.sciencedirect.com/science/article/pii/0022283681900875?via%3Dihub) uma década após o desenvolvimento do algoritmo de alinhamento global. Ele também usa a estratégia de programação dinâmica e garante uma solução exata para um conjunto selecionado de parâmetros. No entanto, seu objetivo é diferente, o alinhamento produzido não precisa envolver todos os resíduos das duas sequências, mas apenas procura encontrar a subsequência mais longa comum (permitindo substituições e _indels_) entre as sequências de interesse.

Nesta aula prática vamos usar o programa `est2genome` da suite _EMBOSS_ para alinhar uma sequencia de _cDNA_ as uma sequencia genômica. Tenha presente que a sequencia genômica pode ter um comprimento muito maior que a sequencia de _cDNA_. O `est2genome` usa um algoritmo que combina as estrategias de alinhamento local e global. Segundo a sua propia [documentacao](https://emboss.bioinformatics.nl/cgi-bin/emboss/help/est2genome) os pasos do algoritmos são:

- __Paso 1__: É realizado um primeiro escaneamento Smith-Waterman para localizar a pontuação, o início e o fim do segmento com pontuação máxima (incluindo introns, é claro). Nenhuma outra informação de alinhamento é retida.
- __Paso 2__: Subsequências correspondentes aos segmentos de pontuação máxima são extraídas. Se o produto do comprimento dessas subsequências for menor que o parâmetro de área, os segmentos são realinhados usando o algoritmo Needleman-Wunsch, que neste caso dará o mesmo resultado que o Smith-Waterman, já que eles estão garantidos a se alinharem de ponta a ponta.
- __Paso 3__: Se o produto dos comprimentos exceder o limite de área, o alinhamento é dividido recursivamente, dividindo o EST ao meio e encontrando a posição no genoma que se alinha com o ponto médio do EST. O problema é então reduzido a alinhar as porções esquerda e direita das sequências separadamente e mesclar o resultado.

Por que você considera importante começar com uma varredura usando o algoritmo de Smith-Waterman?

Vamos usar a sequência genômica do [ANAC092](files/ANAC092_genomic.fasta) e a sequência de [cDNA](files/ANAC092_cDNA.fasta) para identificar o alinhamento que mostre as posições dos éxons e dos íntrons no genoma. Consulte a página de manual do `est2genome` e visualize o resultado do alinhamento com seu editor de texto favorito. Lembre-se de ativar o ambiente de emboss.

```
conda activate emboss
```

#### Proteínas

##### Matrices de substituição

Vamos inspecionar a matriz _BLOSUM62_ que está incluída no _EMBOSS_. Para isso, precisamos encontrar a pasta onde o _EMBOSS_ armazena as matrizes. Execute o seguinte comando:

```
embossdata EBLOSUM62
```

Alguma saída conterá a palavra '_exists_'. No meu caso, o caminho para a matriz BLOSUM62 é `/usr/share/EMBOSS/data/EBLOSUM62`, e é nesse arquivo que a matriz BLOSUM62 está armazenada. Pode visualizar o conteúdo do arquivo com o comando `less`. Basta executar o seguinte comando:

```
less /usr/share/EMBOSS/data/EBLOSUM62
```

Isso abrirá o arquivo EBLOSUM62 no visualizador de texto "less", permitindo que você role e visualize seu conteúdo.

Responda as seguintes perguntas:
- Onde estão as maiores pontuações? Explique.
- Qual é a substituição com a maior pontuação?
- Por que as identidades não têm sempre a mesma pontuação?

##### NACs

Os NACs são uma família de fatores de transcrição específicos de plantas [(Han et al., 2023)](https://pubmed.ncbi.nlm.nih.gov/37623750/). Neste exercício, vamos comparar uma proteína NAC de angiosperma [_Arabidopsis thaliana_](files/ANAC092_pep.fasta) e uma proteína NAC do musgo [_Physcomitrium patens_](files/PpNAC_pep.fasta).

Vamos realizar um alinhamento global entre as duas proteínas. Lembre-se de que o algoritmo de alinhamento global procura o alinhamento ideal que envolva as duas sequências inteiras.

Quais programas do EMBOSS podem realizar alinhamentos globais?

```
wossname global
```

Usaremos o programa `needle` para realizar uma comparação global entre essas duas sequências. Verifique em [timetree.org](https://timetree.org/) oo tempo de divergência entre as duas espécies.

Qual matriz BLOSUM considera mais adequada para comparar as duas sequências?

Execute a comparação das duas sequências, especificando a matriz selecionada, e compare os resultados usando a matriz BLOSUM90. Você pode consultar a página de manual do `needle` para aprender como especificar as opções:

```
man needle
```

Agora realizaremos um alinhamento local. O objetivo do alinhamento local é encontrar regiões de similaridade local, e não é necessário incluir as sequências completas. Esse tipo de alinhamento é muito útil para pesquisar bancos de dados ou quando você não tem uma ideia clara sobre a semelhança da sequência de interesse com sequências no banco de dados. Usaremos o programa `water` para realizar uma comparação local entre essas duas sequências. Você pode consultar a página de manual do `water` para ajudar na selecao de opções:

```
man water
```

Quão significativos são esses alinhamentos? Tente gerar uma sequência aleatória a partir de [ANAC092](files/ANAC092_pep.fasta) e refaça os alinhamentos exatos. Como a pontuação do alinhamento muda?

### Alinhamentos heurísticos de pares de sequências - Buscas em bancos de dados

Os alinhamentos exatos representam um grande desafio computacional em termos de recursos necessários. Quando estamos buscando uma sequência semelhante a um alvo em um banco de dados que contém milhões de sequências, muitas vezes é necessário relaxar os critérios de busca para obter respostas rápidas e satisfatórias, mesmo que não sejam a resposta perfeita (exata). É aqui que ferramentas como o __Basic Local Alignment Search Tool__ ([Altschul et al., 1990](https://pubmed.ncbi.nlm.nih.gov/2231712/)), podem e devem ser empregadas. É importante destacar que o BLAST é uma ferramenta projetada para realizar alinhamentos __locais__, permitindo encontrar regiões similares em sequências, em vez de buscar por correspondências globais.

O BLAST possui uma interface gráfica (_Grafical User Interface_ ou _GUI_) muito boa para buscar sequências no banco de dados da NCBI. 

#### BLAST na interface web

Utilize a sequência encontrada no arquivo [files/unknown_nuc.fasta](files/unknown_nuc.fasta) para realizar uma pesquisa BLAST, no site (https://blast.ncbi.nlm.nih.gov/Blast.cgi). Esta sequencia corresponde a um trascrito de _A. thaliana_ identificado num experimento. Realize a busca usando o programa `blastn`, i.e., "Nucleotide - Nucleotide" no genoma completo de _A. thaliana_. Quais opções você deve selecionar para restringir sua pesquisa aos cromossomos de Arabidopsis thaliana? Uma vez que o BLAST realiza a pesquisa usando alinhamentos locais, esse resultado fornecerá apenas uma ideia muito preliminar da localização do transcrito no genoma. No entanto, você pode usar essas informações para refinar a predição do locus do transcrito usando o `est2genome` do EMBOSS ou o [Splign do NCBI](https://www.ncbi.nlm.nih.gov/sutils/splign/). Quais opções você selecionou para realizar a pesquisa no BLAST? Por quê? Descreva os resultados da pesquisa.

![BLAST web screenshot 1](images/blast_1.png)

Os resultados dessa pesquisa nos permitem concluir que o locus do transcrito está no cromossomo número 5 de A. thaliana. Quais são as coordenadas aproximadas no cromossomo? Existem exons? Explique sua resposta. Vamos usar esse resultado como entrada para o `est2genome`. Primeiro, extraia da sequência do cromossomo 5 a região detectada pelo BLAST, adicionando 5000 pb a montante e a jusante. Como você pode fazer isso? Use o `est2genome` para refinar a predição do locus. Quais vantagens o est2genome oferece em comparação com um simples BLAST?



#### BLAST na linha de comandos

No entanto, executar o BLAST através da linha de comando tem muitos benefícios:

- É muito mais fácil executar várias consultas do BLAST usando a linha de comando do que a GUI.
- A execução do BLAST com a linha de comando é reprodutível e pode ser documentada em um script.
- Os resultados podem ser salvos em um formato legível por máquina que pode ser analisado posteriormente.
- Você pode criar seus próprios bancos de dados para pesquisa em vez de usar os bancos de dados pré-construídos da NCBI.
- Isso permite a automação das consultas.
- Isso permite que você use um servidor remoto para executar as consultas do BLAST.

Ao utilizar o __BLAST__, é comum termos uma sequência de interesse, conhecida como _query_, que será comparada com sequências de um banco de dados, chamadas de _subject_. Neste exercício, iremos comparar as sequências de proteínas do camundongo (_Mus musculus_) com as sequências de proteínas do zebrafish (_Danio rerio_). O objetivo principal é encontrar, para cada proteína do camundongo, a proteína mais semelhante no zebrafish.

Vamos baixar os arquivos com as sequências das proteínas no formato FASTA:

```
curl -o mouse.1.protein.faa.gz -L https://osf.io/v6j9x/download
curl -o zebrafish.1.protein.faa.gz -L https://osf.io/68mgf/download
```

Descompacte-os:

```
gunzip *.faa.gz
```

E vamos dar uma olhada nas primeiras sequências no arquivo:

```
head mouse.1.protein.faa
```

Essas são sequências de proteínas no formato FASTA. O formato FASTA é algo que muitos de vocês provavelmente já viram de uma forma ou de outra - é bastante comum. É um arquivo de texto que contém registros; cada registro começa com uma linha que começa com um '>' e, em seguida, contém uma ou mais linhas de texto de sequência.

Vamos pegar essas duas primeiras sequências e salvá-las em um arquivo. Faremos isso usando a redireção de saída com o '>' que diz "pegue toda a saída e coloque-a neste arquivo aqui.". Vamos utilizar o comando `head` para visualizar as _X_ primeiras linhas que contêm as duas primeiras sequências? Como podemos encontrar o valor de _X_?

Já estamos familiarizados com o comando `grep`, que nos ajuda a encontrar padrões em arquivos de texto. Neste caso, podemos procurar pelo padrão _'>'_. Consultando a documentação do comando grep, encontraremos a opção `-n`, que, além de mostrar a linha que contém o padrão, também exibirá o número da linha no arquivo. Portanto, vamos usar o grep para exibir as três primeiras linhas que contêm o sinal _'>'_ e seus números de linha correspondentes no arquivo:"

```
grep -n ">" mouse.1.protein.faa|head -n3
```

Com esse resultado, agora sabemos que a terceira sequência começa na linha 12, ou seja, a segunda sequência termina na linha 11. O valor de _X_ é 11, agora podemos extrair as duas primeiras sequencias do arquivo usando o comando `head`:

```
head -n 11 mouse.1.protein.faa > mm-first.faa
```

Agora, por exemplo, você pode usar cat mm-first.faa para ver o conteúdo desse arquivo (ou less mm-first.faa). DICA: se você tentar less mm-first.faa, precisará sair pressionando a tecla 'q' no teclado.

Agora vamos fazer um BLAST com essas duas sequências em relação a todo o conjunto de dados de proteínas do zebrafish. Primeiro, precisamos informar ao BLAST que as sequências do zebrafish são (a) um banco de dados e (b) um banco de dados de proteínas. Isso é feito chamando o 'makeblastdb'. Observe que você precisará primeiro ativar seu ambiente Conda que possui o BLAST instalado.

```
conda activate blast
makeblastdb -in zebrafish.1.protein.faa -dbtype prot
```

Em seguida, chamamos o BLAST para fazer a pesquisa:

```
blastp -query mm-first.faa -db zebrafish.1.protein.faa
```

Isso não deve tardar muito, mas você receberá muita saída na tela do computador!! Para salvá-lo em um arquivo em vez de vê-lo na tela, peça ao BLAST para salvar a saída em um arquivo que chamaremos de mm-first.x.zebrafish.txt:

```
blastp -num_threads 5 -query mm-first.faa -db zebrafish.1.protein.faa -out mm-first.x.zebrafish.txt
```

Agora, você pode 'navegar' por este arquivo à vontade digitando:

```
less mm-first.x.zebrafish.txt
```

(Tecle espaço para mudar de página e 'q' para sair do modo de navegação.)

Vamos trabalhar com algumas sequências adicionais (este levará um pouco mais de tempo para ser executado):

```
head -n 519 mouse.1.protein.faa > mm-second.faa
grep -c ">" mm-second.faa
```

Em seguida, faremos a comparação das primeiras 100 sequências:

```
blastp -num_threads 5 -query mm-second.faa -db zebrafish.1.protein.faa -out mm-second.x.zebrafish.txt
```

Você pode visualizar o arquivo de saída com:

```
less mm-second.x.zebrafish.txt
```

(E novamente, digite 'q' para sair do modo de visualização.)

Observações:


Por que levou mais tempo para fazer o BLAST em mm-second.faa do que em mm-first.faa?

Coisas para mencionar e discutir:

- Opções do blastp e -help.
- Qual valor de e-value foi usado para filtrar os resultados?
- Qual foi o valor da palavra usado para iniciar a busca?
- Opções da linha de comando, mais especificamente, por que tantas?

Automação é maravilhosa!

Por último, mas não menos importante, vamos gerar uma versão mais legível para máquinas daquele último arquivo:

```
blastp -num_threads 5 -query mm-second.faa -db zebrafish.1.protein.faa -out mm-second.x.zebrafish.tsv -outfmt 6
```

Você pode abrir o arquivo com less mm-second.x.zebrafish.tsv para ver como ele é formatado.

Em alguns casos mais do que uma proteina do zebrafish aparece no resultado. Vamos modificar os argumentos do `blastp` para retornar máximo uma proteina _subject_ para cada _query_. Para evitar _hits_ de fracoes das proteínas, vamos a pedir para o `blastp` so relatar hits onde a cobertura do query seja pelo menos 80% do seu comprimento.

```
blastp -num_threads 5 -query mm-second.faa -db zebrafish.1.protein.faa -subject_besthit -qcov_hsp_perc 80 -max_target_seqs 1 -out mm-second.x.zebrafish_best.tsv -outfmt 6
```

Por favor, revise a documentação do BLAST. Quais campos ou colunas são exibidos quando o formato de saída é configurado como `outfmt 6`?

```
blastp -help
```

Lembre-se de que inicialmente tínhamos 100 sequências do camundongo para realizar o BLAST. Será que todas elas resultaram em correspondências (hits) contra o peixe-zebra (zebrafish)? Como poderíamos verificar isso?

Vamos alterar o formato de saída para incluir duas colunas adicionais que mostrarão os comprimentos das sequências _query_ e do _subject_. Posteriormente, utilizaremos essas informações para filtrar os resultados utilizando o comando [`awk`](https://www.howtogeek.com/562941/how-to-use-the-awk-command-on-linux/), para só manter os _hits_ onde pelo menos 80% do _subject_ participou do alinhamento com o _query_.

```
awk '$14*0.8 <= ($10-$9+1) {print $0}' mm-second.x.zebrafish_best.tsv > mm-second.x.zebrafish_best_subject80percent.tsv
```

Você pode identificar quantas proteínas _query_ se mantem nesse arquivo final? É quantas subject?

## Bioinfo 3 - Análise de dados de sequenciamento em larga escala

Crie uma nova pasta no seu HOME chamda `dia3`:

```
mkdir ~/dia3
cd ~/dia3
```

### Avaliando a qualidade de sequencias Illumina

Sempre que receber suas sequências da Illumina, é muito importante conferir a qualidade. Deve-se prestar atenção à presença de adaptadores (sequências adicionadas aos alvos de sequenciamento que precisam ser removidas antes de continuar com as análises), regiões de baixa qualidade (que geralmente também precisam ser removidas) e qualquer viés que possa levantar suspeitas sobre o sequenciamento. Os resultados da análise de qualidade sempre devem ser interpretados à luz do seu conhecimento sobre o tipo de amostra que foi sequenciada, incluindo os kits que foram usados para a criação das bibliotecas.

Vamos verificar diferentes métricas da qualidade de 4 corridas de sequenciamento nos arquivos:

- [qc1.fq.gz](files/qc1.fq.gz)
- [qc2.fq.gz](files/qc2.fq.gz)
- [qc3.fq.gz](files/qc3.fq.gz)
- [qc4.fq.gz](files/qc4.fq.gz)

Observe que os arquivos estão compactados, isso é sempre feito para economizar espaço de armazenamento. A maioria dos programas que iremos usar pode trabalhar com os dados nesse formato.

Baixe os arquivos e certifique-se de movê-los para a pasta `~/dia3`.

O comando `less` é capaz de visualizar até mesmo arquivos compactados. Vamos inspecionar o arquivo qc1.fq.gz, que deve estar na sua pasta `~/dia3`.

```
cd ~/dia3
less qc1.fq.gz
```

Este arquivo está no formato [FastQ](https://en.wikipedia.org/wiki/FASTQ_format), uma extensão do formato fasta, no qual cada sequência ocupa 4 linhas. A primeira linha contém o identificador da sequência, a segunda linha contém a sequência de nucleotídeos, a terceira linha é um espaço onde apenas o sinal `+` aparece, e a quarta linha contém caracteres que representam os valores de qualidade (Phred Score, Q) das bases correspondentes.

```
@SEQ_ID
GATTTGGGGTTCAAAGCAGTATCGATCAAATAGTAAATCCATTTGTTCAACTCACAGTTT
+
!''*((((***+))%%%++)(%%%%).1***-+*''))**55CCF>>>>>>CCCCCCC65
```

O formato FastQ pode de fato usar diferentes encodings para representar os valores de qualidade (Phred Scores). Os encodings mais comuns são o Sanger, o Illumina 1.8+ e o Solexa. Cada um deles utiliza uma escala de valores diferentes para representar a qualidade das bases nucleotídicas em uma sequência.

Para obter informações detalhadas sobre os diversos encodings do formato FastQ, recomendo que você acesse a página do [FastQ](https://en.wikipedia.org/wiki/FASTQ_format) na Wikipedia ou em outras fontes confiáveis de informações científicas ou bioinformáticas. Lá você encontrará uma descrição dos encodings e como eles são utilizados. É importante indicar o encoding correto para realizar operacoes nos arquivos de sequenciamento.

Agora, utilizaremos o comando `fastqc` para avaliar a qualidade dos arquivos de sequenciamento. Este software pode ser executado com ou sem uma interface gráfica. Primeiro, devemos ativar o ambiente Conda onde o `fastqc` está instalado e, em seguida, executar o programa no modo de linha de comando. Isso resultará na geração de dois arquivos: um em formato _.zip_ e outro em formato _.html_. O arquivo _.html_ pode ser visualizado em nosso navegador.

```
conda activate fastqc
fastqc qc1.fq.gz
```
você vai ter que executar o programa para cada um dos arquivos de sequenciamento (qc1.fq.gz, qc2.fq.gz, qc3.fq.gz e qc4.fq.gz).

Observe que o programa `fastqc` oferece diversos módulos de análise, como ilustrado na figura a seguir:

![fastqc_modules](images/fastqc_modules.png)

À esquerda de cada módulo, é exibido um símbolo que pode ser um _check_ (✓), um _exclamação_ (!), ou um _X_. O símbolo _!_ indica a necessidade de prestar uma atenção especial aos resultados deste módulo, pois ele parece apresentar aspectos que diferem do esperado. O símbolo _X_ indica que a análise identificou problemas nos dados.

#### qc1.fq.gz

Durante a análise dos dados no arquivo qc1.fq.gz, é evidente que a qualidade por posição (_Per base sequence quality_) decai significativamente em direção ao extremo 3'. Portanto, é altamente recomendado executar um processo de _qualitry trimming_ para eliminar as bases de menor qualidade, começando no extremo 3' e seguindo em direção ao 5'. Esse procedimento pode ser realizado eficazmente utilizando o programa `bbduk`.

![qc1.Per_base_sequence_quality](images/qc1.Per_base_sequence_quality.png)

#### qc2.fq.gz

A análise deste conjunto de dados revela que a qualidade dos dados é excelente e não é necessária nenhuma modificação nos dados brutos. Portanto, é seguro prosseguir com os próximos passos da análise sem problemas.

#### qc3.fq.gz

Da mesma forma que no arquivo qc1.fq.gz, o módulo "Per base sequence quality" detectou questões neste conjunto de dados, levando o pesquisador a considerar imediatamente a necessidade de executar o processo de "qualitry trimming".

O módulo "Per base sequence content" também foi identificado como relevante, e a análise deve ser interpretada à luz do tipo de dados e da química de sequenciamento para determinar se existem quaisquer problemas significativos. Este conjunto de dados foi gerado utilizando a tecnologia Nextera da Illumina, que, no processo de criação das bibliotecas, fragmenta o material de sequenciamento e adiciona os adaptadores em um único passo, conhecido como _tagmentation_. Saiba mais sobre essa tecnologia [aqui]((https://www.illumina.com/techniques/sequencing/ngs-library-prep/tagmentation.html)). Observe que em uma molécula grande de DNA, é esperado que a proporção de G seja igual à de C, e a proporção de A seja igual à de T. Nesta análise, podemos notar desvios dessa expectativa tanto na extremidade 5' quanto na extremidade 3', no entanto, os motivos para esses desvios são distintos. Qual é a sua opinião sobre a causa dessas discrepâncias? 

![qc3.Per_base_sequence_content](images/qc3.Per_base_sequence_content.png)

Para obter uma compreensão mais detalhada da discrepância observada na extremidade 3', recomendamos examinar os resultados dos módulos _Overrepresented sequences_ e _Adapter Content_. Você notará a presença de adaptadores nesses resultados, o que indica a necessidade de removê-los. Agora, por que você acredita que adaptadores estão surgindo nessa extremidade?

![qc3.adapters](images/qc3.adapters.png)

Nesse contexto, no processo de limpeza, é igualmente crucial eliminar as sequências de adaptadores.

Para realizar a limpeza, podemos utilizar o programa `bbduk.sh` da suíte `bbmap`. Para utilizá-lo, é necessário desativar qualquer ambiente Conda previamente ativado e ativar o ambiente `bbmap` da seguinte maneira:

```
conda deactivate
conda activate bbmap
bbduk.sh in=qc3.fq.gz ref=adapters.fa out=qc3.clean.fq.gz ktrim=r qtrim=w trimq=20 minlength=70 k=15
conda deactivate
```

Em seguida, verifique a qualidade das sequências limpas usando o `fastqc`. Execute este procedimento para todos os arquivos neste exercício.

### Analise de espectros de k-mers

Os [k-mer](https://en.wikipedia.org/wiki/K-mer) são sequências de DNA de tamanho _k_ encontradas em uma sequência maior. É importante observar que para obter todos os k-mer de uma sequência, você começa no primeiro nucleotídeo da sequência e pega os próximos k nucleotídeos. Em seguida, você desloca-se um nucleotídeo à frente e pega os k nucleotídeos, repete o processo até chegar no fim da sequencia, i.e., até não conseguir pegar k nucleotídeos. Vamos a listar todos os k-mer, com k=3, isto é vamos gerar o catálogo de k-mers da sequência abaixo:

```
Sequência:   ACGTAGCGTAGGT
3-mer 1:     ACG
3-mer 2:      CGT
3-mer 3:       GTA
3-mer 4:        TAG
3-mer 5:         TGC
3-mer 6:          GCG
3-mer 7:           CGT
3-mer 8:            GTA
3-mer 9:             TAG
3-mer 10:             AGG
3-mer 11:              GGT

```

Observe que a quantidade de k-mers distintos corresponde a 4 elevado à k potência (__4^k__). Ao analisar estatísticas relacionadas aos k-mers em dados brutos de sequenciamento, é viável adquirir _insights_ sobre as características do genoma em estudo, mesmo antes de iniciar o processo de montagem. Além disso, muitas dessas estimativas, obtidas por meio das estatísticas dos k-mers, podem informar e influenciar os procedimentos de montagem e anotação do genoma. Através do catálogo de k-mers, é possível calcular as frequências empíricas dos k-mers em um conjunto de dados, ou até mesmo em um genoma montado, resultando no espectro de k-mers desses dados. A frequência empírica dos k-mers na sequência acima é a seguinte:

```
k-mer	Freq
ACG	1
AGG	1
CGT	2
GCG	1
GTA	2
GGT	1
TAG	2
TGC	1
TTG	1
```

A partir da frequência empírica de k-mers, podemos calcular o espectro de k-mers, que nada mais é do que um histograma da coluna _Freq_ da tabela acima. Ou seja, o espectro de k-mers informa quantos k-mers distintos aparecem com uma frequência _x_ (multiplicidade ou profundidade), da seguinte maneira:

```
Número kmers	Multiplicidade
6		1
3		2
```

A partir das frequências empíricas dos k-mers e do espectro de k-mers, é possível estimar várias características do genoma, incluindo tamanho, heterozigosidade, fração do genoma composta por sequências repetitivas e ploidia. Para realizar essas estimativas, podemos utilizar ferramentas como o [GenomeScope2 e o SmudgePlots](https://www.nature.com/articles/s41467-020-14998-3/).

Os exercícios desta sessão estão baseados [neste](https://github.com/BGAcademy23/smudgeplot) tutorial. Nos próximos exercícios, utilizaremos os seguintes conjuntos de dados. A sala será dividida em grupos (de 1 a 8), e cada grupo deve baixar apenas o conjunto de dados correspondente na tabela. Após concluir a análise com seu conjunto de dados específico, é possível avançar para os outros conjuntos, se desejar.

command to dl the dataset
| Grupo | Espécie | SRR ACC | Comando para descarregar os dados | Artigo | 
| ---   | --- | --- | --- | --- | 
| 1 | _Pseudoloma neurophilia_ | SRR926312 | wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR926/SRR926312/SRR926312_[12].fastq.gz | [Ndikumana et al., 2017](https://pubmed.ncbi.nlm.nih.gov/27230544/) | 
| 2 | _Tubulinosema ratisbonensis_ | ERR3154977 | wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR315/007/ERR3154977/ERR3154977.fastq.gz  | [Polonais et al., 2019](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6675976/) | 
| 3 | _Nosema ceranae_ | SRR17317293 | wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR173/093/SRR17317293/SRR17317293_[12].fastq.gz  |
| 4 | _Nematocida parisii_ | SRR058692 | wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR058/SRR058692/SRR058692.fastq.gz  | [Cuomo et al., 2012](https://pubmed.ncbi.nlm.nih.gov/22813931/) |
| 5 | _Nematocida ausubeli_ | SRR350188 | wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR350/SRR350188/SRR350188_[12].fastq.gz  | [Cuomo et al., 2012](https://pubmed.ncbi.nlm.nih.gov/22813931/) |
| 6 | _Hamiltosporidium tvaerminnensis_ | SRR16954898 | wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR169/098/SRR16954898/SRR16954898_[12].fastq.gz  | [Angst et al., 2023](https://pubmed.ncbi.nlm.nih.gov/37565496/) |
| 7 | _Encephalitozoon hellem_ | SRR14017862 | wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/062/SRR14017862/SRR14017862_[12].fastq.gz  |
| 8 | _Agmasoma penaei_ | SRR926341 | wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR926/SRR926341/SRR926341_[12].fastq.gz  | [Sokolova et al., 2015](https://pubmed.ncbi.nlm.nih.gov/25449947/) |

Por favor, realize o download desses conjuntos de dados para a sua pasta `~/dia3`, criando uma subpasta chamada `espectro`.

```
cd ~/dia3
mkdir espectro
cd espectro
```

Para preparar o software que usaremos nesta sessão, precisamos garantir que o ambiente Conda do GenomeScope2 esteja ativado. Antes de fazer isso, lembre-se de desativar qualquer outro ambiente atualmente ativo.

```
conda deactivate
conda activate genomescope2
```

Vamos proceder com a instalação de uma ferramenta muito rápida para catalogar e contar k-mers, o FastK, bem como a versão de desenvolvimento do SmudgePlot:.

```
mkdir src bin && cd src # Crie diretórios para o código-fonte e os binários. 
git clone -b sploidyplot https://github.com/KamilSJaron/smudgeplot
git clone https://github.com/thegenemyers/FastK

cd smudgeplot
make -s INSTALL_PREFIX=/home/cen5789/miniconda3/envs/genomescope2/
R -e 'install.packages(".", repos = NULL, type="source")'
cd ..
smudgeplot.py -h # Teste se a instalação foi bem-sucedida.
cd FastK && make
install -c FastK Fastrm Fastmv Fastcp Fastmerge Histex Tabex Profex Logex Vennex Symmex Haplex Homex Fastcat /home/cen5789/miniconda3/envs/genomescope2/bin/
FastK # Teste se a instalação foi bem-sucedida.
cd ../.. 
pwd # Você tem que estar na pasta ~/dia3/espectro

```

#### Contando k-mers

Este processo opera com leituras de sequenciamento cruas ou limpas. A partir delas, geramos um banco de dados de k-mers usando o `FastK`. O FastK é um contador de k-mers muito rápido, tal vez o mais rápido hoje e é o único suportado pela versão mais recente do SmudgePlot (que instalamos acima). Este banco de dados contém um índice de todos os k-mers e suas coberturas no conjunto de leituras de sequenciamento. 

Então, por favor, construa o banco de dados utilizando o `FastK`. Este processo levará alguns minutos (15-20). Certifique-se de utilizar o arquivo de leituras correto, e eu recomendaria nomear o banco de dados com o número de acesso do SRA correspondente. Vamos realizar estas analises com varios valores de k:{17,21,31,41,51,71}, e vamos comparar os resultados. No `FastK` você pode modificar o tamanho do k-mer com o argumento `-k`.

```
FastK -v -t4 -k17 -M16 -T4 SRR926312_[12].fastq.gz -NSRR926312_k17
```

Agora, Você pode obter o espectro de k-mers a partir do banco de dados usando o Histex, uma ferramenta diferente da mesma suíte.

```
Histex -G SRR926312_k17 > SRR926312_k17.histo
```

Você pode visualizar o histograma criado com qualquer visualizador de arquivos de texto plano, e.g., `less`.

#### GenomeScope2

Agora com o arquivo `.histo`, podemos executar o GenomeScope2 para estimar algumas caracteristicas do genoma.

```
genomescope2 --input SRR926312_k17.histo --output SRR926312_k17.genomescope2 --ploidy 2 --kmer_length 17 --name_prefix SRR926312_k17
```

Visualize os arquivos de figuras. Uma delas é `SRR926312_k17.genomescope2/SRR926312_k17_linear_plot.png`:

![SRR926312_k17_linear_plot_genomescope2.png](images/SRR926312_k17_linear_plot_genomescope2.png)

Também é essencial prestar atenção ao arquivo "_summary.txt".

Observe que, para executar o GenomeScope2, precisamos especificar a ploidia do organismo. No entanto, nem sempre conhecemos essa característica com antecedência. Nesse caso, podemos usar o SmudgePlot para estimar o nível de ploidia e, em seguida, rodar o GenomeScope2 novamente. O resultado preliminar do GenomeScope2 pode nos auxiliar na identificação do limiar de k-mers incorretos, que é a cobertura/multiplicidade no primeiro vale do espectro de k-mers. O primeiro pico corresponde a uma grande quantidade de k-mers distintos, mas com baixa cobertura. Identifique o valor desse vale e continue com o SmudgePlot.

Por favor, adicione seus resultados do GenomeScope2 e do SmudgePlot ao [arquivo](https://docs.google.com/document/d/1Q4d3ZIBwFZmeN08x_8IXzcJhKjhbrwvyFXACuXcE2IM/edit?usp=sharing).

#### SmudgePlot

Do conjunto de k-mers e suas coberturas, o usuário deve escolher um limiar para excluir k-mers de baixa frequência que serão considerados erros. Essa escolha não é muito difícil de ser feita ao analisar o espectro de k-mers, podemos usar o espectro gerado anteriormente pelo GenomeScope2 para selecionar esse limiar. Agora, de todos os k-mers retidos, encontramos todos os het-mers. Em seguida, criamos um histograma 2D.

Neste exemplo, um limite de erro significativo seria 70x. Como regra geral, nenhum conjunto de dados deve ter esse limite inferior a 10x, e não é o fim do mundo se perdermos um pouco dos k-mers genômicos reais (desde que haja sinal suficiente). No entanto, essas são apenas algumas orientações; o que é sensato realmente depende de cada conjunto de dados individual!

O limite de erro é especificado pelo parâmetro '-L'. Temos 4 núcleos na nossa máquina, então você também pode executar a busca de pares de k-mers em paralelo (parâmetro -t). Ao executar, não se esqueça de usar os nomes de SUA amostra, e não o exemplo fornecido.

```
smudgeplot.py hetmers -L 70 -t 4 --verbose -o SRR926312_k17_pairs SRR926312_k17.ktab

```

E, por fim, uma vez que os pares de k-mers estejam prontos, um arquivo *_text.smu deve ser gerado. Trata-se de um histograma 2D, no qual para cada combinação de covA e covB, você encontrará a frequência com que essas duas coberturas ocorrem entre os het-mers (os pares de k-mers adjacentes um do outro).

```
head SRR926312_k17_pairs_text.smu
```

Se você ver três colunas, é um bom sinal. Você pode prosseguir para finalmente plotar o SmudgePlot. Eu encorajaria você a executar `smudgeplot plot -h` para ver todas as opções e entender o que elas significam, mas um comando minimalista como este deve funcionar:

```
smudgeplot.py plot -t SRR926312_k17 -o SRR926312_k17_smudgeplot SRR926312_k17_pairs_text.smu

```

![SRR926312_k17_smudgeplot_smudgeplot_log10](images/SRR926312_k17_smudgeplot_smudgeplot_log10.png)

Um gráfico com várias manchas (_smudges_) e anotações que se sobrepõem às manchas. No painel superior direito, você verá proporções de pares de k-meres nas manchas individuais, ordenadas por frequência. No canto inferior direito, você verá a estimativa de cobertura 1n para o conjunto de dados. Esta é a mesma cobertura 1n que foi inferida pelo GenomeScope; esses dois números precisam ser muito semelhantes para que o modelo e o SmudgePlot estejam contando a mesma história. Se eles forem substancialmente diferentes, é necessário investigar o motivo. Em genomas diferentes, o SmudgePlot ou o GenomeScope são melhores para determinar a cobertura, e geralmente as diferenças são em uma ordem de magnitude de 2. Se você acha que a estimativa de cobertura do SmudgePlot está errada, execute o SmudgePlot novamente com o parâmetro '-n' e forneça um número correspondente ao pico 1n em seu gráfico GenomeScope, como '-n 50'.

Neste exemplo, o SmudgePlot sugere um organismo tetraploide, mas observe que a proporção de hetmers diploides e tetraploides é a mesma. Tente executar o GenomeScope2 com ploidia 4 e compare os resultados de ajuste do modelo. Contraste os resultados dos outros valores de k.

## Bioinfo 4 - Montagem _de novo_ de genomas

Vamos trabalhar na pasta ~/dia4. Caso ela não exista, por favor, crie-a em sua pasta HOME.

### Obtendo os dados e calculando métricas do genoma

Vamos montar o genoma de uma levedura, a _Kazachstania bulderi_ da cepa NRRL Y-27205 ([Balarezo-Cisneros et al., 2023])(https://www.nature.com/articles/s42003-023-05285-0). Para começar, precisaremos baixar os dados do [_Short Read Archive_ (SRA)](https://www.ncbi.nlm.nih.gov/sra/), um banco de dados do NCBI que armazena informações brutas de sequenciamento em larga escala.

```
conda activate sratoolkit
fasterq-dump --threads 3 --progress --outfile SRR25033384.fq SRR25033384
conda deactivate
gzip SRR25033384.fq
```

No primeiro passo, vamos remover os resíduos dos adaptadores da biblioteca utilizando o software HiFiAdapterFilt. Para fazer isso, primeiro precisamos instalar o software.

```
conda activate blast
git clone https://github.com/sheinasim/HiFiAdapterFilt.git
export PATH=$PATH:$HOME/dia4/HiFiAdapterFilt/:$HOME/dia4/HiFiAdapterFilt/DB
bash HiFiAdapterFilt/pbadapterfilt.sh -t 4 -p SRR25033384
conda deactivate
```

Você pode conferir o arquivo `SRR25033384.stats` para obter um resumo do processo de limpeza. Agora, vamos continuar com o arquivo `SRR25033384.filt.fastq.gz`.

Vamos processá-lo com o GenomeScope2 para obter uma ideia das principais métricas do genoma e usar o SmudgePlot para verificar a ploidia. Lembre-se de que instalamos o SmudgePlot na semana passada. Se isso não funcionou, tente novamente. Lembre-se de escolher corretamente o parámetro `-L` para o `smudgeplot.py`.

```
conda activate genomescope2
FastK -v -t16 -k31 -M16 -T4 SRR25033384.filt.fastq.gz -NSRR25033384_k31
Histex -G SRR25033384_k31 > SRR25033384_k31.histo
genomescope2 --input SRR25033384_k31.histo --output SRR25033384_k31.genomescope2 --ploidy 2 --kmer_length 31 --name_prefix SRR25033384_k31
smudgeplot.py hetmers -L 18 -t 4 --verbose -o SRR25033384_k31_pairs SRR25033384_k31.ktab
smudgeplot.py plot -t SRR25033384_k31 -o SRR25033384_k31_smudgeplot SRR25033384_k31_pairs_text.smu
conda deactivate
```

| GenomeScope | SmudgePlot | 
| --- | --- |
| ![GenomeScope SRR25033384 ](images/SRR25033384_k31_transformed_linear_plot.png) | ![SmudgePlot SRR25033384](images/SRR25033384_k31_smudgeplot_smudgeplot_log10.png) |

Lembre-se de que a cobertura do genoma 1n (monoploide) deve ser a mesma detectada tanto pelo SmudgePlot quanto pelo GenomeScope. Se houver uma discrepância, é necessário investigar o que está ocorrendo.

Neste caso, parece que temos um claro genoma diploide, com uma cobertura do genoma monoploide de aproximadamente 38x e uma alta taxa de heterozigosidade.

### A montar!

Vamos prosseguir com o processo de montagem. Utilizaremos dois montadores e compararemos os resultados: o [HiFiASM](https://github.com/chhylp123/hifiasm) e o [Flye](https://github.com/fenderglass/Flye). Metade da equipe usará um montador, e a outra metade usará o outro.

#### Hifiasm

```
conda activate hifiasm
hifiasm -f0 -o NRRLY27205.asm -t 5 SRR25033384.fq.gz >  NRRLY27205.hifiasm.log 2> NRRLY27205.hifiasm.log
awk '/^S/{print ">"$2;print $3}' NRRLY27205.asm.bp.hap1.p_ctg.gfa > NRRLY27205.asm.bp.hap1.p_ctg.fa
awk '/^S/{print ">"$2;print $3}' NRRLY27205.asm.bp.hap2.p_ctg.gfa > NRRLY27205.asm.bp.hap2.p_ctg.fa
awk '/^S/{print ">"$2;print $3}' NRRLY27205.asm.bp.p_ctg.gfa > NRRLY27205.asm.bp.p_ctg.fa
conda deactivate
```

A montagem deve levar cerca de 30 minutos, considerando o uso de 5 threads e requerendo aproximadamente 16 GB de RAM.

#### Flye

```
conda activate flye
flye  --threads 5 --pacbio-hifi SRR25033384.filt.fastq.gz --out-dir NRRLY27205.flye > NRRLY27205.flye.log 2> NRRLY27205.flye.log
conda deactivate

```

A montagem deve levar cerca de 45 minutos, considerando o uso de 5 threads e requerendo aproximadamente 7.5 GB de RAM.

### Examinando as montagens.

Interaja com a equipe que usou um montador diferente e procure identificar as diferenças entre as montagens realizadas por ambos os softwares.

Para visualizar as montagens, você pode usar ferramentas específicas, como o software Bandage, que é útil para visualizar gráficos de montagem de genomas. Certifique-se de instalar o Bandage e, em seguida, utilize-o para carregar os resultados das montagens produzidas pelos montadores HiFiASM e Flye. Isso permitirá que você examine e compare as montagens de forma mais detalhada.

Utilize o Bandage para visualizar os arquivos GFA. Certifique-se de ativar o ambiente do Bandage após desativar qualquer outro ambiente utilizado anteriormente. O Bandage é um software com interface gráfica. Carregue o gráfico da montagem (Load Graph) e, em seguida, desenhe o gráfico (Draw Graph). Não deixe de discutir suas observações e resultados com seu instrutor e colegas.

```
conda deactivate
conda activate bandage
Bandage
```

#### Métricas de continuidade

Certifique-se de copiar a montagem realizada com o outro programa antes de calcular as métricas. Você precisará dos seguintes arquivos:

- `assembly.fasta` gerado pelo Flye
- `NRRLY27205.asm.bp.hap1.p_ctg.fa`, `NRRLY27205.asm.bp.hap2.p_ctg.fa` e `NRRLY27205.asm.bp.p_ctg.fa` gerados pelo HiFiasm

Esses arquivos são essenciais para a análise das métricas de montagem.

```
conda activate quast
quast.py --fungus --est-ref-size 13000000 --threads 5 NRRLY27205.asm.bp.hap1.p_ctg.fa NRRLY27205.asm.bp.hap2.p_ctg.fa NRRLY27205.asm.bp.p_ctg.fa NRRLY27205.flye/assembly.fasta
conda deactivate
```
Revisite o arquivo report.html e analise cuidadosamente os valores de NG50 e o tamanho total da montagem. Certifique-se de inspecionar minuciosamente essas métricas a fim de assegurar a precisão e qualidade da montagem.

#### Métricas de completude

##### Espaço gênico

```
conda activate compleasm
compleasm run -a NRRLY27205.asm.bp.hap1.p_ctg.fa -o NRRLY27205.asm.bp.hap1.p_ctg.compleasm -l saccharomycetes -t 5
compleasm run -a NRRLY27205.asm.bp.hap2.p_ctg.fa -o NRRLY27205.asm.bp.hap2.p_ctg.compleasm -l saccharomycetes -t 5
compleasm run -a NRRLY27205.asm.bp.p_ctg.fa -o NRRLY27205.asm.bp.p_ctg.compleasm -l saccharomycetes -t 5
compleasm run -a NRRLY27205.flye/assembly.fasta -o NRRLY27205.flye/assembly.compleasm -l saccharomycetes -t 5
conda deactivate
```

Por favor, elabore uma tabela que apresente os resultados obtidos com o `compleasm`.

#### Telômeros

Vamos verificar a presença de telômeros nos maiores contigs da montagem. Primeiramente, iremos realizar uma filtragem na montagem, mantendo apenas os contigs com um tamanho superior a 100 Kbp. Vamos utilizar uma combinação do programa `infoseq` do EMBOSS e a linguagem `awk` para extrair essas sequências. Certifique-se de executar esse processo para todos os arquivos FASTA das montagens."

```
conda activate emboss
infoseq -auto -noheading -only -name -length NRRLY27205.asm.bp.hap1.p_ctg.fa | sed -r 's/ +/\t/g'| \
awk '$2 >= 100000 {print "NRRLY27205.asm.bp.hap1.p_ctg.fa:"$1}' > NRRLY27205.asm.bp.hap1.p_ctg.g100kbp.ids

seqret @NRRLY27205.asm.bp.hap1.p_ctg.g100kbp.ids NRRLY27205.asm.bp.hap1.p_ctg.g100kbp.fasta
conda deactivate
```

A repetição telomérica em fungos é notavelmente variável e irregular, especialmente no subfilo Saccharomycotina, onde elas se caracterizam por serem longas, altamente degeneradas e divergentes das repetições canônicas ([Steinberg-Neifach e Lue, 2015](https://pubmed.ncbi.nlm.nih.gov/25983743/); [Lue, 2021](https://www.frontiersin.org/articles/10.3389/fgene.2021.638790/full)).

Neste exercício, realizaremos uma busca por repetições que poderiam ser teloméricas, para isso utilizaremos o [_Telomere Identification Toolkit (TIDK)_](https://github.com/tolkit/telomeric-identifier).

Para cada uma das suas montagens no formato FASTA, siga as seguintes etapas:

```
conda activate tidk
tidk explore --minimum 4 --maximum 12 NRRLY27205.asm.bp.hap1.p_ctg.g100kbp.fasta
```

Analise os resultados e selecione a repetição mais abundante. Pode verificar se esta repetição identificada já foi encontrada nos telômeros de outros organismos [Telomerase Databasse](https://telomerase.asu.edu/sequences-telomere) ou no [TeloBase](http://cfb.ceitec.muni.cz/telobase/). Com essa repetição selecionada, vamos realizar uma busca e plotar sua posição ao longo dos contigs. Se for, de fato, uma repetição telomérica, ela deve ocorrer preferencialmente nas extremidades dos contigs.

```
tidk search --string ACACCCAT --output NRRLY27205.asm.bp.hap1.p_ctg.g100kbp.tidk.ACACCCAT --extension tsv --dir . NRRLY27205.asm.bp.hap1.p_ctg.g100kbp.fasta
conda deactivate
```

Agora, vamos representar graficamente o número de repetições encontradas ao longo dos maiores contigs, que podem ser potencialmente cromossomos. Certifique-se de fazer o download do script [plotTelomericRepeatPositions.R](plotTelomericRepeatPositions.R) do repostitório:

```
mv ~/Downloads/plotTelomericRepeatPositions.R ~/dia4
conda activate genomescope2
Rscript plotTelomericRepeatPositions.R NRRLY27205.asm.bp.hap1.p_ctg.g100kbp.tidk.ACACCCAT_telomeric_repeat_windows.tsv
conda deactivate
evince Rplots.pdf
```
### Comparando as montagens

As métricas revelam diferenças significativas entre as montagens geradas pelo HiFiASM e pelo Flye. Além disso, é de grande interesse explorar as distinções entre as montagens dos haplótipos 1 e 2 do HiFiASM. Para obter representações visuais comparativas dessas montagens, aproveitaremos as capacidades do [JupiterPlot](https://github.com/JustinChu/JupiterPlot).

O JupiterPlot é uma ferramenta valiosa que nos permitirá criar gráficos e visualizações para analisar e comparar as montagens obtidas. Essas representações visuais tornarão mais fácil identificar e compreender as variações entre as montagens, tanto entre as diferentes ferramentas (HiFiASM e Flye) quanto dentro das montagens do mesmo haplótipo (haplótipos 1 e 2 do HiFiASM). Essa abordagem visual fornecerá insights importantes para nossas análises e ajudará a orientar a próxima etapa de nosso projeto.

```
conda activate jupiterplot
git clone https://github.com/JustinChu/JupiterPlot.git
JupiterPlot/jupiter t=5 m=100000 name=primary_vs_hap1 ref=NRRLY27205.asm.bp.p_ctg.fa fa=NRRLY27205.asm.bp.hap1.p_ctg.fa  ng=100 minBundleSize=5000
JupiterPlot/jupiter t=5 m=100000 name=primary_vs_hap2 ref=NRRLY27205.asm.bp.p_ctg.fa fa=NRRLY27205.asm.bp.hap2.p_ctg.fa  ng=100 minBundleSize=5000
JupiterPlot/jupiter t=5 m=100000 name=hap1_vs_hap2 ref=NRRLY27205.asm.bp.hap1.p_ctg.fa fa=NRRLY27205.asm.bp.hap2.p_ctg.fa  ng=100 minBundleSize=5000
JupiterPlot/jupiter t=5 m=10000 name=flye_vs_primary ref=NRRLY27205.flye/assembly.fasta fa=NRRLY27205.asm.bp.p_ctg.fa ng=100 minBundleSize=5000
conda deactivate
```

Aqui está a figura que compara a montagem principal (primary assembly) com o haplótipo 1 do HiFiASM. Por favor, dê uma olhada nas outras figuras para uma análise completa. Cada uma delas oferece insights valiosos sobre as diferenças e semelhanças entre as montagens, e juntas, elas nos ajudarão a compreender melhor a qualidade e precisão das montagens geradas.

![jupiterplot_primary_vs_hap1](images/jupiterplot_primary_vs_hap1.png)

## Bioinfo 5 -  Genome annotation

Certifique-se de que todos os exercícios desta seção sejam executados dentro da pasta `~/dia6`. Se essa pasta não existe, crie-a antes de começar os exercícios. Isso garantirá que você esteja organizando seus arquivos da maneira apropriada.

### Realize a avaliação de contaminações.

Antes de prosseguirmos com a anotação estrutural, é crucial aprimorar nossa avaliação das montagens. Para isso, é de extrema importância realizar uma análise detalhada da possível contaminação por meio da ferramenta [BlobToolKit](https://github.com/blobtoolkit/blobtoolkit). Essa etapa adicional de avaliação nos permitirá garantir a qualidade e confiabilidade das montagens, fornecendo uma visão abrangente da integridade dos dados genômicos. Por razões de tempo, optaremos por pular esta etapa hoje, mas é fundamental ressaltar que em projetos reais, a execução desta análise é essencial.

### Mascare repetições

Antes de realizar a predição de genes, é imperativo mascarar os scaffolds/contigs da montagem por meio de uma biblioteca de repetições adaptada ao genoma em questão. Entre as estratégias frequentemente empregadas, destacam-se o uso do [RepeatModeler](https://github.com/Dfam-consortium/RepeatModeler)/[RepeatMasker](https://www.repeatmasker.org/), [EDTA](https://github.com/oushujun/EDTA) e [Earl Grey](https://github.com/TobyBaril/EarlGrey). No entanto, é importante observar que esse processo costuma demandar considerável capacidade computacional. Por isso, hoje optaremos por omiti-lo.

### Obter evidência extrínseca - Proteínas de espécies próximas.

Vamos anotar apenas a montagem que apresentar as melhores métricas de completude e continuidade.

Faça o download de todas as proteínas do mesmo gênero no NCBI. Para fazer isso, acesse o banco de dados de taxonomia do NCBI em seu navegador e procure pelo nome do gênero _Kazachstania_ na lista de nomes. Clique no nome do gênero, conforme mostrado na figura:

![GetProteinsFromTaxonomy_1](images/GetProteinsFromTaxonomy_1.png)

Na página em que você chegou, identifique a tabela que mostra a figura, onde todos os registros associados a esse gênero em outros bancos de dados do NCBI estão listados. Clique na seção "Proteins", onde deve haver um número aproximado de 53.000 proteínas.

![GetProteinsFromTaxonomy_2](images/GetProteinsFromTaxonomy_2.png)

Finalmente descarregue um arquivo com essas proteinas em formato fasta.

![GetProteinsFromTaxonomy_2](images/GetProteinsFromTaxonomy_2.png)

### Anotando o Genoma - GALBA

Vamos a anotar o genoma usando [GALBA](https://github.com/Gaius-Augustus/GALBA). Outras alternativas incluem o uso do [BRAKER](https://github.com/Gaius-Augustus/BRAKER) ou [EASEL](https://gitlab.com/PlantGenomicsLab/easel), porém, essas ferramentas exigem dados de RNA-Seq e são mais intensivas em termos computacionais. Em cenários reais, a recomendação é empregar várias estratégias e gerar um conjunto de genes previstos com base nos melhores resultados das ferramentas, utilizando, por exemplo [EVidenceModeler](https://github.com/EVidenceModeler/EVidenceModeler). Sempre é importante utilizar evidência extrínseca, e na maioria dos casos, o RNA-Seq é a fonte de dados que oferece os melhores resultados.

Vamos usar um container do singularity para rodar mais facilmente o GALBA, para que isso funcione linque os arquivos de montagem do genoma e as proteínas para o diretório HOME.

```
conda activate singularitycew
#singularity build galba.sif docker://katharinahoff/galba-notebook:latest
singularity shell -B $PWD:$PWD galba.sif
cp -r $AUGUSTUS_CONFIG_PATH/ /home/cen5789/dia5/augustus
export AUGUSTUS_CONFIG_PATH=/home/cen5789/dia5/augustus
galba.pl --threads=10 --species=KazachstaniaBulderi --genome=NRRLY27205.asm.bp.hap1.p_ctg.g100kbp.fasta --prot_seq=sequence.fasta
exit
conda deactivate
```

Você pode encontrar o rfesultado da previsão de genes na pasta GALBA. A saída do programa GALBA é gerada principalmente em três arquivos distintos:

- galba.gtf
- galba.codingseq
- galba.aa

A previsão de genes para GALBA pode levar um tempo considerável. Portanto, estou disponibilizando os principais arquivos de resultados neste [arquivo](files/GALBA_annotation.tar.gz).

Por favor, analise esses arquivos para compreender o conteúdo presente. Discuta com seus colegas e seu professor para obter uma compreensão completa.

Após o primeiro passo de anotação estrutural do genoma, é fundamental avaliar a qualidade da anotação. Uma maneira de realizar essa avaliação é examinando a completude. Nesse contexto, esperamos que o nível de completude da anotação seja pelo menos tão bom quanto a análise da completude do espaço gênico durante a avaliação do genoma. Lembre-se de que, anteriormente, avaliamos o genoma com o software `compleasm`. No entanto, a versão atual desse programa é destinada exclusivamente à avaliação de genomas. Para avaliar a previsão de genes, utilizaremos o [BUSCO](https://busco.ezlab.org/). Para isso, faremos uso de uma imagem do BUSCO executando com o Singularity, o que simplifica significativamente a instalação do software.

```
conda activate singularitycew
#singularity build busco.sif docker://ezlabgva/busco:v5.5.0_cv1
singularity shell -B $PWD:$PWD busco.sif
busco -i GALBA/galba.aa -o GALBA_BUSCO -m protein -l saccharomycetes_odb10 --cpu 10
exit
conda deactivate
```

Os resultados do BUSCO estão disponíveis na pasta GALBA_BUSCO. Por favor, examine os vários arquivos e discuta-os com seus colegas e seu professor. Compare os resultados do BUSCO das proteínas previstas com os resultados do `compleasm` para o genoma montado. Quantos genes foram preditos?

Com a conclusão da anotação estrutural, estamos prontos para iniciar a anotação funcional. Para isso, faremos uso do banco de dados [EGGNOG](http://eggnog5.embl.de/) e da ferramenta de software [Eggnog-Mapper](http://eggnog-mapper.embl.de/). Procederemos à anotação das proteínas preditas, ou seja, dos produtos gênicos, utilizando os dados relacionados aos fungos do EGGNOG.". Antes de avançarmos nos exercícios, é essencial realizar a conversão do arquivo de anotação gerado por GALBA, que está no formato GFF, para o formato GTF. Faremos essa conversão utilizando a ferramenta `gffread`. Isso é um passo importante antes de prosseguir.

```
conda activate eggnogmapper
export EGGNOG_DATA_DIR=/home/cen5789/dia6
download_eggnog_data.py -P  -y
emapper.py  -m diamond --cpu 10 --itype proteins -i GALBA/galba.aa -o GALBA_EGGNOG --decorate_gff GALBA/galba.gtf --target_orthologs all --tax_scope 4751
conda deactivate
```

O que significa o número 4751? Consulte o banco de dados de [taxonomia do NCBI](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=4751).

É importante observar que o EGGNOG Mapper pode exigir recursos computacionais significativos, especialmente em termos de tempo de execução. Os arquivos de resultados estão disponíveis [aqui](files/GALBA_EGGNOG_FUNGI.tar.gz).

Agora, procederemos à visualização da montagem, juntamente com as leituras mapeadas nela e a anotação estrutural do genoma, usando o [Integrative Genomics Viewer (IGV)](https://igv.org/). Primeiro vamos mapear as leituras no genoma usando o `minimap2` e o `samtools`. Favor fazer uma cópia do seu arquivo de leituras na pasta de trabalho 'dia6'.

```
conda activate jupiterplot
minimap2 -H -x map-hifi -a -t 10 NRRLY27205.asm.bp.hap1.p_ctg.g100kbp.fasta SRR25033384.filt.fastq.gz | samtools view -b --fast --threads 6 |samtools sort --threads 6 -o NRRLY27205.asm.reads.sorted.bam
samtools index NRRLY27205.asm.reads.sorted.bam
conda deactivate
```

Agora podemos inicializar o IGV, que tem ambiente gráfico. Primeiramente, carregaremos a montagem no menu __"File"__ -> __"Load From File"__, utilizando o arquivo `NRRLY27205.asm.bp.hap1.p_ctg.g100kbp.fasta`. Em seguida, utilizando o mesmo menu, procederemos ao carregamento do arquivo com as leituras mapeadas, denominado `NRRLY27205.asm.reads.sorted.bam`. Por fim, carregaremos o arquivo contendo a anotação do genoma a partir de `GALBAL/galba.gtf`.

```
conda activate igv
igv
```

Por exemplo, localize o contig h1tg000003l nas posições que vão de 988,344 até 1,001,558. Quais são os significados das regiões coloridas nas leituras? E qual é a interpretação das regiões roxas?" O que representa a região marcada com o número 8.024? É possível que haja um gene anotado nesta região?

![IGV screenshot](images/igv_snapshot.png)

Combine os contigs com mais de 100 kbp dos dois haplótipos (hap1 e hap2) em um único arquivo e, posteriormente, mapeie as leituras contra este arquivo. Você consegue identificar alguma diferença nos resultados?

## Bioinfo 6 - Gene Ortólogos

Vamos agora explorar com mais profundidade o uso de genes ortólogos. Para isso, utilizaremos o [OMA (Orthologous Matrix)](https://oma-stage.vital-it.ch/oma/home/) no seu navegador. O projeto OMA é uma ferramenta e banco de dados para a inferência de ortólogos entre genomas completos.

O algoritmo de inferência do OMA envolve três etapas principais. Primeiro, ele calcula alinhamentos Smith-Waterman entre todas as sequências para identificar correspondências significativas, inferindo sequências homólogas. Em seguida, ele determina pares ortólogos, que são homólogos relacionados por eventos de especiação, levando em conta distâncias evolutivas e a incerteza na inferência de distâncias. Por fim, os ortólogos são agrupados de duas maneiras: em "grupos OMA" que servem como genes marcadores para reconstrução filogenética e em "HOGs" que representam grupos de genes comuns em niveis taxonômicos específicos.

Nesta sessão, vamos resolver os exercícios do [Módulo 1 do treinamento do OMA](https://oma-stage.vital-it.ch/oma/academy/module/OMA_browser_2023). 

Para resolver esses exercícios, é altamente recomendado consultar regularmente as páginas de ajuda do OMA: "[Orthology Basics](https://omabrowser.org/oma/type/)," "[Types of homologs](https://omabrowser.org/oma/homologs/)," "[Access the OMA Data](https://omabrowser.org/oma/uses/)," "[Catalog of Tools](https://omabrowser.org/oma/tools/)," e "[Glossary](https://omabrowser.org/oma/glossary/)." Elas fornecerão informações valiosas para concluir com êxito os exercícios do Módulo 1.


## Bioinfo 7 - Transcriptômica

Vamos analisar a resposta dos genes de Arabidopsis thaliana considerando dois fatores: 1) o genótipo e 2) o estresse ambiental. O fator genótipo é composto por três níveis: 1.a) selvagem, 1.b) mutante no gene ros1-3, 1.c) duplo mutante nos genes dml2 e dml3, e 1.d) triplo mutante nos genes ros1, dml2 e dml3. Enquanto o fator estresse ambiental possui também quatro níveis: 2.a) sem tratamento, 2.b) tratamento com ácido abscísico, 2.c) tratamento com cloreto de sódio e 2.d) tratamento com seca. [Mais detalhes](https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-MTAB-4477/). Os transcritos em cada condição foram sequenciados usando a tecnologia Illumina, resultando na geração de leituras em pares (paired-end), e os dados estão disponiveis no [SRA](https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=282863).

Crie uma pasta com o nome `dia7` dentro do diretório $HOME. Todos os exercícios de hoje devem ser realizados dentro dessa pasta.

```
cd
mkdir dia7
cd  dia7
```

### Descarregando os dados de repositórios públicos

Anteriormente, utilizamos funcionalidades do SRA Toolkit para baixar dados do SRA. Agora, vamos empregar outra ferramenta que pode agilizar ainda mais o processo em comparação com o fasterq-dump que usamos anteriormente. Utilizaremos a ferramenta [`ffq`](https://github.com/pachterlab/ffq), a diferença, em relação ao fasterq-dump, faz o download dos dados diretamente no formato fastq. 

Vamos analisar dados de RNASeq de mutantes de _Arabidopsis thaliana_ em diversas condições ambientais. Os mutantes ros1-3, dml2 e dml3 são alelos mutantes que resultam na perda de função dos genes ROS1, DML2 e DML3, que fazem parte da família DEMETER (DME). Essa família está envolvida no processo de desmetilação do DNA.

O ROS1 atua como um repressor do silenciamento da expressão gênica. Sua função envolve a remoção da metilação do DNA do promotor do gene alvo. Ele interage fisicamente com RPA2/ROR1. Nos mutantes _ros1_ (como _ros1-3_), é observado um aumento na metilação nos promotores de vários genes. Dentre os loci afetados por _ros1_, alguns (RD29A e At1g76930) sofrem alterações na metilação de citosina em todos os contextos de sequência (CpG, CpNpG ou CpNpN), embora muitos outros sejam afetados principalmente em contextos não-CpG. O mutante _ros1_ demonstra maior suscetibilidade a patógenos biotróficos e possui redução em sua capacidade de resposta aos genes de defesa dependentes do ácido salicílico. O _ros1-3_ é um alelo de T-DNA, onde o T-DNA está inserido no gene ROS1, gerando a perda de funcão. ([Penterman, et al., 2007](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1847597/), [TAIR - AT2G36490](https://arabidopsis.org/servlets/TairObject?id=32321&type=locus)).

Os genes DML2 ([AT3G10010](https://arabidopsis.org/servlets/TairObject?id=40110&type=locus)) e DML3 ([AT4G34060](https://arabidopsis.org/servlets/TairObject?id=127923&type=locus)) são homólogos de ROS1. Mutacões nos genes DML resultam em hipermetilação do DNA em locais específicos. Dos locais desmetilados pelas enzimas DML, mais de 80% estão próximos ou se sobrepõem a genes. A desmetilação gênica pelas enzimas DML ocorre principalmente nas extremidades 5' e 3', um padrão oposto à distribuição geral da metilação de DNA do tipo selvagem ([Penterman, et al., 2007](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1847597/)).


A tabela a seguir apresenta uma lista dos números de acesso do SRA para cada amostra, juntamente com uma descrição das condições experimentais às quais foram submetidas.

| Number | Identifiers | Genotype | Environmental Stress | 
| --- | --- | --- | --- |
| 01 | DRR016125 | wild type | None |
| 02 | DRR016126 | wild type | abscisic acid |
| 03 | DRR016127 | wild type | sodium chloride |
| 04 | DRR016128 | wild type | drought |
| 05 | DRR016129 | ros1-3 mutant | none |
| 06 | DRR016130 | ros1-3 mutant | abscisic acid |
| 07 | DRR016131 | ros1-3 mutant | sodium chloride |
| 08 | DRR016132 | ros1-3 mutant | drought |
| 09 | DRR016133 | dml2, dml3 double mutant | none |
| 10 | DRR016134 | dml2, dml3 double mutant | abscisic acid |
| 11 | DRR016135 | dml2, dml3 double mutant | sodium chloride |
| 12 | DRR016136 | dml2, dml3 double mutant | drought |
| 13 | DRR016137 | ros1, dml2, dml3 triple mutant | none |
| 14 | DRR016138 | ros1, dml2, dml3 triple mutant | abscisic acid |
| 15 | DRR016139 | ros1, dml2, dml3 triple mutant | sodium chloride |
| 16 | DRR016140 | ros1, dml2, dml3 triple mutant | drought |

Vamos descarregar os links de acceso dos aruivos em formato `fastq.gz` para a mostra DRR016125. Para isso, é necessário ativar o ambiente Conda denominado "transcriptomics," no qual estão instalados todos os softwares que utilizaremos nas próximas semanas.

```
conda activate transcriptomics
ffq --ftp DRR016125
```

Isso deve gerar uma saída semelhante a esta:

```
[2023-11-07 00:19:53,630]    INFO Parsing run DRR016125
[
    {
        "accession": "DRR016125",
        "filename": "DRR016125_1.fastq.gz",
        "filetype": "fastq",
        "filesize": 967794560,
        "filenumber": 1,
        "md5": "36beaacaff3a9903d5c57a2c73525ae8",
        "urltype": "ftp",
        "url": "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR016/DRR016125/DRR016125_1.fastq.gz"
    },
    {
        "accession": "DRR016125",
        "filename": "DRR016125_2.fastq.gz",
        "filetype": "fastq",
        "filesize": 1001146319,
        "filenumber": 2,
        "md5": "d3f0203f534e35fa370b2a6c5e238944",
        "urltype": "ftp",
        "url": "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR016/DRR016125/DRR016125_2.fastq.gz"
    }
]
```

Observe que existem duas linhas que começam com "url":, que são os endereços dos arquivos fastq.gz na internet, localizados no servidor do SRA do Instituto Europeu de Bioinformática. Você pode usar esses endereços com o programa "wget" ou "curl" para fazer o download dos arquivos para o seu computador. Isso precisaria ser repetido para cada uma das amostras deste experimento.

Como esses arquivos são pesados, o professor já os baixou em um servidor do [CENA](http://labbces.cena.usp.br/CEN5789/transcriptomics/RAWREADS). Os arquivos contendo as leituras de todas as amostras requerem aproximadamente 30GB de armazenamento, um espaço que talvez não esteja disponível nos computadores que estamos usando. Portanto, cada aluno fará o download de apenas um par de arquivos (R1 e R2) de uma única amostra e trabalhará apenas com eles. Dessa forma, iremos paralelizar nosso trabalho, executando os processos de verificação de qualidade, limpeza e quantificação. Após a quantificação, compartilharemos os resultados de modo que todos os alunos tenham acesso às quantificações de todos os genes em todas as amostras. Siga as instruções do professor. 

Faça o download dos seus dados na pasta "RAWREADS" dentro da pasta "dia7". Se essa pasta ainda não existir, crie-a. Lembre que estamos usando o ambiente conda chamado `transcriptomics`. Lembre-se também de substituir o identificador da SUA amostra.

```
mkdir -p ~/dia7/RAWREADS
cd ~/dia7/RAWREADS
ID=DRR016125
curl -O http://labbces.cena.usp.br//CEN5789/transcriptomics/RAWREADS/${ID}_[1-2].fastq.gz

```

### Pre-processando os dados de RNASeq

Vamos a conferir a qualidade do sequenciamento usando o programa `fastqc`

```
cd ~/dia7/
mkdir FastQC_pre
fastqc --threads 2 --nogroup  --outdir FastQC_pre RAWREADS/${ID}_[1-2].fastq.gz
```

Visualize os resultados e tome as decisões necessárias para realizar a limpeza das leituras. Lembre-se de que as bibliotecas dessas amostras foram criadas usando a tecnologia [TruSeq](https://www.illumina.com/content/dam/illumina-marketing/documents/products/datasheets/datasheet_truseq_sample_prep_kits.pdf), que pesca MRNA poliadenilados, e o cDNA foi gerado com iniciadores aleatórios (_random primers_).

Agora, vamos proceder com a limpeza usando o programa `bbduk` da suíte "bbmap". A qualidade das leituras, em termos da distribuição do escore Phred, está muito boa, e acredito que não seja necessário realizar o processo de _quality trimming_. No entanto, foi detectada a presença residual de adaptadores no extremo 3' em algumas amostras, os quais precisam ser removidos. Além disso, é aconselhável quantificar a quantidade de leituras que têm origem no rRNA, pois isso pode fornecer uma indicação da qualidade das amostras ainda nesta etapa de limpeza.

Primeiro removemos adaptadores:

```
cd ~/dia7
bbduk.sh in=RAWREADS/${ID}_1.fastq.gz in2=RAWREADS/${ID}_2.fastq.gz out=CLEANREADS/${ID}_cleana_1.fastq.gz out2=CLEANREADS/${ID}_cleana_2.fastq.gz ref=adapters refstats=CLEANREADS/${ID}_cleana_adapters_refstats ktrim=r threads=10
```

Agora, vamos filtrar (excluir) as leituras que correspondem ao rRNA, utilizando como entrada as leituras nas quais os adaptadores foram removidos no passo anterior. Mas antes de prosseguirmos, é necessário fazer o download do banco de dados contendo as sequências de rRNA. Este banco é derivado do [SILVA NR](https://www.arb-silva.de/), e as sequências foram agrupadas com 90% de identidade.

```
cd ~/dia7
mkdir -p ~/dia7/References
cd ~/dia7/References
wget http://labbces.cena.usp.br//CEN5789/transcriptomics/References/rRNA.tar.gz
tar xvzf rRNA.tar.gz
rm -rf rRNA.tar.gz
cd ..
bbduk.sh in=CLEANREADS/${ID}_cleana_1.fastq.gz in2=CLEANREADS/${ID}_cleana_2.fastq.gz out=CLEANREADS/${ID}_cleanf_1.fastq.gz out2=CLEANREADS/${ID}_cleanf_2.fastq.gz ref=References/rRNA_LSU_SILVA_Archaea.nr90.fasta,References/rRNA_LSU_SILVA_Bacteria.nr90.fasta,References/rRNA_LSU_SILVA_Eukarya.nr90.fasta,References/rRNA_SSU_SILVA_Archaea.nr90.fasta,References/rRNA_SSU_SILVA_Eukarya.nr90.fasta,References/rRNA_SSU_SILVA_Bacteria.nr90.fasta ktrim=f threads=10  minlength=85 refstats=CLEANREADS/${ID}_cleanf_rRNA_refstats
```

Confira o arquivo `*_cleanf_rRNA_refstats` dentro da pasta `CLEANEADS`. Uma proporção elevada de leituras de rRNA pode indicar problemas com a amostra. Se teve algum problema realizando a limpeza das leituras, pode descarregar os arquivos já limpos [aqui](http://labbces.cena.usp.br//CEN5789/transcriptomics/CLEANREADS/).

### Estimando os Níveis de Expressão de Transcritos e Genes

Com as leituras limpas em mãos, podemos começar a planejar a estimativa dos níveis de expressão dos transcritos e/ou genes. Para esta tarefa, utilizaremos o programa [Salmon](https://salmon.readthedocs.io/en/latest/), que emprega a estratégia de "quasi-mapping", conhecida por sua alta precisão e rapidez. É importante notar que o Salmon realiza a comparação em relação a uma referência que consiste nas sequências dos transcritos de interesse e pode lidar com a estimativa de valores de expressão para sequências muito semelhantes.

Vamos baixar a versão mais recente do Salmon e instalá-la na pasta `~/dia7/`:

```
wget https://github.com/COMBINE-lab/salmon/releases/download/v1.10.0/salmon-1.10.0_linux_x86_64.tar.gz
tar xvzf salmon-1.10.0_linux_x86_64.tar.gz
rm salmon-1.10.0_linux_x86_64.tar.gz
export PATH=/home/cen5789/dia7/salmon-latest_linux_x86_64/bin/:$PATH
salmon
```

A última linha do bloco anterior deveria ter exibido a ajuda do programa, algo similar a:

```
salmon v1.10.0

Usage:  salmon -h|--help or
        salmon -v|--version or
        salmon -c|--cite or
        salmon [--no-version-check] <COMMAND> [-h | options]

Commands:
     index      : create a salmon index
     quant      : quantify a sample
     alevin     : single cell analysis
     swim       : perform super-secret operation
     quantmerge : merge multiple quantifications into a single file

```

A referência que usaremos é composta por todos os transcritos (cDNAs) anotados no genoma de _Arabidopsis thaliana_, os quais podem ser baixados do [TAIR](https://www.arabidopsis.org), também pode encontrar o arquivo [aqui](http://labbces.cena.usp.br//CEN5789/transcriptomics/References/TAIR10_cdna_20101214_updated.gz), descarreguelo dentro da sua pasta `~/dia7/` e dentro de uma subpasta chamada `References`. Esta referência precisa ser complementada com sequências decoy, ou seja, sequências que não deveriam estar presentes para a quantificação. Neste caso, usaremos o genoma completo como decoy. Recomendo a leitura [deste articulo](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-020-02151-8) aqui para entender a importância do uso de decoy em análises de RNASeq.

```
mkdir -p ~/dia7/References
cd ~/dia7/References
#Os transcritos
wget http://labbces.cena.usp.br//CEN5789/transcriptomics/References/TAIR10_cdna_20101214_updated.gz
#O genoma
wget http://labbces.cena.usp.br//CEN5789/transcriptomics/References/TAIR10_genome.fasta.gz
```

Vamos gerar um arquivo de texto contendo os identificadores das sequências que serão usadas como decoy:

```
grep "^>" <(gunzip -c TAIR10_genome.fasta.gz) | cut -d " " -f 1 > decoys.txt
sed -i.bak -e 's/>//g' decoys.txt
```

Em seguida, podemos construir o índice para que o Salmon possa realizar a quantificação dos transcritos:

```
salmon index -t gentrome.fa.gz -d decoys.txt -p 10 -i salmon_index --gencode
cd ../
```

Finalmente, podemos iniciar o processo de quantificação das amostras propriamente dito:

```
mkdir -p ~/dia7/quantification
cd ~/dia7/
salmon quant -i References/salmon_index -l A -1 CLEANREADS/${ID}_cleanf_1.fastq.gz -2 CLEANREADS/${ID}_cleanf_2.fastq.gz --validateMappings -o ~/dia7/quantification/${ID} --threads 10 --seqBias --gcBias
```

Isso criará a pasta `quantification/${ID}`. Dentro dela, por favor, verifique o arquivo `logs/salmon_quant.log` e identifique o tipo de biblioteca detectado pelo Salmon e a taxa de mapeamento. Vamos tabular os resultados [neste arquivo](https://docs.google.com/spreadsheets/d/1-fUxJtmPMlMUwqPslSh2tBKUKKr-uDXZS8YVf8W2wqc/edit?usp=sharing).

A quantificacao está disponivel no arquivo `~/dia7/quantification/${ID}/quant.sf`. Identifique as informações contidas no arquivo.

Agora, vamos compactar toda a pasta de quantificação e compartilhá-la com os colegas. Para isso, utilizaremos o programa `tar`. 

```
cd ~/dia7/quantification
tar cvzf ${ID}.tar.gz ${ID}
```

Copie o seu arquivo `${ID}.tar.gz` para a [pasta compartilhada no Google Drive](https://drive.google.com/drive/folders/134yKyPHqroURe4kxHm6HkCoaZTd8NjXR?usp=sharing). Lembre-se de substituir o identificador da SUA amostra (ID). Quando todos tiverem copiado seus arquivos, faremos o download e descompactaremos todos os arquivos na pasta `~/dia7/quantification/` para que possamos acessar a quantificação de todas as amostras.

### Vamos nos preparar para a detecção de GENES diferencialmente expressos.

Lembre-se de que a quantificação realizada pelo Salmon foi de transcritos, e a partir de um único gene, vários transcritos podem ser produzidos. Hoje, vamos realizar a detecção de GENES diferencialmente expressos nas condições experimentais. Por isso, precisamos indicar quais transcritos são originados a partir do mesmo gene, a fim de transformar as quantificações de cada transcrito em quantificações de cada gene. Basicamente, iremos somar as quantificações de todos os transcritos do mesmo gene.

Você pode estar interessado em detectar os transcritos diferencialmente expressos, o que é outro tipo de análise. Isso requer a execução do Salmon com diferentes parâmetros e o uso de um software estatístico diferente.

Então, agora precisamos obter um mapa que relacione o identificador do transcrito com o identificador do gene que o origina. Felizmente, com os identificadores dos transcritos de _A. thaliana_, isso é muito fácil. Esses identificadores têm o formato:

AT**X**G**YYYYY**.**Z**

Onde **X** é o cromossomo e pode ter os valores 1, 2, 3, 4, 5, M ou C. **YYYYY** é um número serial. Essa cadeia de texto **ATXGYYYYY** representa o identificador do gene.

```
zcat TAIR10_cdna_20101214_updated.gz |grep  ">" | cut -f 1 -d' '|sed 's/>//'| sed -r 's/((AT.G[0-9]*)\.[0-9]*)/\1\t\2/' > tx2gene.txt
```

### Carregando os dados em R

Agora temos tudo pronto para iniciar a análise em [R](https://cran.r-project.org/).

No seu terminal, execute o comando:

```
rstudio
```

Uma janela como a seguinte deveria aparecer na sua tela:

![Screendhot Rstudio](images/rstudio.png)

A grosso modo, podemos dividir a área de trabalho do RStudio em quatro regiões:

- Na área superior esquerda, você encontrará abas que hospedam seus scripts e projetos. Isso permite que você organize e acesse facilmente seu código-fonte e trabalhe em diferentes projetos de análise de dados.
- Na área inferior esquerda, estão localizadas as abas Console, Terminal e Background Jobs, que permitem interagir com o ambiente do R. O Console é onde você pode executar comandos e ver a saída imediata. O Terminal permite interações mais avançadas com o sistema operacional, enquanto as Tarefas em Segundo Plano rastreiam e gerenciam tarefas em execução.
- A área superior direita exibe as abas Environment, History, Connections e Tutorial. São abas que fornecem informações e recursos adicionais. O Ambiente mostra os objetos em sua sessão R atual. O Histórico registra comandos anteriores. Conexões permitem a integração com outros serviços e tutoriais fornecem orientações úteis.
- A área inferior direita inclui as abas Files, Plots, Packages, Help, Viewer e Presentation. Arquivos gerencia seus arquivos e diretórios. Gráficos exibe gráficos gerados durante sua análise. Pacotes ajuda a gerenciar pacotes R. Ajuda fornece informações detalhadas sobre funções e pacotes. O Visualizador permite visualizar conjuntos de dados e gráficos interativamente. Apresentação ajuda a criar apresentações R Markdown.

Essas abas tornam o RStudio uma ferramenta versátil e eficaz para o desenvolvimento e análise de projetos em R.

No exemplo abaixo, criamos duas variáveis no console: greeting <- "Hola, Mundo!" e meuVector <- c(1, 2, 3, 4). Observe como elas são exibidas na aba Ambiente:

![Screendhot Rstudio2](images/rstudio2.png)

Para a análise de dados de transcriptômica, vamos criar um novo script no qual armazenaremos todos os passos da análise. Para começar a gravar um script, clique em Arquivo - Novo Arquivo - Script R. Isso abrirá um editor de texto no canto superior esquerdo da interface do RStudio (acima da guia Console).

Primeiramente, precisamos carregar algumas bibliotecas do R que estendem as funcionalidades básicas da linguagem e nos permitem lidar com dados de expressão gênica.

```R
library(DESeq2)
library(tximport)
library(ggplot2)
```
Recomendo que se acostume a limpar todos os objetos que estão presentes em seu ambiente. Possivelmente, neste momento, você tem apenas os objetos greeting e meuVector, mas se decidir reexecutar o script, é conveniente começar do zero.

```R
rm(list=ls())
```
Agora, vamos definir o seu diretório de trabalho. Ele deve ser o diretório que contém todos os resultados do Salmon. Lembre-se de que você deve ter 16 pastas com os resultados do Salmon.

```R
wd<-"/data/diriano/cen5789_salmon/"
setwd(wd)
```

Agora, antes de importar os dados de quantificação para o R, é crucial possuir uma descrição do plano experimental. Para carregar essa descrição, utilizamos a função `read.delim` para importar um arquivo de texto chamado [targets.txt](files/targets.txt) com colunas separadas por TAB. Os dados são armazenados em um objeto denominado `targets`, o qual é um `data.frame`.

```R
targets<-read.delim("targets.txt",header=T)
rownames(targets)<-targets$SampleName
targets$Genotype<-as.factor(targets$Genotype)
targets$EnvironmentalStress<-as.factor(targets$EnvironmentalStress)
```
Você pode inspecionar o objeto `targets` agora, basta digitar o nome do objeto em seu Console. Como alternativa, você pode clicar no nome do objeto na aba "Environment" localizada na área superior direita.

```R
> targets
#          Number SampleName     Genotype EnvironmentalStress
#DRR016125      1  DRR016125           WT                None
#DRR016126      2  DRR016126           WT                 ABA
#DRR016127      3  DRR016127           WT                NaCl
#DRR016128      4  DRR016128           WT             Drought
#DRR016129      5  DRR016129        ros13                None
#DRR016130      6  DRR016130        ros13                 ABA
#DRR016131      7  DRR016131        ros13                NaCl
#DRR016132      8  DRR016132        ros13             Drought
#DRR016133      9  DRR016133     dml2dml3                None
#DRR016134     10  DRR016134     dml2dml3                 ABA
#DRR016135     11  DRR016135     dml2dml3                NaCl
#DRR016136     12  DRR016136     dml2dml3             Drought
#DRR016137     13  DRR016137 ros1dml2dml3                None
#DRR016138     14  DRR016138 ros1dml2dml3                 ABA
#DRR016139     15  DRR016139 ros1dml2dml3                NaCl
#DRR016140     16  DRR016140 ros1dml2dml3             Drought
```
Precisamos carregar o arquivo que contém a correspondência entre identificadores de genes e transcritos que você criou anteriormente.

```R
tx2gene<-read.delim("tx2gene.txt",header=F)
head(tx2gene)
```
Vamos ver um exemplo de um gene que possui 3 transcritos.

```R
tx2gene[which(tx2gene$V2=='AT1G51370'),]
#               V1        V2
#1     AT1G51370.2 AT1G51370
#8384  AT1G51370.1 AT1G51370
#10296 AT1G51370.3 AT1G51370
```
Para nos prepararmos para carregar as quantificações do Salmon, precisamos criar um objeto que contenha os nomes das amostras e a localização no disco dos arquivos `quant.sf` produzidos pelo Salmon.

Os nomes das amostras estão no objeto "target" na coluna `SampleName`. Além disso, sabemos que no nosso diretório de trabalho temos uma pasta para cada amostra, com o mesmo nome da coluna `SampleName` e o arquivo `quant.sf` está dentro dessa pasta.

```R
myFiles<-paste(wd, targets$SampleName,"/quant.sf",sep="")
myFiles
```
Inspecione o objeto `myFiles` e verifique se os caminho dos arquivos estão corretos. Agora vamos a adicionar o nome da amostra como o nome de cada caminho.

```R
names(myFiles)<-targets$SampleName
myFiles
```

E verificamos se os arquivos de fato existem no disco. O resultado dessa operação deve ser TRUE na sua tela. Caso contrário, significa que algum arquivo não está presente ou que o caminho está errado.

```R
all(file.exists(myFiles))
```

Agora, vamos importar os dados de quantificação do Salmon para o R, utilizando o pacote tximport. É importante observar que, neste caso, o tximport irá resumir os dados de expressão no nível dos genes.

```R
txi.salmon<-tximport(files = myFiles, type = 'salmon', tx2gene = tx2gene, txIn = TRUE, txOut = FALSE)
```

Vamos conferir o objeto `txi.salmon`; ele contém várias informações diferentes, como as abundâncias dos genes em _TPM_ (_Transcripts Per Million_), seus comprimentos e as contagens (número de leituras/fragmentos por gene por amostra). Vamos dar uma olhada nas primeiras linhas do objeto.

```R
head(txi.salmon$counts)
```

Esta matriz é o ponto de entrada no DESeq2, onde cada linha representa um gene (_g_), e cada coluna uma amostra (_i_). As células $` K_{ij} `$ indicam o número de fragmentos sequenciados que foram observados para o gene na amostra.

Apenas para fins de comparação entre a quantificação no nível de gene e no nível de transcrito, carregaremos os dados no nível de transcritos.

```R
txi.salmon.tx<-tximport(files = myFiles, type = 'salmon', tx2gene = tx2gene, txIn = TRUE, txOut = TRUE)
```

Vamos examinar os dados para um gene e, em seguida, remover o objeto `txi.salmon.tx`.

```R
head(txi.salmon$counts['AT1G51370',])
head(txi.salmon.tx$counts[c('AT1G51370.1','AT1G51370.2','AT1G51370.3'),])
rm(txi.salmon.tx)
```

Observe que o valor de expressão do gene é a soma dos valores de expressão de seus transcritos. Isso ocorre porque o Salmon, ao realizar a quantificação, fornece estimativas de abundância para cada transcrito individualmente. Ao importar esses dados no R usando o pacote tximport, com os argumentos `txIn = TRUE, txOut = FALSE`, a função automaticamente realiza a agregação dos valores de expressão dos transcritos para calcular a expressão a nível de gene.

Essa abordagem é útil porque muitos experimentos de RNA-Seq fornecem dados de expressão em nível de transcrito, mas, muitas vezes, estamos mais interessados na expressão a nível de gene para análises mais globais. A soma dos valores de expressão dos transcritos para um gene específico oferece uma medida geral da expressão desse gene no contexto do experimento.

Portanto, ao usar Salmon para a quantificação e tximport para a importação e agregação dos dados no R, obtemos uma representação mais consolidada da expressão gênica em termos de valores agregados a nível de gene.

Agora, vamos avaliar se todas as amostras foram sequenciadas com a mesma intensidade (esforço de sequenciamento). Embora seja ideal que isso aconteça, na prática, devido a diversos fatores, é difícil alcançar essa uniformidade. Portanto, é necessário calcular fatores de normalização que levem em consideração a profundidade de sequenciamento de cada amostra.

```R
seqEffort<-as.data.frame(colSums(txi.salmon$counts))
seqEffort$Samples<-rownames(seqEffort)
colnames(seqEffort)<-c('NumberFragments', 'Samples')
seqEffort
```

Vamos gerar uma figura com esses dados utilizando o pacote [ggplot2](https://ggplot2.tidyverse.org/) (observe que já carregamos o pacote no início do script). O ggplot2 é uma poderosa biblioteca de visualização em R, amplamente utilizada para criar gráficos estatísticos de alta qualidade. Desenvolvido por [Hadley Wickham](https://en.wikipedia.org/wiki/Ggplot2), o ggplot2 segue uma abordagem de "[gramática de gráficos](https://link.springer.com/book/10.1007/0-387-28695-0)", o que significa que você constrói visualizações adicionando camadas de elementos gráficos.

Para criar um gráfico com ggplot2, você especifica os dados, mapeia variáveis às propriedades estéticas (como cor, forma ou tamanho), e adiciona camadas geométricas para representar os dados visualmente (pontos, linhas, barras, etc.). Além disso, é possível personalizar a aparência do gráfico ajustando temas, escalas e legendas.

Aqui, utilizamos a função `ggplot` com o data.frame `seqEffort`, definindo os nomes das amostras no eixo X e a quantidade de fragmentos sequenciados no eixo Y. Em seguida, especificamos que desejamos criar um gráfico de colunas com esses dados.

```R
p<- ggplot(seqEffort, aes(x=Samples,y=NumberFragments))+ 
  geom_col()
```

Esse gráfico inicial não é esteticamente muito agradável. Vamos aprimorá-lo removendo o fundo cinza e posicionando os nomes das amostras em um ângulo.

```R
p + theme_bw() +
  theme(axis.text.x = element_text(angle=60, size = 12, hjust = 1))
```
Isso já está muito melhor. Vamos agora alterar os nomes dos eixos para deixá-los em português.

```R
p + theme_bw() +
  theme(axis.text.x = element_text(angle=60, size = 12, hjust = 1)) +
  xlab("Amostras") +
  ylab("Número de fragmentos sequenciados")
```

Agora, por favor, discuta com seus colegas o efeito da profundidade de sequenciamento na estimação dos valores de expressão. Pode ser interessante examinar os dados de alguns genes, por exemplo:

```R
txi.salmon$counts['AT1G51370',]
```

### DESeq2

Existem diversos pacotes disponíveis para a identificação de Genes Diferencialmente Expressos (DEGs, por suas sigla em inglês) em R, sendo que [DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html) ([Love et al., 2014](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-014-0550-8)) e [edgeR](https://bioconductor.org/packages/release/bioc/html/edgeR.html) ([Robinson et al., 2010](https://pubmed.ncbi.nlm.nih.gov/19910308/)) são dois dos mais amplamente utilizados e reconhecidos na comunidade científica. No entanto, é importante mencionar que há uma variedade de outras ferramentas e pacotes que também desempenham um papel significativo na análise de expressão gênica diferencial no ambiente R. A escolha do pacote pode depender de diversos fatores, como a natureza dos dados, as premissas do experimento e as preferências metodológicas do pesquisador.

Nesta seção, vamos utilizar o pacote DESeq2 e, inicialmente, apresentar o modelo estatístico empregado por este pacote. O DESeq2 utiliza um modelo linear generalizado baseado na distribuição binomial negativa das contagens de cada gene em cada condição ([Negative Binomial](https://en.wikipedia.org/wiki/Negative_binomial_distribution) [Generalized Linear Model](https://en.wikipedia.org/wiki/Generalized_linear_model)). Esse modelo considera a variabilidade intrínseca aos dados de RNA-Seq.


#### Modelo estatístico no DESeq2

No modelo de DESEq2, as contagens _y_ do gene _g_ na amostra _i_, são amostradas de uma distribuição binomial negativa com média _μ_ e parâmetro de dispersão _α_.

```math
y_{gi} ~ NB(μ_{gi}, α_g)
```

Uma estimativa precisa do parâmetro de dispersão $\alpha_{g}$ é crucial para uma correta inferência estatística. No entanto, não é simples devido ao baixo número de replicatas normalmente utilizadas em experimentos de RNA-Seq, o que resulta em estimativas de dispersão muito variáveis. Uma maneira de lidar com isso é compartilhar informações de vários genes. Inicialmente, obtemos estimativas de dispersão gene a gene usando máxima verossimilhança, com base nos dados de cada gene individualmente. Isso nos permite estimar a relação entre a dispersão e o valor médio das contagens, ou seja, obter uma estimativa precisa para o valor da dispersão esperada. No entanto, essa abordagem não captura as variações individuais de cada gene em relação a essa tendência. Em seguida, ajustamos as estimativas de dispersão gene a gene em direção aos valores previstos pela tendência para obter os valores finais de dispersão, em um processo chamado de "shrinkage". Dessa forma, o procedimento captura a variação específica de cada gene tanto quanto os dados permitem estimar. Ao mesmo tempo, a curva de tendência facilita a estimativa e inferência em regiões com menos conteúdo de informação. Esse método equilibra a precisão das estimativas individuais com a estabilidade proporcionada pela tendência global.

A abordagem de compartilhamento de informação é particularmente útil em experimentos com um pequeno número de replicatas, pois permite que genes semelhantes forneçam informações uns aos outros, melhorando assim a estabilidade das estimativas de dispersão. Essa estratégia é implementada em métodos como o DESeq2 para aprimorar a precisão das inferências em experimentos de RNA-Seq.
O modelo implementado no DESeq tem algumas suposições (todos os modelos têm) importantes e só deveria ser usado se você tiver certeza de que seus dados satisfazem essas suposições. Essas suposições são:

- As observações (contagens) são assumidas como independentes entre si.
- O parametro de dispersão _α_ é constante para todos os genes.
- O média das contagens para um gene numa amostra ($` μ_{gi} `$) está diretamente relacionada a verdadeira abundancia desse gene ($` q_{gi} `$), ajustada (_scaled_) por um fator especifico (_size factor_) para a amostra  $` s_i `$.

```math
μ_{gi} =: q_{gi} * s_i
```

O parametro $` s_i `$, pode incorporar a profundidade da amostra, a composicao da amostra, etc., i.e., todos os fatores que precisem ser normalizados. O DESeq2 estima esse parametro para cada amostra, e o utiliza para normalizar as contagens de cada gene. O DESeq2 utiliza o modelo de regressão log-linear para estimar os parametros $` s_i `$ e $` q_{gi} `$.

```math
log_2(q_{gi}) = \sum_r x_{ri} \beta_{rg}
```

Onde, $` x_{ri} `$  é uma matriz com o planejamento experimental e $` \beta_{rg} `$ é o coeficiente de regressão para o gene _g_ na amostra _i_, é está relacionao a mudança de abundânçia (fold change) do gene _g_ na amostra _i_ em relação a uma amostra de referência. 

O que representa essa matriz de planejamento experimental? Vamos explorar um experimento simples com um único fator e dois níveis desse fator, ou seja, controle e tratamento, cada nível com duas replicatas biológicas. Na matriz apresentada, as linhas representam as unidades experimentais, enquanto cada coluna corresponde a um nível do fator em estudo. Os valores nas células são 0 ou 1, indicando se uma unidade experimental foi (1) ou não (0) atribuída a um dos níveis do fator.

```math
x_{ri} = \begin{bmatrix} 1 & 0 \\\ 1 & 0 \\\ 0 & 1 \\\ 0 & 1 \end{bmatrix}
```

Os parametros $` \beta `$ estão no vector:

```math
\beta_g = \begin{bmatrix} \beta_{g0} \\\ \beta_{g1} \end{bmatrix}
```

Depois de ajustar o modelo com os dados disponiveis, o seja calculados os coeficientes $` \beta_{gi} `$, udança na expressão do gene pode ser expressa em escala de $` log_2`$ como 

```math
Log2FC(g) = (\beta_{g1} - \beta_{g0})
```

Ao utilizar esse modelo, o DESeq2 possibilita a identificação de genes diferencialmente expressos com maior precisão, controlando eficazmente a taxa de erro e fornecendo resultados estatisticamente significativos. Isso faz dele uma ferramenta poderosa na análise de expressão gênica diferencial, especialmente quando lidamos com dados complexos e experimentos de RNA-Seq.

#### Identificacão de genes diferencialmente expressos com DESseq2

Agora sim, vamos fornecer os dados ao DESeq2. Este pacote possui rotinas que podem importar os dados diretamente do objeto criado pelo ``tximport``. Durante este processo, vamos especificar quais são os níveis de referência para os dois fatores controlados no planejamento experimental: Genotype e EnvironmentalStress.

```R
dds <- DESeqDataSetFromTximport(txi.salmon, colData = targets, design = ~Condition)
dds$Genotype <-relevel(dds$Genotype, ref='WT')
dds$EnvironmentalStress <-relevel(dds$EnvironmentalStress, ref='None')
dds <- DESeq(dds)
```

Vale a pena discutir um pouco sobre o tipo de objeto criado pelo DESeq com a função DESeqDataSetFromTximport. Este é um objeto do tipo `RangedSummarizedExperiment`, que pos sua vez é uma extensão do `SummarizedExperiment`, como apresentado de forma resumida na figura seguinte.


O objeto `SummarizedExperiment` é uma classe que serve como um recipiente eficiente para armazenar dados experimentais. Ele é utilizado para representar conjuntos de dados tabulares associados a uma matriz de dados principal, onde as linhas geralmente representam recursos biológicos (genes, por exemplo) e as colunas representam amostras. O `SummarizedExperiment` é projetado para armazenar informações adicionais sobre os dados, como metadados sobre as amostras e características biológicas, proporcionando uma estrutura organizada e completa.

A classe `RangedSummarizedExperiment` inclui informações adicionais sobre a localização física dos recursos biológicos em um genoma. Isso é particularmente útil para dados genômicos, como dados de sequenciamento de RNA (RNA-Seq), onde é importante entender a posição dos genes em um genoma.

![SummarizedExperiment](data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIHZpZXdCb3g9IjAuMCAwLjAgNzA1LjU1MzgwNTc3NDI3ODIgNjAyLjExNTQ4NTU2NDMwNDQiIGZpbGw9Im5vbmUiIHN0cm9rZT0ibm9uZSIgc3Ryb2tlLWxpbmVjYXA9InNxdWFyZSIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48Y2xpcFBhdGggaWQ9InAuMCI+PHBhdGggZD0ibTAgMGw3MDUuNTUzODMgMGwwIDYwMi4xMTU1bC03MDUuNTUzODMgMGwwIC02MDIuMTE1NXoiIGNsaXAtcnVsZT0ibm9uemVybyIvPjwvY2xpcFBhdGg+PGcgY2xpcC1wYXRoPSJ1cmwoI3AuMCkiPjxwYXRoIGZpbGw9IiMwMDAwMDAiIGZpbGwtb3BhY2l0eT0iMC4wIiBkPSJtMCAwbDcwNS41NTM4MyAwbDAgNjAyLjExNTVsLTcwNS41NTM4MyAweiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PHBhdGggZmlsbD0iI2NmZTJmMyIgZD0ibTIyOC4wMDc4NyAyMTIuMjE3ODVsMTk2LjQ0MDk1IDBsMCAyODcuMTE4MWwtMTk2LjQ0MDk1IDB6IiBmaWxsLXJ1bGU9ImV2ZW5vZGQiLz48cGF0aCBzdHJva2U9IiM0MzQzNDMiIHN0cm9rZS13aWR0aD0iMy4wIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBzdHJva2UtbGluZWNhcD0iYnV0dCIgZD0ibTIyOC4wMDc4NyAyMTIuMjE3ODVsMTk2LjQ0MDk1IDBsMCAyODcuMTE4MWwtMTk2LjQ0MDk1IDB6IiBmaWxsLXJ1bGU9ImV2ZW5vZGQiLz48cGF0aCBmaWxsPSIjZDllYWQzIiBkPSJtMjExLjU2NDMgMTk3Ljk5NzM4bDE5Ni40NDA5NSAwbDAgMjg3LjExODFsLTE5Ni40NDA5NSAweiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PHBhdGggc3Ryb2tlPSIjNDM0MzQzIiBzdHJva2Utd2lkdGg9IjMuMCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLWxpbmVjYXA9ImJ1dHQiIGQ9Im0yMTEuNTY0MyAxOTcuOTk3MzhsMTk2LjQ0MDk1IDBsMCAyODcuMTE4MWwtMTk2LjQ0MDk1IDB6IiBmaWxsLXJ1bGU9ImV2ZW5vZGQiLz48cGF0aCBmaWxsPSIjY2ZlMmYzIiBkPSJtMTk1LjExODEgMTgxLjExMDIzbDE5Ni40NDA5NSAwbDAgMjg3LjExODFsLTE5Ni40NDA5NSAweiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PHBhdGggc3Ryb2tlPSIjNDM0MzQzIiBzdHJva2Utd2lkdGg9IjMuMCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLWxpbmVjYXA9ImJ1dHQiIGQ9Im0xOTUuMTE4MSAxODEuMTEwMjNsMTk2LjQ0MDk1IDBsMCAyODcuMTE4MWwtMTk2LjQ0MDk1IDB6IiBmaWxsLXJ1bGU9ImV2ZW5vZGQiLz48cGF0aCBmaWxsPSIjZDlkMmU5IiBkPSJtMTk2LjY3OTggMjI5LjExMDIzbDE5My4zMjI4MyAwbDAgNTQuODM0NjU2bC0xOTMuMzIyODMgMHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIHN0cm9rZT0iIzY2NjY2NiIgc3Ryb2tlLXdpZHRoPSIxLjAiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS1saW5lY2FwPSJidXR0IiBzdHJva2UtZGFzaGFycmF5PSIxLjAsMy4wIiBkPSJtMTk2LjY3OTggMjI5LjExMDIzbDE5My4zMjI4MyAwbDAgNTQuODM0NjU2bC0xOTMuMzIyODMgMHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIGZpbGw9IiNkOWQyZTkiIGQ9Im0xOTYuNjkyOTIgMzQwLjIyMDQ2bDE5My4zMjI4MyAwbDAgMjMuNzE2NTUzbC0xOTMuMzIyODMgMHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIHN0cm9rZT0iIzY2NjY2NiIgc3Ryb2tlLXdpZHRoPSIxLjAiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS1saW5lY2FwPSJidXR0IiBzdHJva2UtZGFzaGFycmF5PSIxLjAsMy4wIiBkPSJtMTk2LjY5MjkyIDM0MC4yMjA0NmwxOTMuMzIyODMgMGwwIDIzLjcxNjU1M2wtMTkzLjMyMjgzIDB6IiBmaWxsLXJ1bGU9ImV2ZW5vZGQiLz48cGF0aCBmaWxsPSIjY2ZlMmYzIiBkPSJtNDkyLjQ1MDEzIDAuMjIwNDcyNDRsMTA0Ljg4MTkgMGwwIDE1OS4xMTgxMmwtMTA0Ljg4MTkgMHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIHN0cm9rZT0iIzQzNDM0MyIgc3Ryb2tlLXdpZHRoPSIzLjAiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS1saW5lY2FwPSJidXR0IiBkPSJtNDkyLjQ1MDEzIDAuMjIwNDcyNDRsMTA0Ljg4MTkgMGwwIDE1OS4xMTgxMmwtMTA0Ljg4MTkgMHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIGZpbGw9IiNmY2U1Y2QiIGQ9Im01OTUuODA1OCAzMi4wMTgzN2wwIDMwLjIwNDcyM2wtMTAxLjgyNjc4IDBsMCAtMzAuMjA0NzIzeiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PHBhdGggc3Ryb2tlPSIjNjY2NjY2IiBzdHJva2Utd2lkdGg9IjEuMCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLWxpbmVjYXA9ImJ1dHQiIHN0cm9rZS1kYXNoYXJyYXk9IjEuMCwzLjAiIGQ9Im01OTUuODA1OCAzMi4wMTgzN2wwIDMwLjIwNDcyM2wtMTAxLjgyNjc4IDBsMCAtMzAuMjA0NzIzeiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PHBhdGggZmlsbD0iIzAwMDAwMCIgZmlsbC1vcGFjaXR5PSIwLjAiIGQ9Im00NTYuNjU2MTYgMTU5LjMzODU4bDE5Ni40NDA5NSAwbDAgNTUuMTE4MTJsLTE5Ni40NDA5NSAweiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PHBhdGggZmlsbD0iIzAwMDAwMCIgZD0ibTQ3My4yMDMwMyAxODIuNzExN2wxLjYwOTM3NSAwLjIxODc1cS0wLjI2NTYyNSAxLjY1NjI1IC0xLjM1OTM3NSAyLjYwOTM3NXEtMS4wNzgxMjUgMC45Mzc1IC0yLjY3MTg3NSAwLjkzNzVxLTEuOTg0Mzc1IDAgLTMuMTg3NSAtMS4yOTY4NzVxLTEuMjAzMTI1IC0xLjI5Njg3NSAtMS4yMDMxMjUgLTMuNzE4NzVxMCAtMS41NzgxMjUgMC41MTU2MjUgLTIuNzVxMC41MTU2MjUgLTEuMTcxODc1IDEuNTc4MTI1IC0xLjc1cTEuMDYyNSAtMC41OTM3NSAyLjMxMjUgLTAuNTkzNzVxMS41NzgxMjUgMCAyLjU3ODEyNSAwLjc5Njg3NXExLjAgMC43OTY4NzUgMS4yODEyNSAyLjI2NTYyNWwtMS41OTM3NSAwLjIzNDM3NXEtMC4yMzQzNzUgLTAuOTY4NzUgLTAuODEyNSAtMS40NTMxMjVxLTAuNTc4MTI1IC0wLjUgLTEuMzkwNjI1IC0wLjVxLTEuMjM0Mzc1IDAgLTIuMDE1NjI1IDAuODkwNjI1cS0wLjc4MTI1IDAuODkwNjI1IC0wLjc4MTI1IDIuODEyNXEwIDEuOTUzMTI1IDAuNzUgMi44NDM3NXEwLjc1IDAuODc1IDEuOTUzMTI1IDAuODc1cTAuOTY4NzUgMCAxLjYwOTM3NSAtMC41OTM3NXEwLjY1NjI1IC0wLjU5Mzc1IDAuODI4MTI1IC0xLjgyODEyNXptMi40MDYyNSAtMS4yOTY4NzVxMCAtMi42ODc1IDEuNDg0Mzc1IC0zLjk2ODc1cTEuMjUgLTEuMDc4MTI1IDMuMDQ2ODc1IC0xLjA3ODEyNXEyLjAgMCAzLjI2NTYyNSAxLjMxMjVxMS4yNjU2MjUgMS4yOTY4NzUgMS4yNjU2MjUgMy42MDkzNzVxMCAxLjg1OTM3NSAtMC41NjI1IDIuOTM3NXEtMC41NjI1IDEuMDYyNSAtMS42NDA2MjUgMS42NTYyNXEtMS4wNjI1IDAuNTkzNzUgLTIuMzI4MTI1IDAuNTkzNzVxLTIuMDMxMjUgMCAtMy4yODEyNSAtMS4yOTY4NzVxLTEuMjUgLTEuMzEyNSAtMS4yNSAtMy43NjU2MjV6bTEuNjg3NSAwcTAgMS44NTkzNzUgMC43OTY4NzUgMi43OTY4NzVxMC44MTI1IDAuOTIxODc1IDIuMDQ2ODc1IDAuOTIxODc1cTEuMjE4NzUgMCAyLjAzMTI1IC0wLjkyMTg3NXEwLjgxMjUgLTAuOTM3NSAwLjgxMjUgLTIuODQzNzVxMCAtMS43OTY4NzUgLTAuODEyNSAtMi43MTg3NXEtMC44MTI1IC0wLjkyMTg3NSAtMi4wMzEyNSAtMC45MjE4NzVxLTEuMjM0Mzc1IDAgLTIuMDQ2ODc1IDAuOTIxODc1cS0wLjc5Njg3NSAwLjkwNjI1IC0wLjc5Njg3NSAyLjc2NTYyNXptOS4yNTA3MzIgNC44NDM3NWwwIC0xMy4zNTkzNzVsMS42NDA2MjUgMGwwIDEzLjM1OTM3NWwtMS42NDA2MjUgMHptNC4zOTQ4MDYgMGwwIC0xMy4zNTkzNzVsNC42MDkzNzUgMHExLjU0Njg3NSAwIDIuMzc1IDAuMjAzMTI1cTEuMTQwNjI1IDAuMjUgMS45NTMxMjUgMC45NTMxMjVxMS4wNjI1IDAuODkwNjI1IDEuNTc4MTI1IDIuMjgxMjVxMC41MzEyNSAxLjM5MDYyNSAwLjUzMTI1IDMuMTcxODc1cTAgMS41MTU2MjUgLTAuMzU5Mzc1IDIuNzAzMTI1cS0wLjM1OTM3NSAxLjE3MTg3NSAtMC45MjE4NzUgMS45Mzc1cS0wLjU0Njg3NSAwLjc2NTYyNSAtMS4yMDMxMjUgMS4yMTg3NXEtMC42NTYyNSAwLjQzNzUgLTEuNTkzNzUgMC42NzE4NzVxLTAuOTM3NSAwLjIxODc1IC0yLjE0MDYyNSAwLjIxODc1bC00LjgyODEyNSAwem0xLjc2NTYyNSAtMS41NzgxMjVsMi44NTkzNzUgMHExLjMxMjUgMCAyLjA2MjUgLTAuMjM0Mzc1cTAuNzUgLTAuMjUgMS4yMDMxMjUgLTAuNzAzMTI1cTAuNjI1IC0wLjYyNSAwLjk2ODc1IC0xLjY4NzVxMC4zNTkzNzUgLTEuMDYyNSAwLjM1OTM3NSAtMi41NzgxMjVxMCAtMi4wOTM3NSAtMC42ODc1IC0zLjIxODc1cS0wLjY4NzUgLTEuMTI1IC0xLjY3MTg3NSAtMS41cS0wLjcwMzEyNSAtMC4yODEyNSAtMi4yODEyNSAtMC4yODEyNWwtMi44MTI1IDBsMCAxMC4yMDMxMjV6bTE3LjgxNjcxMSAwLjM5MDYyNXEtMC45MjE4NzUgMC43NjU2MjUgLTEuNzY1NjI1IDEuMDkzNzVxLTAuODI4MTI1IDAuMzEyNSAtMS43OTY4NzUgMC4zMTI1cS0xLjU5Mzc1IDAgLTIuNDUzMTI1IC0wLjc4MTI1cS0wLjg1OTM3NSAtMC43ODEyNSAtMC44NTkzNzUgLTEuOTg0Mzc1cTAgLTAuNzE4NzUgMC4zMjgxMjUgLTEuMjk2ODc1cTAuMzI4MTI1IC0wLjU5Mzc1IDAuODQzNzUgLTAuOTM3NXEwLjUzMTI1IC0wLjM1OTM3NSAxLjE4NzUgLTAuNTQ2ODc1cTAuNDY4NzUgLTAuMTI1IDEuNDUzMTI1IC0wLjI1cTEuOTg0Mzc1IC0wLjIzNDM3NSAyLjkyMTg3NSAtMC41NjI1cTAuMDE1NjI1IC0wLjM0Mzc1IDAuMDE1NjI1IC0wLjQyMTg3NXEwIC0xLjAgLTAuNDY4NzUgLTEuNDIxODc1cS0wLjYyNSAtMC41NDY4NzUgLTEuODc1IC0wLjU0Njg3NXEtMS4xNTYyNSAwIC0xLjcwMzEyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjgxMjUgMS40MjE4NzVsLTEuNjA5Mzc1IC0wLjIxODc1cTAuMjE4NzUgLTEuMDE1NjI1IDAuNzE4NzUgLTEuNjQwNjI1cTAuNSAtMC42NDA2MjUgMS40NTMxMjUgLTAuOTg0Mzc1cTAuOTUzMTI1IC0wLjM0Mzc1IDIuMTg3NSAtMC4zNDM3NXExLjI1IDAgMi4wMTU2MjUgMC4yOTY4NzVxMC43ODEyNSAwLjI4MTI1IDEuMTQwNjI1IDAuNzM0Mzc1cTAuMzc1IDAuNDM3NSAwLjUxNTYyNSAxLjEwOTM3NXEwLjA3ODEyNSAwLjQyMTg3NSAwLjA3ODEyNSAxLjUxNTYyNWwwIDIuMTg3NXEwIDIuMjgxMjUgMC4xMDkzNzUgMi44OTA2MjVxMC4xMDkzNzUgMC41OTM3NSAwLjQwNjI1IDEuMTU2MjVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzUgMS40NTMxMjUgMC40Mzc1cTAuOTM3NSAwIDEuNjcxODc1IC0wLjQwNjI1cTAuNzUgLTAuNDIxODc1IDEuMDkzNzUgLTEuMTQwNjI1cTAuMjY1NjI1IC0wLjU2MjUgMC4yNjU2MjUgLTEuNjQwNjI1bDAgLTAuNjA5Mzc1em03Ljc4MTk4MjQgMy4zOTA2MjVsMC4yMzQzNzUgMS40NTMxMjVxLTAuNjg3NSAwLjE0MDYyNSAtMS4yMzQzNzUgMC4xNDA2MjVxLTAuODkwNjI1IDAgLTEuMzkwNjI1IC0wLjI4MTI1cS0wLjQ4NDM3NSAtMC4yODEyNSAtMC42ODc1IC0wLjczNDM3NXEtMC4yMDMxMjUgLTAuNDY4NzUgLTAuMjAzMTI1IC0xLjkzNzVsMCAtNS41NzgxMjVsLTEuMjAzMTI1IDBsMCAtMS4yNjU2MjVsMS4yMDMxMjUgMGwwIC0yLjM5MDYyNWwxLjYyNSAtMC45ODQzNzVsMCAzLjM3NWwxLjY1NjI1IDBsMCAxLjI2NTYyNWwtMS42NTYyNSAwbDAgNS42NzE4NzVxMCAwLjY4NzUgMC4wNzgxMjUgMC44OTA2MjVxMC4wOTM3NSAwLjIwMzEyNSAwLjI4MTI1IDAuMzI4MTI1cTAuMjAzMTI1IDAuMTA5Mzc1IDAuNTc4MTI1IDAuMTA5Mzc1cTAuMjY1NjI1IDAgMC43MTg3NSAtMC4wNjI1em03LjkxNzY2MzYgMC4yODEyNXEtMC45MjE4NzUgMC43NjU2MjUgLTEuNzY1NjI1IDEuMDkzNzVxLTAuODI4MTI1IDAuMzEyNSAtMS43OTY4NzUgMC4zMTI1cS0xLjU5Mzc1IDAgLTIuNDUzMTI1IC0wLjc4MTI1cS0wLjg1OTM3NSAtMC43ODEyNSAtMC44NTkzNzUgLTEuOTg0Mzc1cTAgLTAuNzE4NzUgMC4zMjgxMjUgLTEuMjk2ODc1cTAuMzI4MTI1IC0wLjU5Mzc1IDAuODQzNzUgLTAuOTM3NXEwLjUzMTI1IC0wLjM1OTM3NSAxLjE4NzUgLTAuNTQ2ODc1cTAuNDY4NzUgLTAuMTI1IDEuNDUzMTI1IC0wLjI1cTEuOTg0Mzc1IC0wLjIzNDM3NSAyLjkyMTg3NSAtMC41NjI1cTAuMDE1NjI1IC0wLjM0Mzc1IDAuMDE1NjI1IC0wLjQyMTg3NXEwIC0xLjAgLTAuNDY4NzUgLTEuNDIxODc1cS0wLjYyNSAtMC41NDY4NzUgLTEuODc1IC0wLjU0Njg3NXEtMS4xNTYyNSAwIC0xLjcwMzEyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjgxMjUgMS40MjE4NzVsLTEuNjA5Mzc1IC0wLjIxODc1cTAuMjE4NzUgLTEuMDE1NjI1IDAuNzE4NzUgLTEuNjQwNjI1cTAuNSAtMC42NDA2MjUgMS40NTMxMjUgLTAuOTg0Mzc1cTAuOTUzMTI1IC0wLjM0Mzc1IDIuMTg3NSAtMC4zNDM3NXExLjI1IDAgMi4wMTU2MjUgMC4yOTY4NzVxMC43ODEyNSAwLjI4MTI1IDEuMTQwNjI1IDAuNzM0Mzc1cTAuMzc1IDAuNDM3NSAwLjUxNTYyNSAxLjEwOTM3NXEwLjA3ODEyNSAwLjQyMTg3NSAwLjA3ODEyNSAxLjUxNTYyNWwwIDIuMTg3NXEwIDIuMjgxMjUgMC4xMDkzNzUgMi44OTA2MjVxMC4xMDkzNzUgMC41OTM3NSAwLjQwNjI1IDEuMTU2MjVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzUgMS40NTMxMjUgMC40Mzc1cTAuOTM3NSAwIDEuNjcxODc1IC0wLjQwNjI1cTAuNzUgLTAuNDIxODc1IDEuMDkzNzUgLTEuMTQwNjI1cTAuMjY1NjI1IC0wLjU2MjUgMC4yNjU2MjUgLTEuNjQwNjI1bDAgLTAuNjA5Mzc1em03LjMyODg1NzQgOC43ODEyNXEtMS4zNTkzNzUgLTEuNzAzMTI1IC0yLjI5Njg3NSAtNC4wcS0wLjkzNzUgLTIuMjk2ODc1IC0wLjkzNzUgLTQuNzY1NjI1cTAgLTIuMTU2MjUgMC43MDMxMjUgLTQuMTQwNjI1cTAuODI4MTI1IC0yLjMxMjUgMi41MzEyNSAtNC41OTM3NWwxLjE3MTg3NSAwcS0xLjA5Mzc1IDEuODkwNjI1IC0xLjQ1MzEyNSAyLjcwMzEyNXEtMC41NDY4NzUgMS4yNSAtMC44NzUgMi42MjVxLTAuMzkwNjI1IDEuNzAzMTI1IC0wLjM5MDYyNSAzLjQyMTg3NXEwIDQuMzc1IDIuNzE4NzUgOC43NWwtMS4xNzE4NzUgMHptMi40MzEzOTY1IC02LjgxMjVsMS42MjUgLTAuMjVxMC4xMjUgMC45Njg3NSAwLjc1IDEuNXEwLjYyNSAwLjUxNTYyNSAxLjc1IDAuNTE1NjI1cTEuMTI1IDAgMS42NzE4NzUgLTAuNDUzMTI1cTAuNTQ2ODc1IC0wLjQ2ODc1IDAuNTQ2ODc1IC0xLjA5Mzc1cTAgLTAuNTQ2ODc1IC0wLjQ4NDM3NSAtMC44NzVxLTAuMzI4MTI1IC0wLjIxODc1IC0xLjY3MTg3NSAtMC41NDY4NzVxLTEuODEyNSAtMC40Njg3NSAtMi41MTU2MjUgLTAuNzk2ODc1cS0wLjY4NzUgLTAuMzI4MTI1IC0xLjA0Njg3NSAtMC45MDYyNXEtMC4zNTkzNzUgLTAuNTkzNzUgLTAuMzU5Mzc1IC0xLjMxMjVxMCAtMC42NDA2MjUgMC4yOTY4NzUgLTEuMTg3NXEwLjI5Njg3NSAtMC41NjI1IDAuODEyNSAtMC45MjE4NzVxMC4zNzUgLTAuMjgxMjUgMS4wMzEyNSAtMC40Njg3NXEwLjY3MTg3NSAtMC4yMDMxMjUgMS40MjE4NzUgLTAuMjAzMTI1cTEuMTQwNjI1IDAgMi4wIDAuMzI4MTI1cTAuODU5Mzc1IDAuMzI4MTI1IDEuMjY1NjI1IDAuODkwNjI1cTAuNDIxODc1IDAuNTYyNSAwLjU3ODEyNSAxLjVsLTEuNjA5Mzc1IDAuMjE4NzVxLTAuMTA5Mzc1IC0wLjc1IC0wLjY0MDYyNSAtMS4xNzE4NzVxLTAuNTE1NjI1IC0wLjQyMTg3NSAtMS40Njg3NSAtMC40MjE4NzVxLTEuMTQwNjI1IDAgLTEuNjI1IDAuMzc1cS0wLjQ2ODc1IDAuMzc1IC0wLjQ2ODc1IDAuODc1cTAgMC4zMTI1IDAuMTg3NSAwLjU3ODEyNXEwLjIwMzEyNSAwLjI2NTYyNSAwLjY0MDYyNSAwLjQzNzVxMC4yMzQzNzUgMC4wOTM3NSAxLjQzNzUgMC40MjE4NzVxMS43NSAwLjQ1MzEyNSAyLjQzNzUgMC43NXEwLjY4NzUgMC4yOTY4NzUgMS4wNzgxMjUgMC44NTkzNzVxMC4zOTA2MjUgMC41NjI1IDAuMzkwNjI1IDEuNDA2MjVxMCAwLjgyODEyNSAtMC40ODQzNzUgMS41NDY4NzVxLTAuNDY4NzUgMC43MTg3NSAtMS4zNzUgMS4xMjVxLTAuOTA2MjUgMC4zOTA2MjUgLTIuMDQ2ODc1IDAuMzkwNjI1cS0xLjg3NSAwIC0yLjg3NSAtMC43ODEyNXEtMC45ODQzNzUgLTAuNzgxMjUgLTEuMjUgLTIuMzI4MTI1em0xNi42MDkzNzUgLTAuMjE4NzVsMS42ODc1IDAuMjAzMTI1cS0wLjQwNjI1IDEuNDg0Mzc1IC0xLjQ4NDM3NSAyLjMxMjVxLTEuMDc4MTI1IDAuODEyNSAtMi43NjU2MjUgMC44MTI1cS0yLjEyNSAwIC0zLjM3NSAtMS4yOTY4NzVxLTEuMjM0Mzc1IC0xLjMxMjUgLTEuMjM0Mzc1IC0zLjY3MTg3NXEwIC0yLjQ1MzEyNSAxLjI1IC0zLjc5Njg3NXExLjI2NTYyNSAtMS4zNDM3NSAzLjI2NTYyNSAtMS4zNDM3NXExLjkzNzUgMCAzLjE1NjI1IDEuMzI4MTI1cTEuMjM0Mzc1IDEuMzEyNSAxLjIzNDM3NSAzLjcwMzEyNXEwIDAuMTU2MjUgMCAwLjQzNzVsLTcuMjE4NzUgMHEwLjA5Mzc1IDEuNTkzNzUgMC45MDYyNSAyLjQ1MzEyNXEwLjgxMjUgMC44NDM3NSAyLjAxNTYyNSAwLjg0Mzc1cTAuOTA2MjUgMCAxLjU0Njg3NSAtMC40Njg3NXEwLjY0MDYyNSAtMC40ODQzNzUgMS4wMTU2MjUgLTEuNTE1NjI1em0tNS4zOTA2MjUgLTIuNjU2MjVsNS40MDYyNSAwcS0wLjEwOTM3NSAtMS4yMTg3NSAtMC42MjUgLTEuODI4MTI1cS0wLjc4MTI1IC0wLjk1MzEyNSAtMi4wMzEyNSAtMC45NTMxMjVxLTEuMTI1IDAgLTEuOTA2MjUgMC43NjU2MjVxLTAuNzY1NjI1IDAuNzUgLTAuODQzNzUgMi4wMTU2MjV6bTEwLjIxOTQ4MiA5LjY4NzVsLTEuMTg3NSAwcTIuNzM0Mzc1IC00LjM3NSAyLjczNDM3NSAtOC43NXEwIC0xLjcxODc1IC0wLjM5MDYyNSAtMy4zOTA2MjVxLTAuMzEyNSAtMS4zNzUgLTAuODc1IC0yLjYyNXEtMC4zNTkzNzUgLTAuODI4MTI1IC0xLjQ2ODc1IC0yLjczNDM3NWwxLjE4NzUgMHExLjcwMzEyNSAyLjI4MTI1IDIuNTMxMjUgNC41OTM3NXEwLjY4NzUgMS45ODQzNzUgMC42ODc1IDQuMTQwNjI1cTAgMi40Njg3NSAtMC45Mzc1IDQuNzY1NjI1cS0wLjkzNzUgMi4yOTY4NzUgLTIuMjgxMjUgNC4weiIgZmlsbC1ydWxlPSJub256ZXJvIi8+PHBhdGggZmlsbD0iI2ZmZmZmZiIgZD0ibTQ2NS42NTYxNiAxOTAuMzM4NThsMTYyLjU3NzE4IDBsMCAyMi40MDAwMWwtMTYyLjU3NzE4IDBsMCAtMjIuNDAwMDF6IiBmaWxsLXJ1bGU9Im5vbnplcm8iLz48cGF0aCBmaWxsPSIjMDAwMDAwIiBmaWxsLW9wYWNpdHk9IjAuMCIgZD0ibTQ2NS42NTYxNiAxOTEuMzY5NTdsMTYyLjU3NzE4IDBsMCAyMS40NTI4NjZsLTE2Mi41NzcxOCAwbDAgLTIxLjQ1Mjg2NnoiIGZpbGwtcnVsZT0ibm9uemVybyIvPjxwYXRoIGZpbGw9IiNlNjkxMzgiIGQ9Im00NjYuMjM0MjggMjA1LjM2Nzk1bDEuNjI1IC0wLjI1cTAuMTI1IDAuOTY4NzUgMC43NSAxLjVxMC42MjUgMC41MTU2MjUgMS43NSAwLjUxNTYyNXExLjEyNSAwIDEuNjcxODc1IC0wLjQ1MzEyNXEwLjU0Njg3NSAtMC40Njg3NSAwLjU0Njg3NSAtMS4wOTM3NXEwIC0wLjU0Njg3NSAtMC40ODQzNzUgLTAuODc1cS0wLjMyODEyNSAtMC4yMTg3NSAtMS42NzE4NzUgLTAuNTQ2ODc1cS0xLjgxMjUgLTAuNDY4NzUgLTIuNTE1NjI1IC0wLjc5Njg3NXEtMC42ODc1IC0wLjMyODEyNSAtMS4wNDY4NzUgLTAuOTA2MjVxLTAuMzU5Mzc1IC0wLjU5Mzc1IC0wLjM1OTM3NSAtMS4zMTI1cTAgLTAuNjQwNjI1IDAuMjk2ODc1IC0xLjE4NzVxMC4yOTY4NzUgLTAuNTYyNSAwLjgxMjUgLTAuOTIxODc1cTAuMzc1IC0wLjI4MTI1IDEuMDMxMjUgLTAuNDY4NzVxMC42NzE4NzUgLTAuMjAzMTI1IDEuNDIxODc1IC0wLjIwMzEyNXExLjE0MDYyNSAwIDIuMCAwLjMyODEyNXEwLjg1OTM3NSAwLjMyODEyNSAxLjI2NTYyNSAwLjg5MDYyNXEwLjQyMTg3NSAwLjU2MjUgMC41NzgxMjUgMS41bC0xLjYwOTM3NSAwLjIxODc1cS0wLjEwOTM3NSAtMC43NSAtMC42NDA2MjUgLTEuMTcxODc1cS0wLjUxNTYyNSAtMC40MjE4NzUgLTEuNDY4NzUgLTAuNDIxODc1cS0xLjE0MDYyNSAwIC0xLjYyNSAwLjM3NXEtMC40Njg3NSAwLjM3NSAtMC40Njg3NSAwLjg3NXEwIDAuMzEyNSAwLjE4NzUgMC41NzgxMjVxMC4yMDMxMjUgMC4yNjU2MjUgMC42NDA2MjUgMC40Mzc1cTAuMjM0Mzc1IDAuMDkzNzUgMS40Mzc1IDAuNDIxODc1cTEuNzUgMC40NTMxMjUgMi40Mzc1IDAuNzVxMC42ODc1IDAuMjk2ODc1IDEuMDc4MTI1IDAuODU5Mzc1cTAuMzkwNjI1IDAuNTYyNSAwLjM5MDYyNSAxLjQwNjI1cTAgMC44MjgxMjUgLTAuNDg0Mzc1IDEuNTQ2ODc1cS0wLjQ2ODc1IDAuNzE4NzUgLTEuMzc1IDEuMTI1cS0wLjkwNjI1IDAuMzkwNjI1IC0yLjA0Njg3NSAwLjM5MDYyNXEtMS44NzUgMCAtMi44NzUgLTAuNzgxMjVxLTAuOTg0Mzc1IC0wLjc4MTI1IC0xLjI1IC0yLjMyODEyNXptMTYuNjA5Mzc1IC0wLjIxODc1bDEuNjg3NSAwLjIwMzEyNXEtMC40MDYyNSAxLjQ4NDM3NSAtMS40ODQzNzUgMi4zMTI1cS0xLjA3ODEyNSAwLjgxMjUgLTIuNzY1NjI1IDAuODEyNXEtMi4xMjUgMCAtMy4zNzUgLTEuMjk2ODc1cS0xLjIzNDM3NSAtMS4zMTI1IC0xLjIzNDM3NSAtMy42NzE4NzVxMCAtMi40NTMxMjUgMS4yNSAtMy43OTY4NzVxMS4yNjU2MjUgLTEuMzQzNzUgMy4yNjU2MjUgLTEuMzQzNzVxMS45Mzc1IDAgMy4xNTYyNSAxLjMyODEyNXExLjIzNDM3NSAxLjMxMjUgMS4yMzQzNzUgMy43MDMxMjVxMCAwLjE1NjI1IDAgMC40Mzc1bC03LjIxODc1IDBxMC4wOTM3NSAxLjU5Mzc1IDAuOTA2MjUgMi40NTMxMjVxMC44MTI1IDAuODQzNzUgMi4wMTU2MjUgMC44NDM3NXEwLjkwNjI1IDAgMS41NDY4NzUgLTAuNDY4NzVxMC42NDA2MjUgLTAuNDg0Mzc1IDEuMDE1NjI1IC0xLjUxNTYyNXptLTUuMzkwNjI1IC0yLjY1NjI1bDUuNDA2MjUgMHEtMC4xMDkzNzUgLTEuMjE4NzUgLTAuNjI1IC0xLjgyODEyNXEtMC43ODEyNSAtMC45NTMxMjUgLTIuMDMxMjUgLTAuOTUzMTI1cS0xLjEyNSAwIC0xLjkwNjI1IDAuNzY1NjI1cS0wLjc2NTYyNSAwLjc1IC0wLjg0Mzc1IDIuMDE1NjI1em05LjE3MjYwNyA5LjQ2ODc1bDAgLTE3LjA2MjVsMy42MDkzNzUgMGwwIDEuMzU5Mzc1bC0xLjk2ODc1IDBsMCAxNC4zNDM3NWwxLjk2ODc1IDBsMCAxLjM1OTM3NWwtMy42MDkzNzUgMHptNS41NzM5MTM2IC0zLjcwMzEyNWwwIC0xLjg3NWwxLjg3NSAwbDAgMS44NzVxMCAxLjAzMTI1IC0wLjM3NSAxLjY1NjI1cS0wLjM1OTM3NSAwLjY0MDYyNSAtMS4xNTYyNSAwLjk4NDM3NWwtMC40NTMxMjUgLTAuNzAzMTI1cTAuNTE1NjI1IC0wLjIxODc1IDAuNzY1NjI1IC0wLjY3MTg3NXEwLjI1IC0wLjQzNzUgMC4yODEyNSAtMS4yNjU2MjVsLTAuOTM3NSAwem05LjI4ODQ4MyAtMi44OTA2MjVsMS42MjUgLTAuMjVxMC4xMjUgMC45Njg3NSAwLjc1IDEuNXEwLjYyNSAwLjUxNTYyNSAxLjc1IDAuNTE1NjI1cTEuMTI1IDAgMS42NzE4NzUgLTAuNDUzMTI1cTAuNTQ2ODc1IC0wLjQ2ODc1IDAuNTQ2ODc1IC0xLjA5Mzc1cTAgLTAuNTQ2ODc1IC0wLjQ4NDM3NSAtMC44NzVxLTAuMzI4MTI1IC0wLjIxODc1IC0xLjY3MTg3NSAtMC41NDY4NzVxLTEuODEyNSAtMC40Njg3NSAtMi41MTU2MjUgLTAuNzk2ODc1cS0wLjY4NzUgLTAuMzI4MTI1IC0xLjA0Njg3NSAtMC45MDYyNXEtMC4zNTkzNzUgLTAuNTkzNzUgLTAuMzU5Mzc1IC0xLjMxMjVxMCAtMC42NDA2MjUgMC4yOTY4NzUgLTEuMTg3NXEwLjI5Njg3NSAtMC41NjI1IDAuODEyNSAtMC45MjE4NzVxMC4zNzUgLTAuMjgxMjUgMS4wMzEyNSAtMC40Njg3NXEwLjY3MTg3NSAtMC4yMDMxMjUgMS40MjE4NzUgLTAuMjAzMTI1cTEuMTQwNjI1IDAgMi4wIDAuMzI4MTI1cTAuODU5Mzc1IDAuMzI4MTI1IDEuMjY1NjI1IDAuODkwNjI1cTAuNDIxODc1IDAuNTYyNSAwLjU3ODEyNSAxLjVsLTEuNjA5Mzc1IDAuMjE4NzVxLTAuMTA5Mzc1IC0wLjc1IC0wLjY0MDYyNSAtMS4xNzE4NzVxLTAuNTE1NjI1IC0wLjQyMTg3NSAtMS40Njg3NSAtMC40MjE4NzVxLTEuMTQwNjI1IDAgLTEuNjI1IDAuMzc1cS0wLjQ2ODc1IDAuMzc1IC0wLjQ2ODc1IDAuODc1cTAgMC4zMTI1IDAuMTg3NSAwLjU3ODEyNXEwLjIwMzEyNSAwLjI2NTYyNSAwLjY0MDYyNSAwLjQzNzVxMC4yMzQzNzUgMC4wOTM3NSAxLjQzNzUgMC40MjE4NzVxMS43NSAwLjQ1MzEyNSAyLjQzNzUgMC43NXEwLjY4NzUgMC4yOTY4NzUgMS4wNzgxMjUgMC44NTkzNzVxMC4zOTA2MjUgMC41NjI1IDAuMzkwNjI1IDEuNDA2MjVxMCAwLjgyODEyNSAtMC40ODQzNzUgMS41NDY4NzVxLTAuNDY4NzUgMC43MTg3NSAtMS4zNzUgMS4xMjVxLTAuOTA2MjUgMC4zOTA2MjUgLTIuMDQ2ODc1IDAuMzkwNjI1cS0xLjg3NSAwIC0yLjg3NSAtMC43ODEyNXEtMC45ODQzNzUgLTAuNzgxMjUgLTEuMjUgLTIuMzI4MTI1em0xNi42MDkzNzUgLTAuMjE4NzVsMS42ODc1IDAuMjAzMTI1cS0wLjQwNjI1IDEuNDg0Mzc1IC0xLjQ4NDM3NSAyLjMxMjVxLTEuMDc4MTI1IDAuODEyNSAtMi43NjU2MjUgMC44MTI1cS0yLjEyNSAwIC0zLjM3NSAtMS4yOTY4NzVxLTEuMjM0Mzc1IC0xLjMxMjUgLTEuMjM0Mzc1IC0zLjY3MTg3NXEwIC0yLjQ1MzEyNSAxLjI1IC0zLjc5Njg3NXExLjI2NTYyNSAtMS4zNDM3NSAzLjI2NTYyNSAtMS4zNDM3NXExLjkzNzUgMCAzLjE1NjI1IDEuMzI4MTI1cTEuMjM0Mzc1IDEuMzEyNSAxLjIzNDM3NSAzLjcwMzEyNXEwIDAuMTU2MjUgMCAwLjQzNzVsLTcuMjE4NzUgMHEwLjA5Mzc1IDEuNTkzNzUgMC45MDYyNSAyLjQ1MzEyNXEwLjgxMjUgMC44NDM3NSAyLjAxNTYyNSAwLjg0Mzc1cTAuOTA2MjUgMCAxLjU0Njg3NSAtMC40Njg3NXEwLjY0MDYyNSAtMC40ODQzNzUgMS4wMTU2MjUgLTEuNTE1NjI1em0tNS4zOTA2MjUgLTIuNjU2MjVsNS40MDYyNSAwcS0wLjEwOTM3NSAtMS4yMTg3NSAtMC42MjUgLTEuODI4MTI1cS0wLjc4MTI1IC0wLjk1MzEyNSAtMi4wMzEyNSAtMC45NTMxMjVxLTEuMTI1IDAgLTEuOTA2MjUgMC43NjU2MjVxLTAuNzY1NjI1IDAuNzUgLTAuODQzNzUgMi4wMTU2MjV6bTEyLjU0NzYwNyA3LjY4NzVsMCAtMS42NDA2MjVxLTEuMjE4NzUgLTAuMTU2MjUgLTIuMCAtMC41NDY4NzVxLTAuNzY1NjI1IC0wLjQwNjI1IC0xLjMyODEyNSAtMS4yODEyNXEtMC41NjI1IC0wLjg5MDYyNSAtMC42NDA2MjUgLTIuMTU2MjVsMS42NDA2MjUgLTAuMzEyNXEwLjE4NzUgMS4zMTI1IDAuNjcxODc1IDEuOTM3NXEwLjcwMzEyNSAwLjg3NSAxLjY1NjI1IDAuOTY4NzVsMCAtNS4yMTg3NXEtMS4wIC0wLjE4NzUgLTIuMDYyNSAtMC43ODEyNXEtMC43ODEyNSAtMC40Mzc1IC0xLjIwMzEyNSAtMS4yMDMxMjVxLTAuNDIxODc1IC0wLjc4MTI1IC0wLjQyMTg3NSAtMS43NjU2MjVxMCAtMS43NSAxLjIzNDM3NSAtMi44MjgxMjVxMC44MjgxMjUgLTAuNzM0Mzc1IDIuNDUzMTI1IC0wLjg5MDYyNWwwIC0wLjc4MTI1bDAuOTY4NzUgMGwwIDAuNzgxMjVxMS40Mzc1IDAuMTI1IDIuMjY1NjI1IDAuODI4MTI1cTEuMDc4MTI1IDAuOTA2MjUgMS4yOTY4NzUgMi40NTMxMjVsLTEuNjg3NSAwLjI2NTYyNXEtMC4xNTYyNSAtMC45Njg3NSAtMC42MjUgLTEuNDg0Mzc1cS0wLjQ1MzEyNSAtMC41MTU2MjUgLTEuMjUgLTAuNjg3NWwwIDQuNzM0Mzc1cTEuMjM0Mzc1IDAuMzEyNSAxLjY0MDYyNSAwLjQ4NDM3NXEwLjc2NTYyNSAwLjMyODEyNSAxLjI1IDAuODEyNXEwLjQ4NDM3NSAwLjQ4NDM3NSAwLjczNDM3NSAxLjE1NjI1cTAuMjY1NjI1IDAuNjU2MjUgMC4yNjU2MjUgMS40Mzc1cTAgMS43MDMxMjUgLTEuMDkzNzUgMi44NDM3NXEtMS4wNzgxMjUgMS4xNDA2MjUgLTIuNzk2ODc1IDEuMjE4NzVsMCAxLjY1NjI1bC0wLjk2ODc1IDB6bTAgLTE0LjM1OTM3NXEtMC45NTMxMjUgMC4xNTYyNSAtMS41IDAuNzgxMjVxLTAuNTQ2ODc1IDAuNjA5Mzc1IC0wLjU0Njg3NSAxLjQ1MzEyNXEwIDAuODQzNzUgMC40Njg3NSAxLjQwNjI1cTAuNDY4NzUgMC41NjI1IDEuNTc4MTI1IDAuOTA2MjVsMCAtNC41NDY4NzV6bTAuOTY4NzUgMTEuMzI4MTI1cTAuOTUzMTI1IC0wLjEwOTM3NSAxLjU3ODEyNSAtMC44MTI1cTAuNjI1IC0wLjcxODc1IDAuNjI1IC0xLjc2NTYyNXEwIC0wLjg5MDYyNSAtMC40Mzc1IC0xLjQzNzVxLTAuNDM3NSAtMC41NDY4NzUgLTEuNzY1NjI1IC0wLjk2ODc1bDAgNC45ODQzNzV6bTEyLjI2NjM1NyAxLjEwOTM3NWwwIC0xLjIxODc1cS0wLjkwNjI1IDEuNDM3NSAtMi43MDMxMjUgMS40Mzc1cS0xLjE1NjI1IDAgLTIuMTI1IC0wLjY0MDYyNXEtMC45Njg3NSAtMC42NDA2MjUgLTEuNSAtMS43ODEyNXEtMC41MzEyNSAtMS4xNDA2MjUgLTAuNTMxMjUgLTIuNjI1cTAgLTEuNDUzMTI1IDAuNDg0Mzc1IC0yLjYyNXEwLjQ4NDM3NSAtMS4xODc1IDEuNDM3NSAtMS44MTI1cTAuOTY4NzUgLTAuNjI1IDIuMTcxODc1IC0wLjYyNXEwLjg3NSAwIDEuNTQ2ODc1IDAuMzc1cTAuNjg3NSAwLjM1OTM3NSAxLjEwOTM3NSAwLjk1MzEyNWwwIC00Ljc5Njg3NWwxLjY0MDYyNSAwbDAgMTMuMzU5Mzc1bC0xLjUzMTI1IDB6bS01LjE3MTg3NSAtNC44MjgxMjVxMCAxLjg1OTM3NSAwLjc4MTI1IDIuNzgxMjVxMC43ODEyNSAwLjkyMTg3NSAxLjg0Mzc1IDAuOTIxODc1cTEuMDc4MTI1IDAgMS44MjgxMjUgLTAuODc1cTAuNzUgLTAuODkwNjI1IDAuNzUgLTIuNjg3NXEwIC0xLjk4NDM3NSAtMC43NjU2MjUgLTIuOTA2MjVxLTAuNzY1NjI1IC0wLjkzNzUgLTEuODkwNjI1IC0wLjkzNzVxLTEuMDc4MTI1IDAgLTEuODEyNSAwLjg5MDYyNXEtMC43MzQzNzUgMC44OTA2MjUgLTAuNzM0Mzc1IDIuODEyNXptMTUuOTA2OTIxIDEuNzE4NzVsMS42ODc1IDAuMjAzMTI1cS0wLjQwNjI1IDEuNDg0Mzc1IC0xLjQ4NDM3NSAyLjMxMjVxLTEuMDc4MTI1IDAuODEyNSAtMi43NjU2MjUgMC44MTI1cS0yLjEyNSAwIC0zLjM3NSAtMS4yOTY4NzVxLTEuMjM0Mzc1IC0xLjMxMjUgLTEuMjM0Mzc1IC0zLjY3MTg3NXEwIC0yLjQ1MzEyNSAxLjI1IC0zLjc5Njg3NXExLjI2NTYyNSAtMS4zNDM3NSAzLjI2NTYyNSAtMS4zNDM3NXExLjkzNzUgMCAzLjE1NjI1IDEuMzI4MTI1cTEuMjM0Mzc1IDEuMzEyNSAxLjIzNDM3NSAzLjcwMzEyNXEwIDAuMTU2MjUgMCAwLjQzNzVsLTcuMjE4NzUgMHEwLjA5Mzc1IDEuNTkzNzUgMC45MDYyNSAyLjQ1MzEyNXEwLjgxMjUgMC44NDM3NSAyLjAxNTYyNSAwLjg0Mzc1cTAuOTA2MjUgMCAxLjU0Njg3NSAtMC40Njg3NXEwLjY0MDYyNSAtMC40ODQzNzUgMS4wMTU2MjUgLTEuNTE1NjI1em0tNS4zOTA2MjUgLTIuNjU2MjVsNS40MDYyNSAwcS0wLjEwOTM3NSAtMS4yMTg3NSAtMC42MjUgLTEuODI4MTI1cS0wLjc4MTI1IC0wLjk1MzEyNSAtMi4wMzEyNSAtMC45NTMxMjVxLTEuMTI1IDAgLTEuOTA2MjUgMC43NjU2MjVxLTAuNzY1NjI1IDAuNzUgLTAuODQzNzUgMi4wMTU2MjV6bTguMDQ3NjA3IDUuNzY1NjI1bDMuNTMxMjUgLTUuMDMxMjVsLTMuMjY1NjI1IC00LjY0MDYyNWwyLjA0Njg3NSAwbDEuNDg0Mzc1IDIuMjY1NjI1cTAuNDIxODc1IDAuNjQwNjI1IDAuNjcxODc1IDEuMDc4MTI1cTAuNDA2MjUgLTAuNTkzNzUgMC43MzQzNzUgLTEuMDYyNWwxLjY0MDYyNSAtMi4yODEyNWwxLjk1MzEyNSAwbC0zLjM0Mzc1IDQuNTQ2ODc1bDMuNTkzNzUgNS4xMjVsLTIuMDE1NjI1IDBsLTEuOTg0Mzc1IC0zLjBsLTAuNTE1NjI1IC0wLjgxMjVsLTIuNTQ2ODc1IDMuODEyNWwtMS45ODQzNzUgMHptMjQuMjMwMTY0IC03Ljg1OTM3NWwtOC44MjgxMjUgMGwwIC0xLjUxNTYyNWw4LjgyODEyNSAwbDAgMS41MTU2MjV6bTAgNC4wNjI1bC04LjgyODEyNSAwbDAgLTEuNTMxMjVsOC44MjgxMjUgMGwwIDEuNTMxMjV6bTEwLjg5NDk1ODUgLTQuMDYyNWwtOC44MjgxMjUgMGwwIC0xLjUxNTYyNWw4LjgyODEyNSAwbDAgMS41MTU2MjV6bTAgNC4wNjI1bC04LjgyODEyNSAwbDAgLTEuNTMxMjVsOC44MjgxMjUgMGwwIDEuNTMxMjV6bTcuNTMxNDMzIC00LjgyODEyNWwtMC40NTMxMjUgLTIuNTQ2ODc1bDAgLTIuMTg3NWwxLjg1OTM3NSAwbDAgMi4xODc1bC0wLjQwNjI1IDIuNTQ2ODc1bC0xLjAgMHptMy4wMTU2MjUgMGwtMC40NTMxMjUgLTIuNTQ2ODc1bDAgLTIuMTg3NWwxLjg3NSAwbDAgMi4xODc1bC0wLjQzNzUgMi41NDY4NzVsLTAuOTg0Mzc1IDB6bTcuMTA2OTMzNiA3LjE1NjI1bDAuMjM0Mzc1IDEuNDUzMTI1cS0wLjY4NzUgMC4xNDA2MjUgLTEuMjM0Mzc1IDAuMTQwNjI1cS0wLjg5MDYyNSAwIC0xLjM5MDYyNSAtMC4yODEyNXEtMC40ODQzNzUgLTAuMjgxMjUgLTAuNjg3NSAtMC43MzQzNzVxLTAuMjAzMTI1IC0wLjQ2ODc1IC0wLjIwMzEyNSAtMS45Mzc1bDAgLTUuNTc4MTI1bC0xLjIwMzEyNSAwbDAgLTEuMjY1NjI1bDEuMjAzMTI1IDBsMCAtMi4zOTA2MjVsMS42MjUgLTAuOTg0Mzc1bDAgMy4zNzVsMS42NTYyNSAwbDAgMS4yNjU2MjVsLTEuNjU2MjUgMGwwIDUuNjcxODc1cTAgMC42ODc1IDAuMDc4MTI1IDAuODkwNjI1cTAuMDkzNzUgMC4yMDMxMjUgMC4yODEyNSAwLjMyODEyNXEwLjIwMzEyNSAwLjEwOTM3NSAwLjU3ODEyNSAwLjEwOTM3NXEwLjI2NTYyNSAwIDAuNzE4NzUgLTAuMDYyNXptMS41ODk1OTk2IDEuNDY4NzVsMCAtOS42NzE4NzVsMS40Njg3NSAwbDAgMS40Njg3NXEwLjU2MjUgLTEuMDMxMjUgMS4wMzEyNSAtMS4zNTkzNzVxMC40ODQzNzUgLTAuMzI4MTI1IDEuMDYyNSAtMC4zMjgxMjVxMC44MjgxMjUgMCAxLjY4NzUgMC41MzEyNWwtMC41NjI1IDEuNTE1NjI1cS0wLjYwOTM3NSAtMC4zNTkzNzUgLTEuMjAzMTI1IC0wLjM1OTM3NXEtMC41NDY4NzUgMCAtMC45Njg3NSAwLjMyODEyNXEtMC40MjE4NzUgMC4zMjgxMjUgLTAuNjA5Mzc1IDAuODkwNjI1cS0wLjI4MTI1IDAuODc1IC0wLjI4MTI1IDEuOTIxODc1bDAgNS4wNjI1bC0xLjYyNSAwem05LjgwNjM5NjUgLTEuNDY4NzVsMC4yMzQzNzUgMS40NTMxMjVxLTAuNjg3NSAwLjE0MDYyNSAtMS4yMzQzNzUgMC4xNDA2MjVxLTAuODkwNjI1IDAgLTEuMzkwNjI1IC0wLjI4MTI1cS0wLjQ4NDM3NSAtMC4yODEyNSAtMC42ODc1IC0wLjczNDM3NXEtMC4yMDMxMjUgLTAuNDY4NzUgLTAuMjAzMTI1IC0xLjkzNzVsMCAtNS41NzgxMjVsLTEuMjAzMTI1IDBsMCAtMS4yNjU2MjVsMS4yMDMxMjUgMGwwIC0yLjM5MDYyNWwxLjYyNSAtMC45ODQzNzVsMCAzLjM3NWwxLjY1NjI1IDBsMCAxLjI2NTYyNWwtMS42NTYyNSAwbDAgNS42NzE4NzVxMCAwLjY4NzUgMC4wNzgxMjUgMC44OTA2MjVxMC4wOTM3NSAwLjIwMzEyNSAwLjI4MTI1IDAuMzI4MTI1cTAuMjAzMTI1IDAuMTA5Mzc1IDAuNTc4MTI1IDAuMTA5Mzc1cTAuMjY1NjI1IDAgMC43MTg3NSAtMC4wNjI1em0xLjY4MzI4ODYgLTcuMTU2MjVsLTAuNDUzMTI1IC0yLjU0Njg3NWwwIC0yLjE4NzVsMS44NTkzNzUgMGwwIDIuMTg3NWwtMC40MDYyNSAyLjU0Njg3NWwtMS4wIDB6bTMuMDE1NjI1IDBsLTAuNDUzMTI1IC0yLjU0Njg3NWwwIC0yLjE4NzVsMS44NzUgMGwwIDIuMTg3NWwtMC40Mzc1IDIuNTQ2ODc1bC0wLjk4NDM3NSAwem02LjI2MzI0NDYgMTIuMzI4MTI1bC0zLjYwOTM3NSAwbDAgLTEuMzU5Mzc1bDEuOTY4NzUgMGwwIC0xNC4zNDM3NWwtMS45Njg3NSAwbDAgLTEuMzU5Mzc1bDMuNjA5Mzc1IDBsMCAxNy4wNjI1eiIgZmlsbC1ydWxlPSJub256ZXJvIi8+PHBhdGggZmlsbD0iIzAwMDAwMCIgZmlsbC1vcGFjaXR5PSIwLjAiIGQ9Im04Ljg3MTM5MUUtNSA0NjguMjI4MzNsMjQ5LjMyMjgzIDBsMCA3OC4yMzYyMDZsLTI0OS4zMjI4MyAweiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PHBhdGggZmlsbD0iIzAwMDAwMCIgZD0ibTEwLjIxODgzOSA0OTUuMTQ4MzVsMCAtOS42NzE4NzVsMS40Njg3NSAwbDAgMS40Njg3NXEwLjU2MjUgLTEuMDMxMjUgMS4wMzEyNSAtMS4zNTkzNzVxMC40ODQzNzUgLTAuMzI4MTI1IDEuMDYyNSAtMC4zMjgxMjVxMC44MjgxMjUgMCAxLjY4NzUgMC41MzEyNWwtMC41NjI1IDEuNTE1NjI1cS0wLjYwOTM3NSAtMC4zNTkzNzUgLTEuMjAzMTI1IC0wLjM1OTM3NXEtMC41NDY4NzUgMCAtMC45Njg3NSAwLjMyODEyNXEtMC40MjE4NzUgMC4zMjgxMjUgLTAuNjA5Mzc1IDAuODkwNjI1cS0wLjI4MTI1IDAuODc1IC0wLjI4MTI1IDEuOTIxODc1bDAgNS4wNjI1bC0xLjYyNSAwem01LjYxODkyNyAtNC44NDM3NXEwIC0yLjY4NzUgMS40ODQzNzYgLTMuOTY4NzVxMS4yNSAtMS4wNzgxMjUgMy4wNDY4NzUgLTEuMDc4MTI1cTIuMCAwIDMuMjY1NjI1IDEuMzEyNXExLjI2NTYyNSAxLjI5Njg3NSAxLjI2NTYyNSAzLjYwOTM3NXEwIDEuODU5Mzc1IC0wLjU2MjUgMi45Mzc1cS0wLjU2MjUgMS4wNjI1IC0xLjY0MDYyNSAxLjY1NjI1cS0xLjA2MjUgMC41OTM3NSAtMi4zMjgxMjUgMC41OTM3NXEtMi4wMzEyNSAwIC0zLjI4MTI1IC0xLjI5Njg3NXEtMS4yNTAwMDEgLTEuMzEyNSAtMS4yNTAwMDEgLTMuNzY1NjI1em0xLjY4NzUwMSAwcTAgMS44NTkzNzUgMC43OTY4NzUgMi43OTY4NzVxMC44MTI1IDAuOTIxODc1IDIuMDQ2ODc1IDAuOTIxODc1cTEuMjE4NzUgMCAyLjAzMTI1IC0wLjkyMTg3NXEwLjgxMjUgLTAuOTM3NSAwLjgxMjUgLTIuODQzNzVxMCAtMS43OTY4NzUgLTAuODEyNSAtMi43MTg3NXEtMC44MTI1IC0wLjkyMTg3NSAtMi4wMzEyNSAtMC45MjE4NzVxLTEuMjM0Mzc1IDAgLTIuMDQ2ODc1IDAuOTIxODc1cS0wLjc5Njg3NSAwLjkwNjI1IC0wLjc5Njg3NSAyLjc2NTYyNXptMTEuMDc4ODQyIDQuODQzNzVsLTIuOTY4NzUgLTkuNjcxODc1bDEuNzAzMTI1IDBsMS41MzEyNSA1LjU3ODEyNWwwLjU3ODEyNSAyLjA3ODEyNXEwLjA0Njg3NSAtMC4xNTYyNSAwLjUgLTIuMGwxLjU0Njg3NSAtNS42NTYyNWwxLjY4NzQ5ODEgMGwxLjQzNzUgNS42MDkzNzVsMC40ODQzNzUgMS44NDM3NWwwLjU2MjUgLTEuODU5Mzc1bDEuNjU2MjUgLTUuNTkzNzVsMS41OTM3NSAwbC0zLjAzMTI1IDkuNjcxODc1bC0xLjcwMzEyNSAwbC0xLjUzMTI1IC01Ljc5Njg3NWwtMC4zNzUgLTEuNjQwNjI1bC0xLjk1MzEyMzEgNy40Mzc1bC0xLjcxODc1IDB6bTExLjkyNjA2OSAwbDAgLTEzLjM1OTM3NWw1LjkyMTg3NSAwcTEuNzgxMjUgMCAyLjcwMzEyNSAwLjM1OTM3NXEwLjkzNzUgMC4zNTkzNzUgMS40ODQzNzUgMS4yODEyNXEwLjU2MjUgMC45MDYyNSAwLjU2MjUgMi4wMTU2MjVxMCAxLjQwNjI1IC0wLjkyMTg3NSAyLjM5MDYyNXEtMC45MjE4NzUgMC45Njg3NSAtMi44NDM3NSAxLjIzNDM3NXEwLjcwMzEyNSAwLjM0Mzc1IDEuMDc4MTI1IDAuNjcxODc1cTAuNzY1NjI1IDAuNzAzMTI1IDEuNDUzMTI1IDEuNzY1NjI1bDIuMzI4MTI1IDMuNjQwNjI1bC0yLjIxODc1IDBsLTEuNzY1NjI1IC0yLjc4MTI1cS0wLjc4MTI1IC0xLjIwMzEyNSAtMS4yODEyNSAtMS44MjgxMjVxLTAuNSAtMC42NDA2MjUgLTAuOTA2MjUgLTAuODkwNjI1cS0wLjM5MDYyNSAtMC4yNjU2MjUgLTAuNzk2ODc1IC0wLjM1OTM3NXEtMC4yOTY4NzUgLTAuMDc4MTI1IC0wLjk4NDM3NSAtMC4wNzgxMjVsLTIuMDQ2ODc1IDBsMCA1LjkzNzVsLTEuNzY1NjI1IDB6bTEuNzY1NjI1IC03LjQ1MzEyNWwzLjc5Njg3NSAwcTEuMjE4NzUgMCAxLjg5MDYyNSAtMC4yNXEwLjY4NzUgLTAuMjY1NjI1IDEuMDQ2ODc1IC0wLjgxMjVxMC4zNTkzNzUgLTAuNTQ2ODc1IDAuMzU5Mzc1IC0xLjE4NzVxMCAtMC45NTMxMjUgLTAuNjg3NSAtMS41NjI1cS0wLjY4NzUgLTAuNjA5Mzc1IC0yLjE4NzUgLTAuNjA5Mzc1bC00LjIxODc1IDBsMCA0LjQyMTg3NXptMTcuNzg1NDQ2IDYuMjY1NjI1cS0wLjkyMTg3NSAwLjc2NTYyNSAtMS43NjU2MjUgMS4wOTM3NXEtMC44MjgxMjUgMC4zMTI1IC0xLjc5Njg3NSAwLjMxMjVxLTEuNTkzNzUgMCAtMi40NTMxMjUgLTAuNzgxMjVxLTAuODU5Mzc1IC0wLjc4MTI1IC0wLjg1OTM3NSAtMS45ODQzNzVxMCAtMC43MTg3NSAwLjMyODEyNSAtMS4yOTY4NzVxMC4zMjgxMjUgLTAuNTkzNzUgMC44NDM3NSAtMC45Mzc1cTAuNTMxMjUgLTAuMzU5Mzc1IDEuMTg3NSAtMC41NDY4NzVxMC40Njg3NSAtMC4xMjUgMS40NTMxMjUgLTAuMjVxMS45ODQzNzUgLTAuMjM0Mzc1IDIuOTIxODc1IC0wLjU2MjVxMC4wMTU2MjUgLTAuMzQzNzUgMC4wMTU2MjUgLTAuNDIxODc1cTAgLTEuMCAtMC40Njg3NSAtMS40MjE4NzVxLTAuNjI1IC0wLjU0Njg3NSAtMS44NzUgLTAuNTQ2ODc1cS0xLjE1NjI1IDAgLTEuNzAzMTI1IDAuNDA2MjVxLTAuNTQ2ODc1IDAuNDA2MjUgLTAuODEyNSAxLjQyMTg3NWwtMS42MDkzNzUgLTAuMjE4NzVxMC4yMTg3NSAtMS4wMTU2MjUgMC43MTg3NSAtMS42NDA2MjVxMC41IC0wLjY0MDYyNSAxLjQ1MzEyNSAtMC45ODQzNzVxMC45NTMxMjUgLTAuMzQzNzUgMi4xODc1IC0wLjM0Mzc1cTEuMjUgMCAyLjAxNTYyNSAwLjI5Njg3NXEwLjc4MTI1IDAuMjgxMjUgMS4xNDA2MjUgMC43MzQzNzVxMC4zNzUgMC40Mzc1IDAuNTE1NjI1IDEuMTA5Mzc1cTAuMDc4MTI1IDAuNDIxODc1IDAuMDc4MTI1IDEuNTE1NjI1bDAgMi4xODc1cTAgMi4yODEyNSAwLjEwOTM3NSAyLjg5MDYyNXEwLjEwOTM3NSAwLjU5Mzc1IDAuNDA2MjUgMS4xNTYyNWwtMS43MDMxMjUgMHEtMC4yNjU2MjUgLTAuNTE1NjI1IC0wLjMyODEyNSAtMS4xODc1em0tMC4xNDA2MjUgLTMuNjcxODc1cS0wLjg5MDYyNSAwLjM3NSAtMi42NzE4NzUgMC42MjVxLTEuMDE1NjI1IDAuMTQwNjI1IC0xLjQzNzUgMC4zMjgxMjVxLTAuNDIxODc1IDAuMTg3NSAtMC42NTYyNSAwLjUzMTI1cS0wLjIxODc1IDAuMzQzNzUgLTAuMjE4NzUgMC43ODEyNXEwIDAuNjU2MjUgMC41IDEuMDkzNzVxMC41IDAuNDM3NSAxLjQ1MzEyNSAwLjQzNzVxMC45Mzc1IDAgMS42NzE4NzUgLTAuNDA2MjVxMC43NSAtMC40MjE4NzUgMS4wOTM3NSAtMS4xNDA2MjVxMC4yNjU2MjUgLTAuNTYyNSAwLjI2NTYyNSAtMS42NDA2MjVsMCAtMC42MDkzNzV6bTQuMjAzODQ2IDQuODU5Mzc1bDAgLTkuNjcxODc1bDEuNDY4NzUgMGwwIDEuMzc1cTEuMDYyNSAtMS41OTM3NSAzLjA3ODEyNSAtMS41OTM3NXEwLjg3NSAwIDEuNjA5Mzc1IDAuMzEyNXEwLjczNDM3NSAwLjMxMjUgMS4wOTM3NSAwLjgyODEyNXEwLjM3NSAwLjUgMC41MTU2MjUgMS4yMDMxMjVxMC4wOTM3NSAwLjQ1MzEyNSAwLjA5Mzc1IDEuNTkzNzVsMCA1Ljk1MzEyNWwtMS42NDA2MjUgMGwwIC01Ljg5MDYyNXEwIC0xLjAgLTAuMjAzMTI1IC0xLjQ4NDM3NXEtMC4xODc1IC0wLjUgLTAuNjcxODc1IC0wLjc5Njg3NXEtMC40ODQzNzUgLTAuMjk2ODc1IC0xLjE0MDYyNSAtMC4yOTY4NzVxLTEuMDQ2ODc1IDAgLTEuODEyNSAwLjY3MTg3NXEtMC43NSAwLjY1NjI1IC0wLjc1IDIuNTE1NjI1bDAgNS4yODEyNWwtMS42NDA2MjUgMHptMTAuMDYzMjE3IDAuNzk2ODc1bDEuNTkzNzUgMC4yMzQzNzVxMC4xMDkzNzUgMC43NSAwLjU2MjUgMS4wNzgxMjVxMC42MDkzNzUgMC40NTMxMjUgMS42NzE4NzUgMC40NTMxMjVxMS4xNDA2MjUgMCAxLjc1IC0wLjQ1MzEyNXEwLjYyNSAtMC40NTMxMjUgMC44NDM3NSAtMS4yNjU2MjVxMC4xMjUgLTAuNSAwLjEwOTM3NSAtMi4xMDkzNzVxLTEuMDYyNSAxLjI2NTYyNSAtMi42NzE4NzUgMS4yNjU2MjVxLTIuMCAwIC0zLjA5Mzc1IC0xLjQzNzVxLTEuMDkzNzUgLTEuNDM3NSAtMS4wOTM3NSAtMy40NTMxMjVxMCAtMS4zOTA2MjUgMC41IC0yLjU2MjVxMC41MTU2MjUgLTEuMTcxODc1IDEuNDUzMTI1IC0xLjc5Njg3NXEwLjk1MzEyNSAtMC42NDA2MjUgMi4yNSAtMC42NDA2MjVxMS43MDMxMjUgMCAyLjgxMjUgMS4zNzVsMCAtMS4xNTYyNWwxLjUxNTYyNSAwbDAgOC4zNTkzNzVxMCAyLjI2NTYyNSAtMC40Njg3NSAzLjIwMzEyNXEtMC40NTMxMjUgMC45Mzc1IC0xLjQ1MzEyNSAxLjQ4NDM3NXEtMC45ODQzNzUgMC41NDY4NzUgLTIuNDUzMTI1IDAuNTQ2ODc1cS0xLjcxODc1IDAgLTIuNzk2ODc1IC0wLjc4MTI1cS0xLjA2MjUgLTAuNzY1NjI1IC0xLjAzMTI1IC0yLjM0Mzc1em0xLjM1OTM3NSAtNS44MTI1cTAgMS45MDYyNSAwLjc1IDIuNzgxMjVxMC43NjU2MjUgMC44NzUgMS45MDYyNSAwLjg3NXExLjEyNSAwIDEuODkwNjI1IC0wLjg1OTM3NXEwLjc2NTYyNSAtMC44NzUgMC43NjU2MjUgLTIuNzM0Mzc1cTAgLTEuNzgxMjUgLTAuNzk2ODc1IC0yLjY3MTg3NXEtMC43ODEyNSAtMC45MDYyNSAtMS44OTA2MjUgLTAuOTA2MjVxLTEuMDkzNzUgMCAtMS44NTkzNzUgMC44OTA2MjVxLTAuNzY1NjI1IDAuODc1IC0wLjc2NTYyNSAyLjYyNXptMTUuOTUzODQyIDEuOTA2MjVsMS42ODc1IDAuMjAzMTI1cS0wLjQwNjI1IDEuNDg0Mzc1IC0xLjQ4NDM3NSAyLjMxMjVxLTEuMDc4MTI1IDAuODEyNSAtMi43NjU2MjUgMC44MTI1cS0yLjEyNSAwIC0zLjM3NSAtMS4yOTY4NzVxLTEuMjM0Mzc1IC0xLjMxMjUgLTEuMjM0Mzc1IC0zLjY3MTg3NXEwIC0yLjQ1MzEyNSAxLjI1IC0zLjc5Njg3NXExLjI2NTYyNSAtMS4zNDM3NSAzLjI2NTYyNSAtMS4zNDM3NXExLjkzNzUgMCAzLjE1NjI1IDEuMzI4MTI1cTEuMjM0Mzc1IDEuMzEyNSAxLjIzNDM3NSAzLjcwMzEyNXEwIDAuMTU2MjUgMCAwLjQzNzVsLTcuMjE4NzUgMHEwLjA5Mzc1IDEuNTkzNzUgMC45MDYyNSAyLjQ1MzEyNXEwLjgxMjUgMC44NDM3NSAyLjAxNTYyNSAwLjg0Mzc1cTAuOTA2MjUgMCAxLjU0Njg3NSAtMC40Njg3NXEwLjY0MDYyNSAtMC40ODQzNzUgMS4wMTU2MjUgLTEuNTE1NjI1em0tNS4zOTA2MjUgLTIuNjU2MjVsNS40MDYyNSAwcS0wLjEwOTM3NSAtMS4yMTg3NSAtMC42MjUgLTEuODI4MTI1cS0wLjc4MTI1IC0wLjk1MzEyNSAtMi4wMzEyNSAtMC45NTMxMjVxLTEuMTI1IDAgLTEuOTA2MjUgMC43NjU2MjVxLTAuNzY1NjI1IDAuNzUgLTAuODQzNzUgMi4wMTU2MjV6bTguNDg1MDkyIDIuODc1bDEuNjI1IC0wLjI1cTAuMTI1IDAuOTY4NzUgMC43NSAxLjVxMC42MjUgMC41MTU2MjUgMS43NSAwLjUxNTYyNXExLjEyNSAwIDEuNjcxODc1IC0wLjQ1MzEyNXEwLjU0Njg3NSAtMC40Njg3NSAwLjU0Njg3NSAtMS4wOTM3NXEwIC0wLjU0Njg3NSAtMC40ODQzNzUgLTAuODc1cS0wLjMyODEyNSAtMC4yMTg3NSAtMS42NzE4NzUgLTAuNTQ2ODc1cS0xLjgxMjUgLTAuNDY4NzUgLTIuNTE1NjI1IC0wLjc5Njg3NXEtMC42ODc1IC0wLjMyODEyNSAtMS4wNDY4NzUgLTAuOTA2MjVxLTAuMzU5Mzc1IC0wLjU5Mzc1IC0wLjM1OTM3NSAtMS4zMTI1cTAgLTAuNjQwNjI1IDAuMjk2ODc1IC0xLjE4NzVxMC4yOTY4NzUgLTAuNTYyNSAwLjgxMjUgLTAuOTIxODc1cTAuMzc1IC0wLjI4MTI1IDEuMDMxMjUgLTAuNDY4NzVxMC42NzE4NzUgLTAuMjAzMTI1IDEuNDIxODc1IC0wLjIwMzEyNXExLjE0MDYyNSAwIDIuMCAwLjMyODEyNXEwLjg1OTM3NSAwLjMyODEyNSAxLjI2NTYyNSAwLjg5MDYyNXEwLjQyMTg3NSAwLjU2MjUgMC41NzgxMjUgMS41bC0xLjYwOTM3NSAwLjIxODc1cS0wLjEwOTM3NSAtMC43NSAtMC42NDA2MjUgLTEuMTcxODc1cS0wLjUxNTYyNSAtMC40MjE4NzUgLTEuNDY4NzUgLTAuNDIxODc1cS0xLjE0MDYyNSAwIC0xLjYyNSAwLjM3NXEtMC40Njg3NSAwLjM3NSAtMC40Njg3NSAwLjg3NXEwIDAuMzEyNSAwLjE4NzUgMC41NzgxMjVxMC4yMDMxMjUgMC4yNjU2MjUgMC42NDA2MjUgMC40Mzc1cTAuMjM0Mzc1IDAuMDkzNzUgMS40Mzc1IDAuNDIxODc1cTEuNzUgMC40NTMxMjUgMi40Mzc1IDAuNzVxMC42ODc1IDAuMjk2ODc1IDEuMDc4MTI1IDAuODU5Mzc1cTAuMzkwNjI1IDAuNTYyNSAwLjM5MDYyNSAxLjQwNjI1cTAgMC44MjgxMjUgLTAuNDg0Mzc1IDEuNTQ2ODc1cS0wLjQ2ODc1IDAuNzE4NzUgLTEuMzc1IDEuMTI1cS0wLjkwNjI1IDAuMzkwNjI1IC0yLjA0Njg3NSAwLjM5MDYyNXEtMS44NzUgMCAtMi44NzUgLTAuNzgxMjVxLTAuOTg0Mzc1IC0wLjc4MTI1IC0xLjI1IC0yLjMyODEyNXptMTMuMTA5Mzc1IDYuODEyNXEtMS4zNTkzNzUgLTEuNzAzMTI1IC0yLjI5Njg3NSAtNC4wcS0wLjkzNzUgLTIuMjk2ODc1IC0wLjkzNzUgLTQuNzY1NjI1cTAgLTIuMTU2MjUgMC43MDMxMjUgLTQuMTQwNjI1cTAuODI4MTI1IC0yLjMxMjUgMi41MzEyNSAtNC41OTM3NWwxLjE3MTg3NSAwcS0xLjA5Mzc1IDEuODkwNjI1IC0xLjQ1MzEyNSAyLjcwMzEyNXEtMC41NDY4NzUgMS4yNSAtMC44NzUgMi42MjVxLTAuMzkwNjI1IDEuNzAzMTI1IC0wLjM5MDYyNSAzLjQyMTg3NXEwIDQuMzc1IDIuNzE4NzUgOC43NWwtMS4xNzE4NzUgMHptMi40MzE0MjcgLTYuODEyNWwxLjYyNSAtMC4yNXEwLjEyNSAwLjk2ODc1IDAuNzUgMS41cTAuNjI1IDAuNTE1NjI1IDEuNzUgMC41MTU2MjVxMS4xMjUgMCAxLjY3MTg3NSAtMC40NTMxMjVxMC41NDY4NzUgLTAuNDY4NzUgMC41NDY4NzUgLTEuMDkzNzVxMCAtMC41NDY4NzUgLTAuNDg0Mzc1IC0wLjg3NXEtMC4zMjgxMjUgLTAuMjE4NzUgLTEuNjcxODc1IC0wLjU0Njg3NXEtMS44MTI1IC0wLjQ2ODc1IC0yLjUxNTYyNSAtMC43OTY4NzVxLTAuNjg3NSAtMC4zMjgxMjUgLTEuMDQ2ODc1IC0wLjkwNjI1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzUgMC4zMjgxMjUgMS4yNjU2MjUgMC44OTA2MjVxMC40MjE4NzUgMC41NjI1IDAuNTc4MTI1IDEuNWwtMS42MDkzNzUgMC4yMTg3NXEtMC4xMDkzNzUgLTAuNzUgLTAuNjQwNjI1IC0xLjE3MTg3NXEtMC41MTU2MjUgLTAuNDIxODc1IC0xLjQ2ODc1IC0wLjQyMTg3NXEtMS4xNDA2MjUgMCAtMS42MjUgMC4zNzVxLTAuNDY4NzUgMC4zNzUgLTAuNDY4NzUgMC44NzVxMCAwLjMxMjUgMC4xODc1IDAuNTc4MTI1cTAuMjAzMTI1IDAuMjY1NjI1IDAuNjQwNjI1IDAuNDM3NXEwLjIzNDM3NSAwLjA5Mzc1IDEuNDM3NSAwLjQyMTg3NXExLjc1IDAuNDUzMTI1IDIuNDM3NSAwLjc1cTAuNjg3NSAwLjI5Njg3NSAxLjA3ODEyNSAwLjg1OTM3NXEwLjM5MDYyNSAwLjU2MjUgMC4zOTA2MjUgMS40MDYyNXEwIDAuODI4MTI1IC0wLjQ4NDM3NSAxLjU0Njg3NXEtMC40Njg3NSAwLjcxODc1IC0xLjM3NSAxLjEyNXEtMC45MDYyNSAwLjM5MDYyNSAtMi4wNDY4NzUgMC4zOTA2MjVxLTEuODc1IDAgLTIuODc1IC0wLjc4MTI1cS0wLjk4NDM3NSAtMC43ODEyNSAtMS4yNSAtMi4zMjgxMjV6bTE2LjYwOTM3NSAtMC4yMTg3NWwxLjY4NzUgMC4yMDMxMjVxLTAuNDA2MjUgMS40ODQzNzUgLTEuNDg0Mzc1IDIuMzEyNXEtMS4wNzgxMjUgMC44MTI1IC0yLjc2NTYyNSAwLjgxMjVxLTIuMTI1IDAgLTMuMzc1IC0xLjI5Njg3NXEtMS4yMzQzNzUgLTEuMzEyNSAtMS4yMzQzNzUgLTMuNjcxODc1cTAgLTIuNDUzMTI1IDEuMjUgLTMuNzk2ODc1cTEuMjY1NjI1IC0xLjM0Mzc1IDMuMjY1NjI1IC0xLjM0Mzc1cTEuOTM3NSAwIDMuMTU2MjUgMS4zMjgxMjVxMS4yMzQzNzUgMS4zMTI1IDEuMjM0Mzc1IDMuNzAzMTI1cTAgMC4xNTYyNSAwIDAuNDM3NWwtNy4yMTg3NSAwcTAuMDkzNzUgMS41OTM3NSAwLjkwNjI1IDIuNDUzMTI1cTAuODEyNSAwLjg0Mzc1IDIuMDE1NjI1IDAuODQzNzVxMC45MDYyNSAwIDEuNTQ2ODc1IC0wLjQ2ODc1cTAuNjQwNjI1IC0wLjQ4NDM3NSAxLjAxNTYyNSAtMS41MTU2MjV6bS01LjM5MDYyNSAtMi42NTYyNWw1LjQwNjI1IDBxLTAuMTA5Mzc1IC0xLjIxODc1IC0wLjYyNSAtMS44MjgxMjVxLTAuNzgxMjUgLTAuOTUzMTI1IC0yLjAzMTI1IC0wLjk1MzEyNXEtMS4xMjUgMCAtMS45MDYyNSAwLjc2NTYyNXEtMC43NjU2MjUgMC43NSAtMC44NDM3NSAyLjAxNTYyNXptMTAuMjE5NDY3IDkuNjg3NWwtMS4xODc1IDBxMi43MzQzNzUgLTQuMzc1IDIuNzM0Mzc1IC04Ljc1cTAgLTEuNzE4NzUgLTAuMzkwNjI1IC0zLjM5MDYyNXEtMC4zMTI1IC0xLjM3NSAtMC44NzUgLTIuNjI1cS0wLjM1OTM3NSAtMC44MjgxMjUgLTEuNDY4NzUgLTIuNzM0Mzc1bDEuMTg3NSAwcTEuNzAzMTI1IDIuMjgxMjUgMi41MzEyNSA0LjU5Mzc1cTAuNjg3NSAxLjk4NDM3NSAwLjY4NzUgNC4xNDA2MjVxMCAyLjQ2ODc1IC0wLjkzNzUgNC43NjU2MjVxLTAuOTM3NSAyLjI5Njg3NSAtMi4yODEyNSA0LjB6IiBmaWxsLXJ1bGU9Im5vbnplcm8iLz48cGF0aCBmaWxsPSIjMDAwMDAwIiBkPSJtMTAuMjE4ODM5IDUxNy4xNDgzbDAgLTkuNjcxODQ0NWwxLjQ2ODc1IDBsMCAxLjQ2ODc1cTAuNTYyNSAtMS4wMzEyNSAxLjAzMTI1IC0xLjM1OTM3NXEwLjQ4NDM3NSAtMC4zMjgxMjUgMS4wNjI1IC0wLjMyODEyNXEwLjgyODEyNSAwIDEuNjg3NSAwLjUzMTI1bC0wLjU2MjUgMS41MTU2MjVxLTAuNjA5Mzc1IC0wLjM1OTM3NSAtMS4yMDMxMjUgLTAuMzU5Mzc1cS0wLjU0Njg3NSAwIC0wLjk2ODc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjMyODEyNSAtMC42MDkzNzUgMC44OTA2MjVxLTAuMjgxMjUgMC44NzUgLTAuMjgxMjUgMS45MjE4NDQ1bDAgNS4wNjI1bC0xLjYyNSAwem01LjYxODkyNyAtNC44NDM3NXEwIC0yLjY4NzQ2OTUgMS40ODQzNzYgLTMuOTY4NzE5NXExLjI1IC0xLjA3ODEyNSAzLjA0Njg3NSAtMS4wNzgxMjVxMi4wIDAgMy4yNjU2MjUgMS4zMTI1cTEuMjY1NjI1IDEuMjk2ODc1IDEuMjY1NjI1IDMuNjA5MzQ0NXEwIDEuODU5Mzc1IC0wLjU2MjUgMi45Mzc1cS0wLjU2MjUgMS4wNjI1IC0xLjY0MDYyNSAxLjY1NjI1cS0xLjA2MjUgMC41OTM3NSAtMi4zMjgxMjUgMC41OTM3NXEtMi4wMzEyNSAwIC0zLjI4MTI1IC0xLjI5Njg3NXEtMS4yNTAwMDEgLTEuMzEyNSAtMS4yNTAwMDEgLTMuNzY1NjI1em0xLjY4NzUwMSAwcTAgMS44NTkzNzUgMC43OTY4NzUgMi43OTY4NzVxMC44MTI1IDAuOTIxODc1IDIuMDQ2ODc1IDAuOTIxODc1cTEuMjE4NzUgMCAyLjAzMTI1IC0wLjkyMTg3NXEwLjgxMjUgLTAuOTM3NSAwLjgxMjUgLTIuODQzNzVxMCAtMS43OTY4NDQ1IC0wLjgxMjUgLTIuNzE4NzE5NXEtMC44MTI1IC0wLjkyMTg3NSAtMi4wMzEyNSAtMC45MjE4NzVxLTEuMjM0Mzc1IDAgLTIuMDQ2ODc1IDAuOTIxODc1cS0wLjc5Njg3NSAwLjkwNjI1IC0wLjc5Njg3NSAyLjc2NTU5NDV6bTExLjA3ODg0MiA0Ljg0Mzc1bC0yLjk2ODc1IC05LjY3MTg0NDVsMS43MDMxMjUgMGwxLjUzMTI1IDUuNTc4MDk0NWwwLjU3ODEyNSAyLjA3ODEyNXEwLjA0Njg3NSAtMC4xNTYyNSAwLjUgLTIuMGwxLjU0Njg3NSAtNS42NTYyMTk1bDEuNjg3NDk4MSAwbDEuNDM3NSA1LjYwOTM0NDVsMC40ODQzNzUgMS44NDM3NWwwLjU2MjUgLTEuODU5Mzc1bDEuNjU2MjUgLTUuNTkzNzE5NWwxLjU5Mzc1IDBsLTMuMDMxMjUgOS42NzE4NDQ1bC0xLjcwMzEyNSAwbC0xLjUzMTI1IC01Ljc5Njg0NDVsLTAuMzc1IC0xLjY0MDYyNWwtMS45NTMxMjMxIDcuNDM3NDY5NWwtMS43MTg3NSAwem0xMS44OTQ4MTkgMGwwIC0xMy4zNTkzNDQ1bDQuNjA5Mzc1IDBxMS41NDY4NzUgMCAyLjM3NSAwLjIwMzEyNXExLjE0MDYyNSAwLjI1IDEuOTUzMTI1IDAuOTUzMTI1cTEuMDYyNSAwLjg5MDYyNSAxLjU3ODEyNSAyLjI4MTI1cTAuNTMxMjUgMS4zOTA2MjUgMC41MzEyNSAzLjE3MTg3NXEwIDEuNTE1NjI1IC0wLjM1OTM3NSAyLjcwMzA5NDVxLTAuMzU5Mzc1IDEuMTcxODc1IC0wLjkyMTg3NSAxLjkzNzVxLTAuNTQ2ODc1IDAuNzY1NjI1IC0xLjIwMzEyNSAxLjIxODc1cS0wLjY1NjI1IDAuNDM3NSAtMS41OTM3NSAwLjY3MTg3NXEtMC45Mzc1IDAuMjE4NzUgLTIuMTQwNjI1IDAuMjE4NzVsLTQuODI4MTI1IDB6bTEuNzY1NjI1IC0xLjU3ODEyNWwyLjg1OTM3NSAwcTEuMzEyNSAwIDIuMDYyNSAtMC4yMzQzNzVxMC43NSAtMC4yNSAxLjIwMzEyNSAtMC43MDMxMjVxMC42MjUgLTAuNjI1IDAuOTY4NzUgLTEuNjg3NXEwLjM1OTM3NSAtMS4wNjI0Njk1IDAuMzU5Mzc1IC0yLjU3ODA5NDVxMCAtMi4wOTM3NSAtMC42ODc1IC0zLjIxODc1cS0wLjY4NzUgLTEuMTI1IC0xLjY3MTg3NSAtMS41cS0wLjcwMzEyNSAtMC4yODEyNSAtMi4yODEyNSAtMC4yODEyNWwtMi44MTI1IDBsMCAxMC4yMDMwOTQ1em0xNy44MTY2OTYgMC4zOTA2MjVxLTAuOTIxODc1IDAuNzY1NjI1IC0xLjc2NTYyNSAxLjA5Mzc1cS0wLjgyODEyNSAwLjMxMjUgLTEuNzk2ODc1IDAuMzEyNXEtMS41OTM3NSAwIC0yLjQ1MzEyNSAtMC43ODEyNXEtMC44NTkzNzUgLTAuNzgxMjUgLTAuODU5Mzc1IC0xLjk4NDM3NXEwIC0wLjcxODc1IDAuMzI4MTI1IC0xLjI5Njg3NXEwLjMyODEyNSAtMC41OTM3NSAwLjg0Mzc1IC0wLjkzNzVxMC41MzEyNSAtMC4zNTkzNzUgMS4xODc1IC0wLjU0Njg0NDVxMC40Njg3NSAtMC4xMjUgMS40NTMxMjUgLTAuMjVxMS45ODQzNzUgLTAuMjM0Mzc1IDIuOTIxODc1IC0wLjU2MjVxMC4wMTU2MjUgLTAuMzQzNzUgMC4wMTU2MjUgLTAuNDIxODc1cTAgLTEuMCAtMC40Njg3NSAtMS40MjE4NzVxLTAuNjI1IC0wLjU0Njg3NSAtMS44NzUgLTAuNTQ2ODc1cS0xLjE1NjI1IDAgLTEuNzAzMTI1IDAuNDA2MjVxLTAuNTQ2ODc1IDAuNDA2MjUgLTAuODEyNSAxLjQyMTg3NWwtMS42MDkzNzUgLTAuMjE4NzVxMC4yMTg3NSAtMS4wMTU2MjUgMC43MTg3NSAtMS42NDA2MjVxMC41IC0wLjY0MDYyNSAxLjQ1MzEyNSAtMC45ODQzNzVxMC45NTMxMjUgLTAuMzQzNzUgMi4xODc1IC0wLjM0Mzc1cTEuMjUgMCAyLjAxNTYyNSAwLjI5Njg3NXEwLjc4MTI1IDAuMjgxMjUgMS4xNDA2MjUgMC43MzQzNzVxMC4zNzUgMC40Mzc1IDAuNTE1NjI1IDEuMTA5Mzc1cTAuMDc4MTI1IDAuNDIxODc1IDAuMDc4MTI1IDEuNTE1NjI1bDAgMi4xODc0Njk1cTAgMi4yODEyNSAwLjEwOTM3NSAyLjg5MDYyNXEwLjEwOTM3NSAwLjU5Mzc1IDAuNDA2MjUgMS4xNTYyNWwtMS43MDMxMjUgMHEtMC4yNjU2MjUgLTAuNTE1NjI1IC0wLjMyODEyNSAtMS4xODc1em0tMC4xNDA2MjUgLTMuNjcxODc1cS0wLjg5MDYyNSAwLjM3NSAtMi42NzE4NzUgMC42MjVxLTEuMDE1NjI1IDAuMTQwNjI1IC0xLjQzNzUgMC4zMjgxMjVxLTAuNDIxODc1IDAuMTg3NSAtMC42NTYyNSAwLjUzMTI1cS0wLjIxODc1IDAuMzQzNzUgLTAuMjE4NzUgMC43ODEyNXEwIDAuNjU2MjUgMC41IDEuMDkzNzVxMC41IDAuNDM3NSAxLjQ1MzEyNSAwLjQzNzVxMC45Mzc1IDAgMS42NzE4NzUgLTAuNDA2MjVxMC43NSAtMC40MjE4NzUgMS4wOTM3NSAtMS4xNDA2MjVxMC4yNjU2MjUgLTAuNTYyNSAwLjI2NTYyNSAtMS42NDA2MjVsMCAtMC42MDkzNzV6bTcuNzgxOTcxIDMuMzkwNjI1bDAuMjM0Mzc1IDEuNDUzMTI1cS0wLjY4NzUgMC4xNDA2MjUgLTEuMjM0Mzc1IDAuMTQwNjI1cS0wLjg5MDYyNSAwIC0xLjM5MDYyNSAtMC4yODEyNXEtMC40ODQzNzUgLTAuMjgxMjUgLTAuNjg3NSAtMC43MzQzNzVxLTAuMjAzMTI1IC0wLjQ2ODc1IC0wLjIwMzEyNSAtMS45Mzc1bDAgLTUuNTc4MDk0NWwtMS4yMDMxMjg4IDBsMCAtMS4yNjU2MjVsMS4yMDMxMjg4IDBsMCAtMi4zOTA2MjVsMS42MjUgLTAuOTg0Mzc1bDAgMy4zNzVsMS42NTYyNSAwbDAgMS4yNjU2MjVsLTEuNjU2MjUgMGwwIDUuNjcxODQ0NXEwIDAuNjg3NSAwLjA3ODEyNSAwLjg5MDYyNXEwLjA5Mzc1IDAuMjAzMTI1IDAuMjgxMjUgMC4zMjgxMjVxMC4yMDMxMjUgMC4xMDkzNzUgMC41NzgxMjUgMC4xMDkzNzVxMC4yNjU2MjUgMCAwLjcxODc1IC0wLjA2MjV6bTcuOTE3Njc5IDAuMjgxMjVxLTAuOTIxODc1IDAuNzY1NjI1IC0xLjc2NTYyNSAxLjA5Mzc1cS0wLjgyODEyNSAwLjMxMjUgLTEuNzk2ODc1IDAuMzEyNXEtMS41OTM3NSAwIC0yLjQ1MzEyNSAtMC43ODEyNXEtMC44NTkzNzUgLTAuNzgxMjUgLTAuODU5Mzc1IC0xLjk4NDM3NXEwIC0wLjcxODc1IDAuMzI4MTI1IC0xLjI5Njg3NXEwLjMyODEyNSAtMC41OTM3NSAwLjg0Mzc1IC0wLjkzNzVxMC41MzEyNSAtMC4zNTkzNzUgMS4xODc1IC0wLjU0Njg0NDVxMC40Njg3NSAtMC4xMjUgMS40NTMxMjUgLTAuMjVxMS45ODQzNzUgLTAuMjM0Mzc1IDIuOTIxODc1IC0wLjU2MjVxMC4wMTU2MjUgLTAuMzQzNzUgMC4wMTU2MjUgLTAuNDIxODc1cTAgLTEuMCAtMC40Njg3NSAtMS40MjE4NzVxLTAuNjI1IC0wLjU0Njg3NSAtMS44NzUgLTAuNTQ2ODc1cS0xLjE1NjI1IDAgLTEuNzAzMTI1IDAuNDA2MjVxLTAuNTQ2ODc1IDAuNDA2MjUgLTAuODEyNSAxLjQyMTg3NWwtMS42MDkzNzUgLTAuMjE4NzVxMC4yMTg3NSAtMS4wMTU2MjUgMC43MTg3NSAtMS42NDA2MjVxMC41IC0wLjY0MDYyNSAxLjQ1MzEyNSAtMC45ODQzNzVxMC45NTMxMjUgLTAuMzQzNzUgMi4xODc1IC0wLjM0Mzc1cTEuMjUgMCAyLjAxNTYyNSAwLjI5Njg3NXEwLjc4MTI1IDAuMjgxMjUgMS4xNDA2MjUgMC43MzQzNzVxMC4zNzUgMC40Mzc1IDAuNTE1NjI1IDEuMTA5Mzc1cTAuMDc4MTI1IDAuNDIxODc1IDAuMDc4MTI1IDEuNTE1NjI1bDAgMi4xODc0Njk1cTAgMi4yODEyNSAwLjEwOTM3NSAyLjg5MDYyNXEwLjEwOTM3NSAwLjU5Mzc1IDAuNDA2MjUgMS4xNTYyNWwtMS43MDMxMjUgMHEtMC4yNjU2MjUgLTAuNTE1NjI1IC0wLjMyODEyNSAtMS4xODc1em0tMC4xNDA2MjUgLTMuNjcxODc1cS0wLjg5MDYyNSAwLjM3NSAtMi42NzE4NzUgMC42MjVxLTEuMDE1NjI1IDAuMTQwNjI1IC0xLjQzNzUgMC4zMjgxMjVxLTAuNDIxODc1IDAuMTg3NSAtMC42NTYyNSAwLjUzMTI1cS0wLjIxODc1IDAuMzQzNzUgLTAuMjE4NzUgMC43ODEyNXEwIDAuNjU2MjUgMC41IDEuMDkzNzVxMC41IDAuNDM3NSAxLjQ1MzEyNSAwLjQzNzVxMC45Mzc1IDAgMS42NzE4NzUgLTAuNDA2MjVxMC43NSAtMC40MjE4NzUgMS4wOTM3NSAtMS4xNDA2MjVxMC4yNjU2MjUgLTAuNTYyNSAwLjI2NTYyNSAtMS42NDA2MjVsMCAtMC42MDkzNzV6bTcuMzI4ODQyIDguNzgxMjVxLTEuMzU5Mzc1IC0xLjcwMzEyNSAtMi4yOTY4NzUgLTQuMHEtMC45Mzc1IC0yLjI5Njg3NSAtMC45Mzc1IC00Ljc2NTYyNXEwIC0yLjE1NjIxOTUgMC43MDMxMjUgLTQuMTQwNTk0NXEwLjgyODEyNSAtMi4zMTI1IDIuNTMxMjUgLTQuNTkzNzVsMS4xNzE4NzUgMHEtMS4wOTM3NSAxLjg5MDYyNSAtMS40NTMxMjUgMi43MDMxMjVxLTAuNTQ2ODc1IDEuMjUgLTAuODc1IDIuNjI1cS0wLjM5MDYyNSAxLjcwMzEyNSAtMC4zOTA2MjUgMy40MjE4NDQ1cTAgNC4zNzUgMi43MTg3NSA4Ljc1bC0xLjE3MTg3NSAwem0yLjQzMTQyNyAtNi44MTI1bDEuNjI1IC0wLjI1cTAuMTI1IDAuOTY4NzUgMC43NSAxLjVxMC42MjUgMC41MTU2MjUgMS43NSAwLjUxNTYyNXExLjEyNSAwIDEuNjcxODc1IC0wLjQ1MzEyNXEwLjU0Njg3NSAtMC40Njg3NSAwLjU0Njg3NSAtMS4wOTM3NXEwIC0wLjU0Njg3NSAtMC40ODQzNzUgLTAuODc1cS0wLjMyODEyNSAtMC4yMTg3NSAtMS42NzE4NzUgLTAuNTQ2ODc1cS0xLjgxMjUgLTAuNDY4NzUgLTIuNTE1NjI1IC0wLjc5Njg3NXEtMC42ODc1IC0wLjMyODA5NDQ4IC0xLjA0Njg3NSAtMC45MDYyMTk1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzUgMC4zMjgxMjUgMS4yNjU2MjUgMC44OTA2MjVxMC40MjE4NzUgMC41NjI1IDAuNTc4MTI1IDEuNWwtMS42MDkzNzUgMC4yMTg3NXEtMC4xMDkzNzUgLTAuNzUgLTAuNjQwNjI1IC0xLjE3MTg3NXEtMC41MTU2MjUgLTAuNDIxODc1IC0xLjQ2ODc1IC0wLjQyMTg3NXEtMS4xNDA2MjUgMCAtMS42MjUgMC4zNzVxLTAuNDY4NzUgMC4zNzUgLTAuNDY4NzUgMC44NzVxMCAwLjMxMjUgMC4xODc1IDAuNTc4MTI1cTAuMjAzMTI1IDAuMjY1NjI1IDAuNjQwNjI1IDAuNDM3NXEwLjIzNDM3NSAwLjA5Mzc1IDEuNDM3NSAwLjQyMTg3NXExLjc1IDAuNDUzMTI1IDIuNDM3NSAwLjc0OTk2OTVxMC42ODc1IDAuMjk2ODc1IDEuMDc4MTI1IDAuODU5Mzc1cTAuMzkwNjI1IDAuNTYyNSAwLjM5MDYyNSAxLjQwNjI1cTAgMC44MjgxMjUgLTAuNDg0Mzc1IDEuNTQ2ODc1cS0wLjQ2ODc1IDAuNzE4NzUgLTEuMzc1IDEuMTI1cS0wLjkwNjI1IDAuMzkwNjI1IC0yLjA0Njg3NSAwLjM5MDYyNXEtMS44NzUgMCAtMi44NzUgLTAuNzgxMjVxLTAuOTg0Mzc1IC0wLjc4MTI1IC0xLjI1IC0yLjMyODEyNXptMTYuNjA5Mzc1IC0wLjIxODc1bDEuNjg3NSAwLjIwMzEyNXEtMC40MDYyNSAxLjQ4NDM3NSAtMS40ODQzNzUgMi4zMTI1cS0xLjA3ODEyNSAwLjgxMjUgLTIuNzY1NjI1IDAuODEyNXEtMi4xMjUgMCAtMy4zNzUgLTEuMjk2ODc1cS0xLjIzNDM3NSAtMS4zMTI1IC0xLjIzNDM3NSAtMy42NzE4NzVxMCAtMi40NTMwOTQ1IDEuMjUgLTMuNzk2ODQ0NXExLjI2NTYyNSAtMS4zNDM3NSAzLjI2NTYyNSAtMS4zNDM3NXExLjkzNzUgMCAzLjE1NjI1IDEuMzI4MTI1cTEuMjM0Mzc1IDEuMzEyNSAxLjIzNDM3NSAzLjcwMzA5NDVxMCAwLjE1NjI1IDAgMC40Mzc1bC03LjIxODc1IDBxMC4wOTM3NSAxLjU5Mzc1IDAuOTA2MjUgMi40NTMxMjVxMC44MTI1IDAuODQzNzUgMi4wMTU2MjUgMC44NDM3NXEwLjkwNjI1IDAgMS41NDY4NzUgLTAuNDY4NzVxMC42NDA2MjUgLTAuNDg0Mzc1IDEuMDE1NjI1IC0xLjUxNTYyNXptLTUuMzkwNjI1IC0yLjY1NjIxOTVsNS40MDYyNSAwcS0wLjEwOTM3NSAtMS4yMTg3NSAtMC42MjUgLTEuODI4MTI1cS0wLjc4MTI1IC0wLjk1MzEyNSAtMi4wMzEyNSAtMC45NTMxMjVxLTEuMTI1IDAgLTEuOTA2MjUgMC43NjU2MjVxLTAuNzY1NjI1IDAuNzUgLTAuODQzNzUgMi4wMTU2MjV6bTEwLjIxOTQ2NyA5LjY4NzQ2OTVsLTEuMTg3NSAwcTIuNzM0Mzc1IC00LjM3NSAyLjczNDM3NSAtOC43NXEwIC0xLjcxODcxOTUgLTAuMzkwNjI1IC0zLjM5MDU5NDVxLTAuMzEyNSAtMS4zNzUgLTAuODc1IC0yLjYyNXEtMC4zNTkzNzUgLTAuODI4MTI1IC0xLjQ2ODc1IC0yLjczNDM3NWwxLjE4NzUgMHExLjcwMzEyNSAyLjI4MTI1IDIuNTMxMjUgNC41OTM3NXEwLjY4NzUgMS45ODQzNzUgMC42ODc1IDQuMTQwNTk0NXEwIDIuNDY4NzUgLTAuOTM3NSA0Ljc2NTYyNXEtMC45Mzc1IDIuMjk2ODc1IC0yLjI4MTI1IDQuMHoiIGZpbGwtcnVsZT0ibm9uemVybyIvPjxwYXRoIGZpbGw9IiM2NzRlYTciIGQ9Im05LjU3ODIxNCA1MzYuMjU3N2wxLjYyNSAtMC4yNXEwLjEyNSAwLjk2ODc1IDAuNzUgMS41cTAuNjI1IDAuNTE1NjI1IDEuNzUgMC41MTU2MjVxMS4xMjUgMCAxLjY3MTg3NSAtMC40NTMxMjVxMC41NDY4NzUgLTAuNDY4NzUgMC41NDY4NzUgLTEuMDkzNzVxMCAtMC41NDY4NzUgLTAuNDg0Mzc1IC0wLjg3NXEtMC4zMjgxMjUgLTAuMjE4NzUgLTEuNjcxODc1IC0wLjU0Njg3NXEtMS44MTI1IC0wLjQ2ODc1IC0yLjUxNTYyNSAtMC43OTY4NzVxLTAuNjg3NSAtMC4zMjgxMjUgLTEuMDQ2ODc1IC0wLjkwNjI1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzU5NSAwLjMyODEyNSAxLjI2NTYyNiAwLjg5MDYyNXEwLjQyMTg3NSAwLjU2MjUgMC41NzgxMjUgMS41bC0xLjYwOTM3NiAwLjIxODc1cS0wLjEwOTM3NSAtMC43NSAtMC42NDA2MjUgLTEuMTcxODc1cS0wLjUxNTYyNSAtMC40MjE4NzUgLTEuNDY4NzUgLTAuNDIxODc1cS0xLjE0MDYyNSAwIC0xLjYyNSAwLjM3NXEtMC40Njg3NSAwLjM3NSAtMC40Njg3NSAwLjg3NXEwIDAuMzEyNSAwLjE4NzUgMC41NzgxMjVxMC4yMDMxMjUgMC4yNjU2MjUgMC42NDA2MjUgMC40Mzc1cTAuMjM0Mzc1IDAuMDkzNzUgMS40Mzc1IDAuNDIxODc1cTEuNzUgMC40NTMxMjUgMi40Mzc1MDEgMC43NXEwLjY4NzUgMC4yOTY4NzUgMS4wNzgxMjUgMC44NTkzNzVxMC4zOTA2MjUgMC41NjI1IDAuMzkwNjI1IDEuNDA2MjVxMCAwLjgyODEyNSAtMC40ODQzNzUgMS41NDY4NzVxLTAuNDY4NzUgMC43MTg3NSAtMS4zNzUwMDEgMS4xMjVxLTAuOTA2MjUgMC4zOTA2MjUgLTIuMDQ2ODc1IDAuMzkwNjI1cS0xLjg3NSAwIC0yLjg3NSAtMC43ODEyNXEtMC45ODQzNzUgLTAuNzgxMjUgLTEuMjUgLTIuMzI4MTI1em0xNi4zMTI1IDIuODkwNjI1bDAgLTEuNDIxODc1cS0xLjEyNSAxLjY0MDYyNSAtMy4wNjI1IDEuNjQwNjI1cS0wLjg1OTM3NSAwIC0xLjYwOTM3NSAtMC4zMjgxMjVxLTAuNzM0Mzc1IC0wLjMyODEyNSAtMS4wOTM3NSAtMC44MjgxMjVxLTAuMzU5Mzc1IC0wLjUgLTAuNSAtMS4yMTg3NXEtMC4xMDkzNzUgLTAuNDY4NzUgLTAuMTA5Mzc1IC0xLjUzMTI1bDAgLTUuOTg0Mzc1bDEuNjQwNjI1IDBsMCA1LjM1OTM3NXEwIDEuMjgxMjUgMC4xMDkzNzUgMS43MzQzNzVxMC4xNTYyNSAwLjY0MDYyNSAwLjY1NjI1IDEuMDE1NjI1cTAuNSAwLjM3NSAxLjIzNDM3NSAwLjM3NXEwLjczNDM3NSAwIDEuMzc1IC0wLjM3NXEwLjY1NjI1IC0wLjM5MDYyNSAwLjkyMTg3NSAtMS4wMzEyNXEwLjI2NTYyNSAtMC42NTYyNSAwLjI2NTYyNSAtMS44OTA2MjVsMCAtNS4xODc1bDEuNjQwNjI1IDBsMCA5LjY3MTg3NWwtMS40Njg3NSAwem01LjU0NzU5MiAwbC0xLjUxNTYyNSAwbDAgLTEzLjM1OTM3NWwxLjY0MDYyNSAwbDAgNC43NjU2MjVxMS4wNDY4NzMxIC0xLjI5Njg3NSAyLjY1NjI0OCAtMS4yOTY4NzVxMC44OTA2MjUgMCAxLjY4NzUgMC4zNTkzNzVxMC43OTY4NzUgMC4zNTkzNzUgMS4zMTI1IDEuMDE1NjI1cTAuNTE1NjI1IDAuNjQwNjI1IDAuNzk2ODc1IDEuNTYyNXEwLjI5Njg3NSAwLjkyMTg3NSAwLjI5Njg3NSAxLjk2ODc1cTAgMi40ODQzNzUgLTEuMjM0Mzc1IDMuODQzNzVxLTEuMjE4NzUgMS4zNTkzNzUgLTIuOTUzMTI1IDEuMzU5Mzc1cS0xLjcwMzEyNSAwIC0yLjY4NzQ5OCAtMS40Mzc1bDAgMS4yMTg3NXptLTAuMDE1NjI1IC00LjkwNjI1cTAgMS43MzQzNzUgMC40ODQzNzUgMi41MTU2MjVxMC43NjU2MjMxIDEuMjY1NjI1IDIuMDkzNzQ4IDEuMjY1NjI1cTEuMDc4MTI1IDAgMS44NTkzNzUgLTAuOTM3NXEwLjc4MTI1IC0wLjkzNzUgMC43ODEyNSAtMi43ODEyNXEwIC0xLjg5MDYyNSAtMC43NSAtMi43OTY4NzVxLTAuNzUgLTAuOTA2MjUgLTEuODI4MTI1IC0wLjkwNjI1cS0xLjA2MjUgMCAtMS44NTkzNzUgMC45Mzc1cS0wLjc4MTI0ODEgMC45Mzc1IC0wLjc4MTI0ODEgMi43MDMxMjV6bTguMjM1MDkgMi4wMTU2MjVsMS42MjUgLTAuMjVxMC4xMjUgMC45Njg3NSAwLjc1IDEuNXEwLjYyNSAwLjUxNTYyNSAxLjc1IDAuNTE1NjI1cTEuMTI1IDAgMS42NzE4NzUgLTAuNDUzMTI1cTAuNTQ2ODc1IC0wLjQ2ODc1IDAuNTQ2ODc1IC0xLjA5Mzc1cTAgLTAuNTQ2ODc1IC0wLjQ4NDM3NSAtMC44NzVxLTAuMzI4MTI1IC0wLjIxODc1IC0xLjY3MTg3NSAtMC41NDY4NzVxLTEuODEyNSAtMC40Njg3NSAtMi41MTU2MjUgLTAuNzk2ODc1cS0wLjY4NzUgLTAuMzI4MTI1IC0xLjA0Njg3NSAtMC45MDYyNXEtMC4zNTkzNzUgLTAuNTkzNzUgLTAuMzU5Mzc1IC0xLjMxMjVxMCAtMC42NDA2MjUgMC4yOTY4NzUgLTEuMTg3NXEwLjI5Njg3NSAtMC41NjI1IDAuODEyNSAtMC45MjE4NzVxMC4zNzUgLTAuMjgxMjUgMS4wMzEyNSAtMC40Njg3NXEwLjY3MTg3NSAtMC4yMDMxMjUgMS40MjE4NzUgLTAuMjAzMTI1cTEuMTQwNjI1IDAgMi4wIDAuMzI4MTI1cTAuODU5Mzc1IDAuMzI4MTI1IDEuMjY1NjI1IDAuODkwNjI1cTAuNDIxODc1IDAuNTYyNSAwLjU3ODEyNSAxLjVsLTEuNjA5Mzc1IDAuMjE4NzVxLTAuMTA5Mzc1IC0wLjc1IC0wLjY0MDYyNSAtMS4xNzE4NzVxLTAuNTE1NjI1IC0wLjQyMTg3NSAtMS40Njg3NSAtMC40MjE4NzVxLTEuMTQwNjI1IDAgLTEuNjI1IDAuMzc1cS0wLjQ2ODc1IDAuMzc1IC0wLjQ2ODc1IDAuODc1cTAgMC4zMTI1IDAuMTg3NSAwLjU3ODEyNXEwLjIwMzEyNSAwLjI2NTYyNSAwLjY0MDYyNSAwLjQzNzVxMC4yMzQzNzUgMC4wOTM3NSAxLjQzNzUgMC40MjE4NzVxMS43NSAwLjQ1MzEyNSAyLjQzNzUgMC43NXEwLjY4NzUgMC4yOTY4NzUgMS4wNzgxMjUgMC44NTkzNzVxMC4zOTA2MjUgMC41NjI1IDAuMzkwNjI1IDEuNDA2MjVxMCAwLjgyODEyNSAtMC40ODQzNzUgMS41NDY4NzVxLTAuNDY4NzUgMC43MTg3NSAtMS4zNzUgMS4xMjVxLTAuOTA2MjUgMC4zOTA2MjUgLTIuMDQ2ODc1IDAuMzkwNjI1cS0xLjg3NSAwIC0yLjg3NSAtMC43ODEyNXEtMC45ODQzNzUgLTAuNzgxMjUgLTEuMjUgLTIuMzI4MTI1em0xNi42MDkzNzUgLTAuMjE4NzVsMS42ODc1IDAuMjAzMTI1cS0wLjQwNjI1IDEuNDg0Mzc1IC0xLjQ4NDM3NSAyLjMxMjVxLTEuMDc4MTI1IDAuODEyNSAtMi43NjU2MjUgMC44MTI1cS0yLjEyNSAwIC0zLjM3NSAtMS4yOTY4NzVxLTEuMjM0Mzc1IC0xLjMxMjUgLTEuMjM0Mzc1IC0zLjY3MTg3NXEwIC0yLjQ1MzEyNSAxLjI1IC0zLjc5Njg3NXExLjI2NTYyNSAtMS4zNDM3NSAzLjI2NTYyNSAtMS4zNDM3NXExLjkzNzUgMCAzLjE1NjI1IDEuMzI4MTI1cTEuMjM0Mzc1IDEuMzEyNSAxLjIzNDM3NSAzLjcwMzEyNXEwIDAuMTU2MjUgMCAwLjQzNzVsLTcuMjE4NzUgMHEwLjA5Mzc1IDEuNTkzNzUgMC45MDYyNSAyLjQ1MzEyNXEwLjgxMjUgMC44NDM3NSAyLjAxNTYyNSAwLjg0Mzc1cTAuOTA2MjUgMCAxLjU0Njg3NSAtMC40Njg3NXEwLjY0MDYyNSAtMC40ODQzNzUgMS4wMTU2MjUgLTEuNTE1NjI1em0tNS4zOTA2MjUgLTIuNjU2MjVsNS40MDYyNSAwcS0wLjEwOTM3NSAtMS4yMTg3NSAtMC42MjUgLTEuODI4MTI1cS0wLjc4MTI1IC0wLjk1MzEyNSAtMi4wMzEyNSAtMC45NTMxMjVxLTEuMTI1IDAgLTEuOTA2MjUgMC43NjU2MjVxLTAuNzY1NjI1IDAuNzUgLTAuODQzNzUgMi4wMTU2MjV6bTEyLjcxOTQ2NyA0LjI5Njg3NWwwLjIzNDM3NSAxLjQ1MzEyNXEtMC42ODc1IDAuMTQwNjI1IC0xLjIzNDM3NSAwLjE0MDYyNXEtMC44OTA2MjUgMCAtMS4zOTA2MjUgLTAuMjgxMjVxLTAuNDg0Mzc1IC0wLjI4MTI1IC0wLjY4NzUgLTAuNzM0Mzc1cS0wLjIwMzEyNSAtMC40Njg3NSAtMC4yMDMxMjUgLTEuOTM3NWwwIC01LjU3ODEyNWwtMS4yMDMxMjUgMGwwIC0xLjI2NTYyNWwxLjIwMzEyNSAwbDAgLTIuMzkwNjI1bDEuNjI1IC0wLjk4NDM3NWwwIDMuMzc1bDEuNjU2MjUgMGwwIDEuMjY1NjI1bC0xLjY1NjI1IDBsMCA1LjY3MTg3NXEwIDAuNjg3NSAwLjA3ODEyNSAwLjg5MDYyNXEwLjA5Mzc1IDAuMjAzMTI1IDAuMjgxMjUgMC4zMjgxMjVxMC4yMDMxMjUgMC4xMDkzNzUgMC41NzgxMjUgMC4xMDkzNzVxMC4yNjU2MjUgMCAwLjcxODc1IC0wLjA2MjV6bTEuNzMwMTgyNiAxLjQ2ODc1bDAgLTEzLjM1OTM3NWw1LjAxNTYyNSAwcTEuNTMxMjUgMCAyLjQ1MzEyNSAwLjQwNjI1cTAuOTIxODc1IDAuNDA2MjUgMS40Mzc1IDEuMjVxMC41MzEyNSAwLjg0Mzc1IDAuNTMxMjUgMS43NjU2MjVxMCAwLjg1OTM3NSAtMC40Njg3NSAxLjYyNXEtMC40NTMxMjUgMC43NSAtMS4zOTA2MjUgMS4yMDMxMjVxMS4yMDMxMjUgMC4zNTkzNzUgMS44NTkzNzUgMS4yMTg3NXEwLjY1NjI1IDAuODU5Mzc1IDAuNjU2MjUgMi4wMTU2MjVxMCAwLjkzNzUgLTAuNDA2MjUgMS43NXEtMC4zOTA2MjUgMC43OTY4NzUgLTAuOTg0Mzc1IDEuMjM0Mzc1cS0wLjU3ODEyNSAwLjQzNzUgLTEuNDUzMTI1IDAuNjcxODc1cS0wLjg3NSAwLjIxODc1IC0yLjE1NjI1IDAuMjE4NzVsLTUuMDkzNzUgMHptMS43ODEyNSAtNy43NWwyLjg3NSAwcTEuMTg3NSAwIDEuNjg3NSAtMC4xNDA2MjVxMC42NzE4NzUgLTAuMjAzMTI1IDEuMDE1NjI1IC0wLjY3MTg3NXEwLjM0Mzc1IC0wLjQ2ODc1IDAuMzQzNzUgLTEuMTcxODc1cTAgLTAuNjU2MjUgLTAuMzI4MTI1IC0xLjE1NjI1cS0wLjMxMjUgLTAuNTE1NjI1IC0wLjkwNjI1IC0wLjcwMzEyNXEtMC41OTM3NSAtMC4xODc1IC0yLjAzMTI1IC0wLjE4NzVsLTIuNjU2MjUgMGwwIDQuMDMxMjV6bTAgNi4xNzE4NzVsMy4zMTI1IDBxMC44NTkzNzUgMCAxLjIwMzEyNSAtMC4wNjI1cTAuNjA5Mzc1IC0wLjEwOTM3NSAxLjAxNTYyNSAtMC4zNTkzNzVxMC40MjE4NzUgLTAuMjY1NjI1IDAuNjg3NSAtMC43NXEwLjI2NTYyNSAtMC40ODQzNzUgMC4yNjU2MjUgLTEuMTI1cTAgLTAuNzUgLTAuMzkwNjI1IC0xLjI5Njg3NXEtMC4zNzUgLTAuNTQ2ODc1IC0xLjA2MjUgLTAuNzY1NjI1cS0wLjY3MTg3NSAtMC4yMzQzNzUgLTEuOTUzMTI1IC0wLjIzNDM3NWwtMy4wNzgxMjUgMGwwIDQuNTkzNzV6bTEwLjQ1OTE5OCA1LjI5Njg3NWwtMC4xODc1IC0xLjUzMTI1cTAuNTQ2ODc1IDAuMTQwNjI1IDAuOTM3NSAwLjE0MDYyNXEwLjU0Njg3NSAwIDAuODc1IC0wLjE4NzVxMC4zMjgxMjUgLTAuMTcxODc1IDAuNTQ2ODc1IC0wLjVxMC4xNTYyNSAtMC4yNSAwLjUgLTEuMjE4NzVxMC4wNDY4NzUgLTAuMTQwNjI1IDAuMTQwNjI1IC0wLjQwNjI1bC0zLjY3MTg3NSAtOS42ODc1bDEuNzY1NjI1IDBsMi4wMTU2MjUgNS41OTM3NXEwLjM5MDYyNSAxLjA3ODEyNSAwLjcwMzEyNSAyLjI1cTAuMjgxMjUgLTEuMTI1IDAuNjcxODc1IC0yLjIwMzEyNWwyLjA3ODEyNSAtNS42NDA2MjVsMS42NDA2MjUgMGwtMy42ODc1IDkuODI4MTI1cS0wLjU5Mzc1IDEuNjA5Mzc1IC0wLjkyMTg3NSAyLjIwMzEyNXEtMC40Mzc1IDAuODEyNSAtMS4wIDEuMTg3NXEtMC41NjI1IDAuMzc1IC0xLjM0Mzc1IDAuMzc1cS0wLjQ4NDM3NSAwIC0xLjA2MjUgLTAuMjAzMTI1em05LjA3ODEyNSAtMTAuMjE4NzVxMCAtMy4zMjgxMjUgMS43ODEyNSAtNS4yMDMxMjVxMS43ODEyNSAtMS44OTA2MjUgNC42MDkzNzUgLTEuODkwNjI1cTEuODQzNzUgMCAzLjMyODEyNSAwLjg5MDYyNXExLjQ4NDM3NSAwLjg3NSAyLjI2NTYyNSAyLjQ2ODc1cTAuNzgxMjUgMS41NzgxMjUgMC43ODEyNSAzLjU3ODEyNXEwIDIuMDMxMjUgLTAuODI4MTI1IDMuNjQwNjI1cS0wLjgxMjUgMS41OTM3NSAtMi4zMTI1IDIuNDIxODc1cS0xLjUgMC44MjgxMjUgLTMuMjUgMC44MjgxMjVxLTEuODc1IDAgLTMuMzU5Mzc1IC0wLjkwNjI1cS0xLjQ4NDM3NSAtMC45MjE4NzUgLTIuMjUgLTIuNXEtMC43NjU2MjUgLTEuNTc4MTI1IC0wLjc2NTYyNSAtMy4zMjgxMjV6bTEuODEyNSAwLjAxNTYyNXEwIDIuNDIxODc1IDEuMjk2ODc1IDMuODEyNXExLjI5Njg3NSAxLjM5MDYyNSAzLjI2NTYyNSAxLjM5MDYyNXEyLjAgMCAzLjI4MTI1IC0xLjQwNjI1cTEuMjgxMjUgLTEuNDA2MjUgMS4yODEyNSAtMy45ODQzNzVxMCAtMS42MjUgLTAuNTQ2ODc1IC0yLjg0Mzc1cS0wLjU0Njg3NSAtMS4yMTg3NSAtMS42MDkzNzUgLTEuODc1cS0xLjA2MjUgLTAuNjcxODc1IC0yLjM3NSAtMC42NzE4NzVxLTEuODkwNjI1IDAgLTMuMjUgMS4yOTY4NzVxLTEuMzQzNzUgMS4yODEyNSAtMS4zNDM3NSA0LjI4MTI1em0xNS43MTQ1NTQgNi40ODQzNzVsLTMuNjg3NSAtOS42NzE4NzVsMS43MzQzNzUgMGwyLjA3ODEyNSA1Ljc5Njg3NXEwLjMyODEyNSAwLjkzNzUgMC42MjUgMS45Mzc1cTAuMjAzMTI1IC0wLjc2NTYyNSAwLjYwOTM3NSAtMS44MjgxMjVsMi4xNDA2MjUgLTUuOTA2MjVsMS42ODc1IDBsLTMuNjU2MjUgOS42NzE4NzVsLTEuNTMxMjUgMHptMTMuMjY1NjI1IC0zLjEwOTM3NWwxLjY4NzUgMC4yMDMxMjVxLTAuNDA2MjUgMS40ODQzNzUgLTEuNDg0Mzc1IDIuMzEyNXEtMS4wNzgxMjUgMC44MTI1IC0yLjc2NTYyNSAwLjgxMjVxLTIuMTI1IDAgLTMuMzc1IC0xLjI5Njg3NXEtMS4yMzQzNzUgLTEuMzEyNSAtMS4yMzQzNzUgLTMuNjcxODc1cTAgLTIuNDUzMTI1IDEuMjUgLTMuNzk2ODc1cTEuMjY1NjI1IC0xLjM0Mzc1IDMuMjY1NjI1IC0xLjM0Mzc1cTEuOTM3NSAwIDMuMTU2MjUgMS4zMjgxMjVxMS4yMzQzNzUgMS4zMTI1IDEuMjM0Mzc1IDMuNzAzMTI1cTAgMC4xNTYyNSAwIDAuNDM3NWwtNy4yMTg3NSAwcTAuMDkzNzUgMS41OTM3NSAwLjkwNjI1IDIuNDUzMTI1cTAuODEyNSAwLjg0Mzc1IDIuMDE1NjI1IDAuODQzNzVxMC45MDYyNSAwIDEuNTQ2ODc1IC0wLjQ2ODc1cTAuNjQwNjI1IC0wLjQ4NDM3NSAxLjAxNTYyNSAtMS41MTU2MjV6bS01LjM5MDYyNSAtMi42NTYyNWw1LjQwNjI1IDBxLTAuMTA5Mzc1IC0xLjIxODc1IC0wLjYyNSAtMS44MjgxMjVxLTAuNzgxMjUgLTAuOTUzMTI1IC0yLjAzMTI1IC0wLjk1MzEyNXEtMS4xMjUgMCAtMS45MDYyNSAwLjc2NTYyNXEtMC43NjU2MjUgMC43NSAtMC44NDM3NSAyLjAxNTYyNXptOS4xMjU3MTcgNS43NjU2MjVsMCAtOS42NzE4NzVsMS40Njg3NSAwbDAgMS40Njg3NXEwLjU2MjUgLTEuMDMxMjUgMS4wMzEyNSAtMS4zNTkzNzVxMC40ODQzNzUgLTAuMzI4MTI1IDEuMDYyNSAtMC4zMjgxMjVxMC44MjgxMjUgMCAxLjY4NzUgMC41MzEyNWwtMC41NjI1IDEuNTE1NjI1cS0wLjYwOTM3NSAtMC4zNTkzNzUgLTEuMjAzMTI1IC0wLjM1OTM3NXEtMC41NDY4NzUgMCAtMC45Njg3NSAwLjMyODEyNXEtMC40MjE4NzUgMC4zMjgxMjUgLTAuNjA5Mzc1IDAuODkwNjI1cS0wLjI4MTI1IDAuODc1IC0wLjI4MTI1IDEuOTIxODc1bDAgNS4wNjI1bC0xLjYyNSAwem02LjE4MTQyNyAwbDAgLTEzLjM1OTM3NWwxLjY0MDYyNSAwbDAgMTMuMzU5Mzc1bC0xLjY0MDYyNSAwem0xMC41MDQxOTYgLTEuMTg3NXEtMC45MjE4NzUgMC43NjU2MjUgLTEuNzY1NjI1IDEuMDkzNzVxLTAuODI4MTI1IDAuMzEyNSAtMS43OTY4NzUgMC4zMTI1cS0xLjU5Mzc1IDAgLTIuNDUzMTI1IC0wLjc4MTI1cS0wLjg1OTM3NSAtMC43ODEyNSAtMC44NTkzNzUgLTEuOTg0Mzc1cTAgLTAuNzE4NzUgMC4zMjgxMjUgLTEuMjk2ODc1cTAuMzI4MTI1IC0wLjU5Mzc1IDAuODQzNzUgLTAuOTM3NXEwLjUzMTI1IC0wLjM1OTM3NSAxLjE4NzUgLTAuNTQ2ODc1cTAuNDY4NzUgLTAuMTI1IDEuNDUzMTI1IC0wLjI1cTEuOTg0Mzc1IC0wLjIzNDM3NSAyLjkyMTg3NSAtMC41NjI1cTAuMDE1NjI1IC0wLjM0Mzc1IDAuMDE1NjI1IC0wLjQyMTg3NXEwIC0xLjAgLTAuNDY4NzUgLTEuNDIxODc1cS0wLjYyNSAtMC41NDY4NzUgLTEuODc1IC0wLjU0Njg3NXEtMS4xNTYyNSAwIC0xLjcwMzEyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjgxMjUgMS40MjE4NzVsLTEuNjA5Mzc1IC0wLjIxODc1cTAuMjE4NzUgLTEuMDE1NjI1IDAuNzE4NzUgLTEuNjQwNjI1cTAuNSAtMC42NDA2MjUgMS40NTMxMjUgLTAuOTg0Mzc1cTAuOTUzMTI1IC0wLjM0Mzc1IDIuMTg3NSAtMC4zNDM3NXExLjI1IDAgMi4wMTU2MjUgMC4yOTY4NzVxMC43ODEyNSAwLjI4MTI1IDEuMTQwNjI1IDAuNzM0Mzc1cTAuMzc1IDAuNDM3NSAwLjUxNTYyNSAxLjEwOTM3NXEwLjA3ODEyNSAwLjQyMTg3NSAwLjA3ODEyNSAxLjUxNTYyNWwwIDIuMTg3NXEwIDIuMjgxMjUgMC4xMDkzNzUgMi44OTA2MjVxMC4xMDkzNzUgMC41OTM3NSAwLjQwNjI1IDEuMTU2MjVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzUgMS40NTMxMjUgMC40Mzc1cTAuOTM3NSAwIDEuNjcxODc1IC0wLjQwNjI1cTAuNzUgLTAuNDIxODc1IDEuMDkzNzUgLTEuMTQwNjI1cTAuMjY1NjI1IC0wLjU2MjUgMC4yNjU2MjUgLTEuNjQwNjI1bDAgLTAuNjA5Mzc1em00LjIwMzg0MiA4LjU2MjVsMCAtMTMuMzc1bDEuNDg0Mzc1IDBsMCAxLjI1cTAuNTMxMjUgLTAuNzM0Mzc1IDEuMTg3NSAtMS4wOTM3NXEwLjY3MTg3NSAtMC4zNzUgMS42MjUgLTAuMzc1cTEuMjM0Mzc1IDAgMi4xNzE4NzUgMC42NDA2MjVxMC45NTMxMjUgMC42MjUgMS40Mzc1IDEuNzk2ODc1cTAuNDg0Mzc1IDEuMTU2MjUgMC40ODQzNzUgMi41NDY4NzVxMCAxLjQ4NDM3NSAtMC41MzEyNSAyLjY3MTg3NXEtMC41MzEyNSAxLjE4NzUgLTEuNTQ2ODc1IDEuODI4MTI1cS0xLjAxNTYyNSAwLjYyNSAtMi4xNDA2MjUgMC42MjVxLTAuODEyNSAwIC0xLjQ2ODc1IC0wLjM0Mzc1cS0wLjY1NjI1IC0wLjM0Mzc1IC0xLjA2MjUgLTAuODc1bDAgNC43MDMxMjVsLTEuNjQwNjI1IDB6bTEuNDg0Mzc1IC04LjQ4NDM3NXEwIDEuODU5Mzc1IDAuNzUgMi43NjU2MjVxMC43NjU2MjUgMC44OTA2MjUgMS44MjgxMjUgMC44OTA2MjVxMS4wOTM3NSAwIDEuODc1IC0wLjkyMTg3NXEwLjc4MTI1IC0wLjkzNzUgMC43ODEyNSAtMi44NzVxMCAtMS44NDM3NSAtMC43NjU2MjUgLTIuNzY1NjI1cS0wLjc1IC0wLjkyMTg3NSAtMS44MTI1IC0wLjkyMTg3NXEtMS4wNDY4NzUgMCAtMS44NTkzNzUgMC45ODQzNzVxLTAuNzk2ODc1IDAuOTY4NzUgLTAuNzk2ODc1IDIuODQzNzV6bTguMjM1MDkyIDEuODkwNjI1bDEuNjI1IC0wLjI1cTAuMTI1IDAuOTY4NzUgMC43NSAxLjVxMC42MjUgMC41MTU2MjUgMS43NSAwLjUxNTYyNXExLjEyNSAwIDEuNjcxODc1IC0wLjQ1MzEyNXEwLjU0Njg3NSAtMC40Njg3NSAwLjU0Njg3NSAtMS4wOTM3NXEwIC0wLjU0Njg3NSAtMC40ODQzNzUgLTAuODc1cS0wLjMyODEyNSAtMC4yMTg3NSAtMS42NzE4NzUgLTAuNTQ2ODc1cS0xLjgxMjUgLTAuNDY4NzUgLTIuNTE1NjI1IC0wLjc5Njg3NXEtMC42ODc1IC0wLjMyODEyNSAtMS4wNDY4NzUgLTAuOTA2MjVxLTAuMzU5Mzc1IC0wLjU5Mzc1IC0wLjM1OTM3NSAtMS4zMTI1cTAgLTAuNjQwNjI1IDAuMjk2ODc1IC0xLjE4NzVxMC4yOTY4NzUgLTAuNTYyNSAwLjgxMjUgLTAuOTIxODc1cTAuMzc1IC0wLjI4MTI1IDEuMDMxMjUgLTAuNDY4NzVxMC42NzE4NzUgLTAuMjAzMTI1IDEuNDIxODc1IC0wLjIwMzEyNXExLjE0MDYyNSAwIDIuMCAwLjMyODEyNXEwLjg1OTM3NSAwLjMyODEyNSAxLjI2NTYyNSAwLjg5MDYyNXEwLjQyMTg3NSAwLjU2MjUgMC41NzgxMjUgMS41bC0xLjYwOTM3NSAwLjIxODc1cS0wLjEwOTM3NSAtMC43NSAtMC42NDA2MjUgLTEuMTcxODc1cS0wLjUxNTYyNSAtMC40MjE4NzUgLTEuNDY4NzUgLTAuNDIxODc1cS0xLjE0MDYyNSAwIC0xLjYyNSAwLjM3NXEtMC40Njg3NSAwLjM3NSAtMC40Njg3NSAwLjg3NXEwIDAuMzEyNSAwLjE4NzUgMC41NzgxMjVxMC4yMDMxMjUgMC4yNjU2MjUgMC42NDA2MjUgMC40Mzc1cTAuMjM0Mzc1IDAuMDkzNzUgMS40Mzc1IDAuNDIxODc1cTEuNzUgMC40NTMxMjUgMi40Mzc1IDAuNzVxMC42ODc1IDAuMjk2ODc1IDEuMDc4MTI1IDAuODU5Mzc1cTAuMzkwNjI1IDAuNTYyNSAwLjM5MDYyNSAxLjQwNjI1cTAgMC44MjgxMjUgLTAuNDg0Mzc1IDEuNTQ2ODc1cS0wLjQ2ODc1IDAuNzE4NzUgLTEuMzc1IDEuMTI1cS0wLjkwNjI1IDAuMzkwNjI1IC0yLjA0Njg3NSAwLjM5MDYyNXEtMS44NzUgMCAtMi44NzUgLTAuNzgxMjVxLTAuOTg0Mzc1IC0wLjc4MTI1IC0xLjI1IC0yLjMyODEyNXptMTMuMTA5Mzc1IDYuODEyNXEtMS4zNTkzNzUgLTEuNzAzMTI1IC0yLjI5Njg3NSAtNC4wcS0wLjkzNzUgLTIuMjk2ODc1IC0wLjkzNzUgLTQuNzY1NjI1cTAgLTIuMTU2MjUgMC43MDMxMjUgLTQuMTQwNjI1cTAuODI4MTI1IC0yLjMxMjUgMi41MzEyNSAtNC41OTM3NWwxLjE3MTg3NSAwcS0xLjA5Mzc1IDEuODkwNjI1IC0xLjQ1MzEyNSAyLjcwMzEyNXEtMC41NDY4NzUgMS4yNSAtMC44NzUgMi42MjVxLTAuMzkwNjI1IDEuNzAzMTI1IC0wLjM5MDYyNSAzLjQyMTg3NXEwIDQuMzc1IDIuNzE4NzUgOC43NWwtMS4xNzE4NzUgMHptMi40MzE0MjcgLTYuODEyNWwxLjYyNSAtMC4yNXEwLjEyNSAwLjk2ODc1IDAuNzUgMS41cTAuNjI1IDAuNTE1NjI1IDEuNzUgMC41MTU2MjVxMS4xMjUgMCAxLjY3MTg3NSAtMC40NTMxMjVxMC41NDY4NzUgLTAuNDY4NzUgMC41NDY4NzUgLTEuMDkzNzVxMCAtMC41NDY4NzUgLTAuNDg0Mzc1IC0wLjg3NXEtMC4zMjgxMjUgLTAuMjE4NzUgLTEuNjcxODc1IC0wLjU0Njg3NXEtMS44MTI1IC0wLjQ2ODc1IC0yLjUxNTYyNSAtMC43OTY4NzVxLTAuNjg3NSAtMC4zMjgxMjUgLTEuMDQ2ODc1IC0wLjkwNjI1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzUgMC4zMjgxMjUgMS4yNjU2MjUgMC44OTA2MjVxMC40MjE4NzUgMC41NjI1IDAuNTc4MTI1IDEuNWwtMS42MDkzNzUgMC4yMTg3NXEtMC4xMDkzNzUgLTAuNzUgLTAuNjQwNjI1IC0xLjE3MTg3NXEtMC41MTU2MjUgLTAuNDIxODc1IC0xLjQ2ODc1IC0wLjQyMTg3NXEtMS4xNDA2MjUgMCAtMS42MjUgMC4zNzVxLTAuNDY4NzUgMC4zNzUgLTAuNDY4NzUgMC44NzVxMCAwLjMxMjUgMC4xODc1IDAuNTc4MTI1cTAuMjAzMTI1IDAuMjY1NjI1IDAuNjQwNjI1IDAuNDM3NXEwLjIzNDM3NSAwLjA5Mzc1IDEuNDM3NSAwLjQyMTg3NXExLjc1IDAuNDUzMTI1IDIuNDM3NSAwLjc1cTAuNjg3NSAwLjI5Njg3NSAxLjA3ODEyNSAwLjg1OTM3NXEwLjM5MDYyNSAwLjU2MjUgMC4zOTA2MjUgMS40MDYyNXEwIDAuODI4MTI1IC0wLjQ4NDM3NSAxLjU0Njg3NXEtMC40Njg3NSAwLjcxODc1IC0xLjM3NSAxLjEyNXEtMC45MDYyNSAwLjM5MDYyNSAtMi4wNDY4NzUgMC4zOTA2MjVxLTEuODc1IDAgLTIuODc1IC0wLjc4MTI1cS0wLjk4NDM3NSAtMC43ODEyNSAtMS4yNSAtMi4zMjgxMjV6bTE2LjYwOTM3NSAtMC4yMTg3NWwxLjY4NzUgMC4yMDMxMjVxLTAuNDA2MjUgMS40ODQzNzUgLTEuNDg0Mzc1IDIuMzEyNXEtMS4wNzgxMjUgMC44MTI1IC0yLjc2NTYyNSAwLjgxMjVxLTIuMTI1IDAgLTMuMzc1IC0xLjI5Njg3NXEtMS4yMzQzNzUgLTEuMzEyNSAtMS4yMzQzNzUgLTMuNjcxODc1cTAgLTIuNDUzMTI1IDEuMjUgLTMuNzk2ODc1cTEuMjY1NjI1IC0xLjM0Mzc1IDMuMjY1NjI1IC0xLjM0Mzc1cTEuOTM3NSAwIDMuMTU2MjUgMS4zMjgxMjVxMS4yMzQzNzUgMS4zMTI1IDEuMjM0Mzc1IDMuNzAzMTI1cTAgMC4xNTYyNSAwIDAuNDM3NWwtNy4yMTg3NSAwcTAuMDkzNzUgMS41OTM3NSAwLjkwNjI1IDIuNDUzMTI1cTAuODEyNSAwLjg0Mzc1IDIuMDE1NjI1IDAuODQzNzVxMC45MDYyNSAwIDEuNTQ2ODc1IC0wLjQ2ODc1cTAuNjQwNjI1IC0wLjQ4NDM3NSAxLjAxNTYyNSAtMS41MTU2MjV6bS01LjM5MDYyNSAtMi42NTYyNWw1LjQwNjI1IDBxLTAuMTA5Mzc1IC0xLjIxODc1IC0wLjYyNSAtMS44MjgxMjVxLTAuNzgxMjUgLTAuOTUzMTI1IC0yLjAzMTI1IC0wLjk1MzEyNXEtMS4xMjUgMCAtMS45MDYyNSAwLjc2NTYyNXEtMC43NjU2MjUgMC43NSAtMC44NDM3NSAyLjAxNTYyNXptOS41NjMyMTcgNS43NjU2MjVsMCAtMS44NzVsMS44NzUgMGwwIDEuODc1cTAgMS4wMzEyNSAtMC4zNzUgMS42NTYyNXEtMC4zNTkzNzUgMC42NDA2MjUgLTEuMTU2MjUgMC45ODQzNzVsLTAuNDUzMTI1IC0wLjcwMzEyNXEwLjUxNTYyNSAtMC4yMTg3NSAwLjc2NTYyNSAtMC42NzE4NzVxMC4yNSAtMC40Mzc1IDAuMjgxMjUgLTEuMjY1NjI1bC0wLjkzNzUgMHptOS45MjkxMDggMGwwIC05LjY3MTg3NWwxLjQ2ODc1IDBsMCAxLjQ2ODc1cTAuNTYyNSAtMS4wMzEyNSAxLjAzMTI1IC0xLjM1OTM3NXEwLjQ4NDM3NSAtMC4zMjgxMjUgMS4wNjI1IC0wLjMyODEyNXEwLjgyODEyNSAwIDEuNjg3NSAwLjUzMTI1bC0wLjU2MjUgMS41MTU2MjVxLTAuNjA5Mzc1IC0wLjM1OTM3NSAtMS4yMDMxMjUgLTAuMzU5Mzc1cS0wLjU0Njg3NSAwIC0wLjk2ODc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjMyODEyNSAtMC42MDkzNzUgMC44OTA2MjVxLTAuMjgxMjUgMC44NzUgLTAuMjgxMjUgMS45MjE4NzVsMCA1LjA2MjVsLTEuNjI1IDB6bTUuNjE4OTI3IC00Ljg0Mzc1cTAgLTIuNjg3NSAxLjQ4NDM3NSAtMy45Njg3NXExLjI1IC0xLjA3ODEyNSAzLjA0Njg3NSAtMS4wNzgxMjVxMi4wIDAgMy4yNjU2MjUgMS4zMTI1cTEuMjY1NjI1IDEuMjk2ODc1IDEuMjY1NjI1IDMuNjA5Mzc1cTAgMS44NTkzNzUgLTAuNTYyNSAyLjkzNzVxLTAuNTYyNSAxLjA2MjUgLTEuNjQwNjI1IDEuNjU2MjVxLTEuMDYyNSAwLjU5Mzc1IC0yLjMyODEyNSAwLjU5Mzc1cS0yLjAzMTI1IDAgLTMuMjgxMjUgLTEuMjk2ODc1cS0xLjI1IC0xLjMxMjUgLTEuMjUgLTMuNzY1NjI1em0xLjY4NzUgMHEwIDEuODU5Mzc1IDAuNzk2ODc1IDIuNzk2ODc1cTAuODEyNSAwLjkyMTg3NSAyLjA0Njg3NSAwLjkyMTg3NXExLjIxODc1IDAgMi4wMzEyNSAtMC45MjE4NzVxMC44MTI1IC0wLjkzNzUgMC44MTI1IC0yLjg0Mzc1cTAgLTEuNzk2ODc1IC0wLjgxMjUgLTIuNzE4NzVxLTAuODEyNSAtMC45MjE4NzUgLTIuMDMxMjUgLTAuOTIxODc1cS0xLjIzNDM3NSAwIC0yLjA0Njg3NSAwLjkyMTg3NXEtMC43OTY4NzUgMC45MDYyNSAtMC43OTY4NzUgMi43NjU2MjV6bTkuMjk3NTkyIC02LjYyNWwwIC0xLjg5MDYyNWwxLjY0MDYyNSAwbDAgMS44OTA2MjVsLTEuNjQwNjI1IDB6bTAgMTEuNDY4NzVsMCAtOS42NzE4NzVsMS42NDA2MjUgMGwwIDkuNjcxODc1bC0xLjY0MDYyNSAwem01LjIyMjk0NiAzLjkyMTg3NWwtMS4xODc1IDBxMi43MzQzNzUgLTQuMzc1IDIuNzM0Mzc1IC04Ljc1cTAgLTEuNzE4NzUgLTAuMzkwNjI1IC0zLjM5MDYyNXEtMC4zMTI1IC0xLjM3NSAtMC44NzUgLTIuNjI1cS0wLjM1OTM3NSAtMC44MjgxMjUgLTEuNDY4NzUgLTIuNzM0Mzc1bDEuMTg3NSAwcTEuNzAzMTI1IDIuMjgxMjUgMi41MzEyNSA0LjU5Mzc1cTAuNjg3NSAxLjk4NDM3NSAwLjY4NzUgNC4xNDA2MjVxMCAyLjQ2ODc1IC0wLjkzNzUgNC43NjU2MjVxLTAuOTM3NSAyLjI5Njg3NSAtMi4yODEyNSA0LjB6IiBmaWxsLXJ1bGU9Im5vbnplcm8iLz48cGF0aCBmaWxsPSIjY2ZlMmYzIiBkPSJtNjkuMzQ2NDYgMTgxLjExMDIzbDg0Ljg4MTg5IDBsMCAyODcuMTE4MWwtODQuODgxODkgMHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIHN0cm9rZT0iIzQzNDM0MyIgc3Ryb2tlLXdpZHRoPSIzLjAiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS1saW5lY2FwPSJidXR0IiBkPSJtNjkuMzQ2NDYgMTgxLjExMDIzbDg0Ljg4MTg5IDBsMCAyODcuMTE4MWwtODQuODgxODkgMHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIGZpbGw9IiNkOWQyZTkiIGQ9Im03MC44MjY3NzUgMjI4LjcxMzkxbDgxLjk1Mjc1IDBsMCA1NC44MzQ2NGwtODEuOTUyNzUgMHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIHN0cm9rZT0iIzY2NjY2NiIgc3Ryb2tlLXdpZHRoPSIxLjAiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS1saW5lY2FwPSJidXR0IiBzdHJva2UtZGFzaGFycmF5PSIxLjAsMy4wIiBkPSJtNzAuODI2Nzc1IDIyOC43MTM5MWw4MS45NTI3NSAwbDAgNTQuODM0NjRsLTgxLjk1Mjc1IDB6IiBmaWxsLXJ1bGU9ImV2ZW5vZGQiLz48cGF0aCBmaWxsPSIjZDlkMmU5IiBkPSJtNzAuODI2Nzc1IDM0My45MTg2NGw4MS45NTI3NSAwbDAgMjMuNzE2NTIybC04MS45NTI3NSAweiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PHBhdGggc3Ryb2tlPSIjNjY2NjY2IiBzdHJva2Utd2lkdGg9IjEuMCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLWxpbmVjYXA9ImJ1dHQiIHN0cm9rZS1kYXNoYXJyYXk9IjEuMCwzLjAiIGQ9Im03MC44MjY3NzUgMzQzLjkxODY0bDgxLjk1Mjc1IDBsMCAyMy43MTY1MjJsLTgxLjk1Mjc1IDB6IiBmaWxsLXJ1bGU9ImV2ZW5vZGQiLz48cGF0aCBmaWxsPSIjMDAwMDAwIiBmaWxsLW9wYWNpdHk9IjAuMCIgZD0ibTIyOC4wMTA1IDQ5OS4zMzU5N2wzMDMuMDU1MSAwbDAgMTAyLjc3MTY0bC0zMDMuMDU1MSAweiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PHBhdGggZmlsbD0iIzAwMDAwMCIgZD0ibTI0NC41NTczNyA1MjUuMDY4NXEtMC45MjE4NzUgMC43NjU2MjUgLTEuNzY1NjI1IDEuMDkzNzVxLTAuODI4MTI1IDAuMzEyNSAtMS43OTY4NzUgMC4zMTI1cS0xLjU5Mzc1IDAgLTIuNDUzMTI1IC0wLjc4MTI1cS0wLjg1OTM3NSAtMC43ODEyNSAtMC44NTkzNzUgLTEuOTg0Mzc1cTAgLTAuNzE4NzUgMC4zMjgxMjUgLTEuMjk2ODc1cTAuMzI4MTI1IC0wLjU5Mzc1IDAuODQzNzUgLTAuOTM3NXEwLjUzMTI1IC0wLjM1OTM3NSAxLjE4NzUgLTAuNTQ2ODc1cTAuNDY4NzUgLTAuMTI1IDEuNDUzMTI1IC0wLjI1cTEuOTg0Mzc1IC0wLjIzNDM3NSAyLjkyMTg3NSAtMC41NjI1cTAuMDE1NjI1IC0wLjM0Mzc1IDAuMDE1NjI1IC0wLjQyMTg3NXEwIC0xLjAgLTAuNDY4NzUgLTEuNDIxODc1cS0wLjYyNSAtMC41NDY4NzUgLTEuODc1IC0wLjU0Njg3NXEtMS4xNTYyNSAwIC0xLjcwMzEyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjgxMjUgMS40MjE4NzVsLTEuNjA5Mzc1IC0wLjIxODc1cTAuMjE4NzUgLTEuMDE1NjI1IDAuNzE4NzUgLTEuNjQwNjI1cTAuNSAtMC42NDA2MjUgMS40NTMxMjUgLTAuOTg0Mzc1cTAuOTUzMTI1IC0wLjM0Mzc1IDIuMTg3NSAtMC4zNDM3NXExLjI1IDAgMi4wMTU2MjUgMC4yOTY4NzVxMC43ODEyNSAwLjI4MTI1IDEuMTQwNjI1IDAuNzM0Mzc1cTAuMzc1IDAuNDM3NSAwLjUxNTYyNSAxLjEwOTM3NXEwLjA3ODEyNSAwLjQyMTg3NSAwLjA3ODEyNSAxLjUxNTYyNWwwIDIuMTg3NXEwIDIuMjgxMjUgMC4xMDkzNzUgMi44OTA2MjVxMC4xMDkzNzUgMC41OTM3NSAwLjQwNjI1IDEuMTU2MjVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzUgMS40NTMxMjUgMC40Mzc1cTAuOTM3NSAwIDEuNjcxODc1IC0wLjQwNjI1cTAuNzUgLTAuNDIxODc1IDEuMDkzNzUgLTEuMTQwNjI1cTAuMjY1NjI1IC0wLjU2MjUgMC4yNjU2MjUgLTEuNjQwNjI1bDAgLTAuNjA5Mzc1em0zLjU0NzU5MjIgMS45Njg3NWwxLjYyNSAtMC4yNXEwLjEyNSAwLjk2ODc1IDAuNzUgMS41cTAuNjI1IDAuNTE1NjI1IDEuNzUgMC41MTU2MjVxMS4xMjUgMCAxLjY3MTg3NSAtMC40NTMxMjVxMC41NDY4NzUgLTAuNDY4NzUgMC41NDY4NzUgLTEuMDkzNzVxMCAtMC41NDY4NzUgLTAuNDg0Mzc1IC0wLjg3NXEtMC4zMjgxMjUgLTAuMjE4NzUgLTEuNjcxODc1IC0wLjU0Njg3NXEtMS44MTI1IC0wLjQ2ODc1IC0yLjUxNTYyNSAtMC43OTY4NzVxLTAuNjg3NSAtMC4zMjgxMjUgLTEuMDQ2ODc1IC0wLjkwNjI1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzUgMC4zMjgxMjUgMS4yNjU2MjUgMC44OTA2MjVxMC40MjE4NzUgMC41NjI1IDAuNTc4MTI1IDEuNWwtMS42MDkzNzUgMC4yMTg3NXEtMC4xMDkzNzUgLTAuNzUgLTAuNjQwNjI1IC0xLjE3MTg3NXEtMC41MTU2MjUgLTAuNDIxODc1IC0xLjQ2ODc1IC0wLjQyMTg3NXEtMS4xNDA2MjUgMCAtMS42MjUgMC4zNzVxLTAuNDY4NzUgMC4zNzUgLTAuNDY4NzUgMC44NzVxMCAwLjMxMjUgMC4xODc1IDAuNTc4MTI1cTAuMjAzMTI1IDAuMjY1NjI1IDAuNjQwNjI1IDAuNDM3NXEwLjIzNDM3NSAwLjA5Mzc1IDEuNDM3NSAwLjQyMTg3NXExLjc1IDAuNDUzMTI1IDIuNDM3NSAwLjc1cTAuNjg3NSAwLjI5Njg3NSAxLjA3ODEyNSAwLjg1OTM3NXEwLjM5MDYyNSAwLjU2MjUgMC4zOTA2MjUgMS40MDYyNXEwIDAuODI4MTI1IC0wLjQ4NDM3NSAxLjU0Njg3NXEtMC40Njg3NSAwLjcxODc1IC0xLjM3NSAxLjEyNXEtMC45MDYyNSAwLjM5MDYyNSAtMi4wNDY4NzUgMC4zOTA2MjVxLTEuODc1IDAgLTIuODc1IC0wLjc4MTI1cS0wLjk4NDM3NSAtMC43ODEyNSAtMS4yNSAtMi4zMjgxMjV6bTkuMzI4MTQgMGwxLjYyNSAtMC4yNXEwLjEyNSAwLjk2ODc1IDAuNzUgMS41cTAuNjI1IDAuNTE1NjI1IDEuNzUgMC41MTU2MjVxMS4xMjUgMCAxLjY3MTg3NSAtMC40NTMxMjVxMC41NDY4NzUgLTAuNDY4NzUgMC41NDY4NzUgLTEuMDkzNzVxMCAtMC41NDY4NzUgLTAuNDg0Mzc1IC0wLjg3NXEtMC4zMjgxMjUgLTAuMjE4NzUgLTEuNjcxODc1IC0wLjU0Njg3NXEtMS44MTI1IC0wLjQ2ODc1IC0yLjUxNTYyNSAtMC43OTY4NzVxLTAuNjg3NSAtMC4zMjgxMjUgLTEuMDQ2ODc1IC0wLjkwNjI1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzUgMC4zMjgxMjUgMS4yNjU2MjUgMC44OTA2MjVxMC40MjE4NzUgMC41NjI1IDAuNTc4MTI1IDEuNWwtMS42MDkzNzUgMC4yMTg3NXEtMC4xMDkzNzUgLTAuNzUgLTAuNjQwNjI1IC0xLjE3MTg3NXEtMC41MTU2MjUgLTAuNDIxODc1IC0xLjQ2ODc1IC0wLjQyMTg3NXEtMS4xNDA2MjUgMCAtMS42MjUgMC4zNzVxLTAuNDY4NzUgMC4zNzUgLTAuNDY4NzUgMC44NzVxMCAwLjMxMjUgMC4xODc1IDAuNTc4MTI1cTAuMjAzMTI1IDAuMjY1NjI1IDAuNjQwNjI1IDAuNDM3NXEwLjIzNDM3NSAwLjA5Mzc1IDEuNDM3NSAwLjQyMTg3NXExLjc1IDAuNDUzMTI1IDIuNDM3NSAwLjc1cTAuNjg3NSAwLjI5Njg3NSAxLjA3ODEyNSAwLjg1OTM3NXEwLjM5MDYyNSAwLjU2MjUgMC4zOTA2MjUgMS40MDYyNXEwIDAuODI4MTI1IC0wLjQ4NDM3NSAxLjU0Njg3NXEtMC40Njg3NSAwLjcxODc1IC0xLjM3NSAxLjEyNXEtMC45MDYyNSAwLjM5MDYyNSAtMi4wNDY4NzUgMC4zOTA2MjVxLTEuODc1IDAgLTIuODc1IC0wLjc4MTI1cS0wLjk4NDM3NSAtMC43ODEyNSAtMS4yNSAtMi4zMjgxMjV6bTE2LjI5Njg3NSAxLjcwMzEyNXEtMC45MjE4NzUgMC43NjU2MjUgLTEuNzY1NjI1IDEuMDkzNzVxLTAuODI4MTI1IDAuMzEyNSAtMS43OTY4NzUgMC4zMTI1cS0xLjU5Mzc1IDAgLTIuNDUzMTI1IC0wLjc4MTI1cS0wLjg1OTM3NSAtMC43ODEyNSAtMC44NTkzNzUgLTEuOTg0Mzc1cTAgLTAuNzE4NzUgMC4zMjgxMjUgLTEuMjk2ODc1cTAuMzI4MTI1IC0wLjU5Mzc1IDAuODQzNzUgLTAuOTM3NXEwLjUzMTI1IC0wLjM1OTM3NSAxLjE4NzUgLTAuNTQ2ODc1cTAuNDY4NzUgLTAuMTI1IDEuNDUzMTI1IC0wLjI1cTEuOTg0Mzc1IC0wLjIzNDM3NSAyLjkyMTg3NSAtMC41NjI1cTAuMDE1NjI1IC0wLjM0Mzc1IDAuMDE1NjI1IC0wLjQyMTg3NXEwIC0xLjAgLTAuNDY4NzUgLTEuNDIxODc1cS0wLjYyNSAtMC41NDY4NzUgLTEuODc1IC0wLjU0Njg3NXEtMS4xNTYyNSAwIC0xLjcwMzEyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjgxMjUgMS40MjE4NzVsLTEuNjA5Mzc1IC0wLjIxODc1cTAuMjE4NzUgLTEuMDE1NjI1IDAuNzE4NzUgLTEuNjQwNjI1cTAuNSAtMC42NDA2MjUgMS40NTMxMjUgLTAuOTg0Mzc1cTAuOTUzMTI1IC0wLjM0Mzc1IDIuMTg3NSAtMC4zNDM3NXExLjI1IDAgMi4wMTU2MjUgMC4yOTY4NzVxMC43ODEyNSAwLjI4MTI1IDEuMTQwNjI1IDAuNzM0Mzc1cTAuMzc1IDAuNDM3NSAwLjUxNTYyNSAxLjEwOTM3NXEwLjA3ODEyNSAwLjQyMTg3NSAwLjA3ODEyNSAxLjUxNTYyNWwwIDIuMTg3NXEwIDIuMjgxMjUgMC4xMDkzNzUgMi44OTA2MjVxMC4xMDkzNzUgMC41OTM3NSAwLjQwNjI1IDEuMTU2MjVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzUgMS40NTMxMjUgMC40Mzc1cTAuOTM3NSAwIDEuNjcxODc1IC0wLjQwNjI1cTAuNzUgLTAuNDIxODc1IDEuMDkzNzUgLTEuMTQwNjI1cTAuMjY1NjI1IC0wLjU2MjUgMC4yNjU2MjUgLTEuNjQwNjI1bDAgLTAuNjA5Mzc1em00LjEyNTcwMiA4LjU3ODEyNWwtMC4xODc1IC0xLjUzMTI1cTAuNTQ2ODc1IDAuMTQwNjI1IDAuOTM3NSAwLjE0MDYyNXEwLjU0Njg3NSAwIDAuODc1IC0wLjE4NzVxMC4zMjgxMjUgLTAuMTcxODc1IDAuNTQ2ODc1IC0wLjVxMC4xNTYyNSAtMC4yNSAwLjUgLTEuMjE4NzVxMC4wNDY4NzUgLTAuMTQwNjI1IDAuMTQwNjI1IC0wLjQwNjI1bC0zLjY3MTg3NSAtOS42ODc1bDEuNzY1NjI1IDBsMi4wMTU2MjUgNS41OTM3NXEwLjM5MDYyNSAxLjA3ODEyNSAwLjcwMzEyNSAyLjI1cTAuMjgxMjUgLTEuMTI1IDAuNjcxODc1IC0yLjIwMzEyNWwyLjA3ODEyNSAtNS42NDA2MjVsMS42NDA2MjUgMGwtMy42ODc1IDkuODI4MTI1cS0wLjU5Mzc1IDEuNjA5Mzc1IC0wLjkyMTg3NSAyLjIwMzEyNXEtMC40Mzc1IDAuODEyNSAtMS4wIDEuMTg3NXEtMC41NjI1IDAuMzc1IC0xLjM0Mzc1IDAuMzc1cS0wLjQ4NDM3NSAwIC0xLjA2MjUgLTAuMjAzMTI1em04Ljc1IC02LjYwOTM3NWwxLjYyNSAtMC4yNXEwLjEyNSAwLjk2ODc1IDAuNzUgMS41cTAuNjI1IDAuNTE1NjI1IDEuNzUgMC41MTU2MjVxMS4xMjUgMCAxLjY3MTg3NSAtMC40NTMxMjVxMC41NDY4NzUgLTAuNDY4NzUgMC41NDY4NzUgLTEuMDkzNzVxMCAtMC41NDY4NzUgLTAuNDg0Mzc1IC0wLjg3NXEtMC4zMjgxMjUgLTAuMjE4NzUgLTEuNjcxODc1IC0wLjU0Njg3NXEtMS44MTI1IC0wLjQ2ODc1IC0yLjUxNTYyNSAtMC43OTY4NzVxLTAuNjg3NSAtMC4zMjgxMjUgLTEuMDQ2ODc1IC0wLjkwNjI1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzUgMC4zMjgxMjUgMS4yNjU2MjUgMC44OTA2MjVxMC40MjE4NzUgMC41NjI1IDAuNTc4MTI1IDEuNWwtMS42MDkzNzUgMC4yMTg3NXEtMC4xMDkzNzUgLTAuNzUgLTAuNjQwNjI1IC0xLjE3MTg3NXEtMC41MTU2MjUgLTAuNDIxODc1IC0xLjQ2ODc1IC0wLjQyMTg3NXEtMS4xNDA2MjUgMCAtMS42MjUgMC4zNzVxLTAuNDY4NzUgMC4zNzUgLTAuNDY4NzUgMC44NzVxMCAwLjMxMjUgMC4xODc1IDAuNTc4MTI1cTAuMjAzMTI1IDAuMjY1NjI1IDAuNjQwNjI1IDAuNDM3NXEwLjIzNDM3NSAwLjA5Mzc1IDEuNDM3NSAwLjQyMTg3NXExLjc1IDAuNDUzMTI1IDIuNDM3NSAwLjc1cTAuNjg3NSAwLjI5Njg3NSAxLjA3ODEyNSAwLjg1OTM3NXEwLjM5MDYyNSAwLjU2MjUgMC4zOTA2MjUgMS40MDYyNXEwIDAuODI4MTI1IC0wLjQ4NDM3NSAxLjU0Njg3NXEtMC40Njg3NSAwLjcxODc1IC0xLjM3NSAxLjEyNXEtMC45MDYyNSAwLjM5MDYyNSAtMi4wNDY4NzUgMC4zOTA2MjVxLTEuODc1IDAgLTIuODc1IC0wLjc4MTI1cS0wLjk4NDM3NSAtMC43ODEyNSAtMS4yNSAtMi4zMjgxMjV6bTEzLjEwOTM3NSA2LjgxMjVxLTEuMzU5Mzc1IC0xLjcwMzEyNSAtMi4yOTY4NzUgLTQuMHEtMC45Mzc1IC0yLjI5Njg3NSAtMC45Mzc1IC00Ljc2NTYyNXEwIC0yLjE1NjI1IDAuNzAzMTI1IC00LjE0MDYyNXEwLjgyODEyNSAtMi4zMTI1IDIuNTMxMjUgLTQuNTkzNzVsMS4xNzE4NzUgMHEtMS4wOTM3NSAxLjg5MDYyNSAtMS40NTMxMjUgMi43MDMxMjVxLTAuNTQ2ODc1IDEuMjUgLTAuODc1IDIuNjI1cS0wLjM5MDYyNSAxLjcwMzEyNSAtMC4zOTA2MjUgMy40MjE4NzVxMCA0LjM3NSAyLjcxODc1IDguNzVsLTEuMTcxODc1IDB6bTIuNDMxNDI3IC02LjgxMjVsMS42MjUgLTAuMjVxMC4xMjUgMC45Njg3NSAwLjc1IDEuNXEwLjYyNSAwLjUxNTYyNSAxLjc1IDAuNTE1NjI1cTEuMTI1IDAgMS42NzE4NzUgLTAuNDUzMTI1cTAuNTQ2ODc1IC0wLjQ2ODc1IDAuNTQ2ODc1IC0xLjA5Mzc1cTAgLTAuNTQ2ODc1IC0wLjQ4NDM3NSAtMC44NzVxLTAuMzI4MTI1IC0wLjIxODc1IC0xLjY3MTg3NSAtMC41NDY4NzVxLTEuODEyNSAtMC40Njg3NSAtMi41MTU2MjUgLTAuNzk2ODc1cS0wLjY4NzUgLTAuMzI4MTI1IC0xLjA0Njg3NSAtMC45MDYyNXEtMC4zNTkzNzUgLTAuNTkzNzUgLTAuMzU5Mzc1IC0xLjMxMjVxMCAtMC42NDA2MjUgMC4yOTY4NzUgLTEuMTg3NXEwLjI5Njg3NSAtMC41NjI1IDAuODEyNSAtMC45MjE4NzVxMC4zNzUgLTAuMjgxMjUgMS4wMzEyNSAtMC40Njg3NXEwLjY3MTg3NSAtMC4yMDMxMjUgMS40MjE4NzUgLTAuMjAzMTI1cTEuMTQwNjI1IDAgMi4wIDAuMzI4MTI1cTAuODU5Mzc1IDAuMzI4MTI1IDEuMjY1NjI1IDAuODkwNjI1cTAuNDIxODc1IDAuNTYyNSAwLjU3ODEyNSAxLjVsLTEuNjA5Mzc1IDAuMjE4NzVxLTAuMTA5Mzc1IC0wLjc1IC0wLjY0MDYyNSAtMS4xNzE4NzVxLTAuNTE1NjI1IC0wLjQyMTg3NSAtMS40Njg3NSAtMC40MjE4NzVxLTEuMTQwNjI1IDAgLTEuNjI1IDAuMzc1cS0wLjQ2ODc1IDAuMzc1IC0wLjQ2ODc1IDAuODc1cTAgMC4zMTI1IDAuMTg3NSAwLjU3ODEyNXEwLjIwMzEyNSAwLjI2NTYyNSAwLjY0MDYyNSAwLjQzNzVxMC4yMzQzNzUgMC4wOTM3NSAxLjQzNzUgMC40MjE4NzVxMS43NSAwLjQ1MzEyNSAyLjQzNzUgMC43NXEwLjY4NzUgMC4yOTY4NzUgMS4wNzgxMjUgMC44NTkzNzVxMC4zOTA2MjUgMC41NjI1IDAuMzkwNjI1IDEuNDA2MjVxMCAwLjgyODEyNSAtMC40ODQzNzUgMS41NDY4NzVxLTAuNDY4NzUgMC43MTg3NSAtMS4zNzUgMS4xMjVxLTAuOTA2MjUgMC4zOTA2MjUgLTIuMDQ2ODc1IDAuMzkwNjI1cS0xLjg3NSAwIC0yLjg3NSAtMC43ODEyNXEtMC45ODQzNzUgLTAuNzgxMjUgLTEuMjUgLTIuMzI4MTI1em0xNi42MDkzNzUgLTAuMjE4NzVsMS42ODc1IDAuMjAzMTI1cS0wLjQwNjI1IDEuNDg0Mzc1IC0xLjQ4NDM3NSAyLjMxMjVxLTEuMDc4MTI1IDAuODEyNSAtMi43NjU2MjUgMC44MTI1cS0yLjEyNSAwIC0zLjM3NSAtMS4yOTY4NzVxLTEuMjM0Mzc1IC0xLjMxMjUgLTEuMjM0Mzc1IC0zLjY3MTg3NXEwIC0yLjQ1MzEyNSAxLjI1IC0zLjc5Njg3NXExLjI2NTYyNSAtMS4zNDM3NSAzLjI2NTYyNSAtMS4zNDM3NXExLjkzNzUgMCAzLjE1NjI1IDEuMzI4MTI1cTEuMjM0Mzc1IDEuMzEyNSAxLjIzNDM3NSAzLjcwMzEyNXEwIDAuMTU2MjUgMCAwLjQzNzVsLTcuMjE4NzUgMHEwLjA5Mzc1IDEuNTkzNzUgMC45MDYyNSAyLjQ1MzEyNXEwLjgxMjUgMC44NDM3NSAyLjAxNTYyNSAwLjg0Mzc1cTAuOTA2MjUgMCAxLjU0Njg3NSAtMC40Njg3NXEwLjY0MDYyNSAtMC40ODQzNzUgMS4wMTU2MjUgLTEuNTE1NjI1em0tNS4zOTA2MjUgLTIuNjU2MjVsNS40MDYyNSAwcS0wLjEwOTM3NSAtMS4yMTg3NSAtMC42MjUgLTEuODI4MTI1cS0wLjc4MTI1IC0wLjk1MzEyNSAtMi4wMzEyNSAtMC45NTMxMjVxLTEuMTI1IDAgLTEuOTA2MjUgMC43NjU2MjVxLTAuNzY1NjI1IDAuNzUgLTAuODQzNzUgMi4wMTU2MjV6bTEwLjIxOTQ4MiA5LjY4NzVsLTEuMTg3NSAwcTIuNzM0Mzc1IC00LjM3NSAyLjczNDM3NSAtOC43NXEwIC0xLjcxODc1IC0wLjM5MDYyNSAtMy4zOTA2MjVxLTAuMzEyNSAtMS4zNzUgLTAuODc1IC0yLjYyNXEtMC4zNTkzNzUgLTAuODI4MTI1IC0xLjQ2ODc1IC0yLjczNDM3NWwxLjE4NzUgMHExLjcwMzEyNSAyLjI4MTI1IDIuNTMxMjUgNC41OTM3NXEwLjY4NzUgMS45ODQzNzUgMC42ODc1IDQuMTQwNjI1cTAgMi40Njg3NSAtMC45Mzc1IDQuNzY1NjI1cS0wLjkzNzUgMi4yOTY4NzUgLTIuMjgxMjUgNC4weiIgZmlsbC1ydWxlPSJub256ZXJvIi8+PHBhdGggZmlsbD0iIzZhYTg0ZiIgZD0ibTI0NC41NTczNyA1NDcuMDY4NXEtMC45MjE4NzUgMC43NjU2MjUgLTEuNzY1NjI1IDEuMDkzNzVxLTAuODI4MTI1IDAuMzEyNSAtMS43OTY4NzUgMC4zMTI1cS0xLjU5Mzc1IDAgLTIuNDUzMTI1IC0wLjc4MTI1cS0wLjg1OTM3NSAtMC43ODEyNSAtMC44NTkzNzUgLTEuOTg0Mzc1cTAgLTAuNzE4NzUgMC4zMjgxMjUgLTEuMjk2ODc1cTAuMzI4MTI1IC0wLjU5Mzc1IDAuODQzNzUgLTAuOTM3NXEwLjUzMTI1IC0wLjM1OTM3NSAxLjE4NzUgLTAuNTQ2ODc1cTAuNDY4NzUgLTAuMTI1IDEuNDUzMTI1IC0wLjI1cTEuOTg0Mzc1IC0wLjIzNDM3NSAyLjkyMTg3NSAtMC41NjI1cTAuMDE1NjI1IC0wLjM0Mzc1IDAuMDE1NjI1IC0wLjQyMTg3NXEwIC0xLjAgLTAuNDY4NzUgLTEuNDIxODc1cS0wLjYyNSAtMC41NDY4NzUgLTEuODc1IC0wLjU0Njg3NXEtMS4xNTYyNSAwIC0xLjcwMzEyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjgxMjUgMS40MjE4NzVsLTEuNjA5Mzc1IC0wLjIxODc1cTAuMjE4NzUgLTEuMDE1NjI1IDAuNzE4NzUgLTEuNjQwNjI1cTAuNSAtMC42NDA2MjUgMS40NTMxMjUgLTAuOTg0Mzc1cTAuOTUzMTI1IC0wLjM0Mzc1IDIuMTg3NSAtMC4zNDM3NXExLjI1IDAgMi4wMTU2MjUgMC4yOTY4NzVxMC43ODEyNSAwLjI4MTI1IDEuMTQwNjI1IDAuNzM0Mzc1cTAuMzc1IDAuNDM3NSAwLjUxNTYyNSAxLjEwOTM3NXEwLjA3ODEyNSAwLjQyMTg3NSAwLjA3ODEyNSAxLjUxNTYyNWwwIDIuMTg3NXEwIDIuMjgxMjUgMC4xMDkzNzUgMi44OTA2MjVxMC4xMDkzNzUgMC41OTM3NSAwLjQwNjI1IDEuMTU2MjVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzUgMS40NTMxMjUgMC40Mzc1cTAuOTM3NSAwIDEuNjcxODc1IC0wLjQwNjI1cTAuNzUgLTAuNDIxODc1IDEuMDkzNzUgLTEuMTQwNjI1cTAuMjY1NjI1IC0wLjU2MjUgMC4yNjU2MjUgLTEuNjQwNjI1bDAgLTAuNjA5Mzc1em0zLjU0NzU5MjIgMS45Njg3NWwxLjYyNSAtMC4yNXEwLjEyNSAwLjk2ODc1IDAuNzUgMS41cTAuNjI1IDAuNTE1NjI1IDEuNzUgMC41MTU2MjVxMS4xMjUgMCAxLjY3MTg3NSAtMC40NTMxMjVxMC41NDY4NzUgLTAuNDY4NzUgMC41NDY4NzUgLTEuMDkzNzVxMCAtMC41NDY4NzUgLTAuNDg0Mzc1IC0wLjg3NXEtMC4zMjgxMjUgLTAuMjE4NzUgLTEuNjcxODc1IC0wLjU0Njg3NXEtMS44MTI1IC0wLjQ2ODc1IC0yLjUxNTYyNSAtMC43OTY4NzVxLTAuNjg3NSAtMC4zMjgxMjUgLTEuMDQ2ODc1IC0wLjkwNjI1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzUgMC4zMjgxMjUgMS4yNjU2MjUgMC44OTA2MjVxMC40MjE4NzUgMC41NjI1IDAuNTc4MTI1IDEuNWwtMS42MDkzNzUgMC4yMTg3NXEtMC4xMDkzNzUgLTAuNzUgLTAuNjQwNjI1IC0xLjE3MTg3NXEtMC41MTU2MjUgLTAuNDIxODc1IC0xLjQ2ODc1IC0wLjQyMTg3NXEtMS4xNDA2MjUgMCAtMS42MjUgMC4zNzVxLTAuNDY4NzUgMC4zNzUgLTAuNDY4NzUgMC44NzVxMCAwLjMxMjUgMC4xODc1IDAuNTc4MTI1cTAuMjAzMTI1IDAuMjY1NjI1IDAuNjQwNjI1IDAuNDM3NXEwLjIzNDM3NSAwLjA5Mzc1IDEuNDM3NSAwLjQyMTg3NXExLjc1IDAuNDUzMTI1IDIuNDM3NSAwLjc1cTAuNjg3NSAwLjI5Njg3NSAxLjA3ODEyNSAwLjg1OTM3NXEwLjM5MDYyNSAwLjU2MjUgMC4zOTA2MjUgMS40MDYyNXEwIDAuODI4MTI1IC0wLjQ4NDM3NSAxLjU0Njg3NXEtMC40Njg3NSAwLjcxODc1IC0xLjM3NSAxLjEyNXEtMC45MDYyNSAwLjM5MDYyNSAtMi4wNDY4NzUgMC4zOTA2MjVxLTEuODc1IDAgLTIuODc1IC0wLjc4MTI1cS0wLjk4NDM3NSAtMC43ODEyNSAtMS4yNSAtMi4zMjgxMjV6bTkuMzI4MTQgMGwxLjYyNSAtMC4yNXEwLjEyNSAwLjk2ODc1IDAuNzUgMS41cTAuNjI1IDAuNTE1NjI1IDEuNzUgMC41MTU2MjVxMS4xMjUgMCAxLjY3MTg3NSAtMC40NTMxMjVxMC41NDY4NzUgLTAuNDY4NzUgMC41NDY4NzUgLTEuMDkzNzVxMCAtMC41NDY4NzUgLTAuNDg0Mzc1IC0wLjg3NXEtMC4zMjgxMjUgLTAuMjE4NzUgLTEuNjcxODc1IC0wLjU0Njg3NXEtMS44MTI1IC0wLjQ2ODc1IC0yLjUxNTYyNSAtMC43OTY4NzVxLTAuNjg3NSAtMC4zMjgxMjUgLTEuMDQ2ODc1IC0wLjkwNjI1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzUgMC4zMjgxMjUgMS4yNjU2MjUgMC44OTA2MjVxMC40MjE4NzUgMC41NjI1IDAuNTc4MTI1IDEuNWwtMS42MDkzNzUgMC4yMTg3NXEtMC4xMDkzNzUgLTAuNzUgLTAuNjQwNjI1IC0xLjE3MTg3NXEtMC41MTU2MjUgLTAuNDIxODc1IC0xLjQ2ODc1IC0wLjQyMTg3NXEtMS4xNDA2MjUgMCAtMS42MjUgMC4zNzVxLTAuNDY4NzUgMC4zNzUgLTAuNDY4NzUgMC44NzVxMCAwLjMxMjUgMC4xODc1IDAuNTc4MTI1cTAuMjAzMTI1IDAuMjY1NjI1IDAuNjQwNjI1IDAuNDM3NXEwLjIzNDM3NSAwLjA5Mzc1IDEuNDM3NSAwLjQyMTg3NXExLjc1IDAuNDUzMTI1IDIuNDM3NSAwLjc1cTAuNjg3NSAwLjI5Njg3NSAxLjA3ODEyNSAwLjg1OTM3NXEwLjM5MDYyNSAwLjU2MjUgMC4zOTA2MjUgMS40MDYyNXEwIDAuODI4MTI1IC0wLjQ4NDM3NSAxLjU0Njg3NXEtMC40Njg3NSAwLjcxODc1IC0xLjM3NSAxLjEyNXEtMC45MDYyNSAwLjM5MDYyNSAtMi4wNDY4NzUgMC4zOTA2MjVxLTEuODc1IDAgLTIuODc1IC0wLjc4MTI1cS0wLjk4NDM3NSAtMC43ODEyNSAtMS4yNSAtMi4zMjgxMjV6bTE2LjI5Njg3NSAxLjcwMzEyNXEtMC45MjE4NzUgMC43NjU2MjUgLTEuNzY1NjI1IDEuMDkzNzVxLTAuODI4MTI1IDAuMzEyNSAtMS43OTY4NzUgMC4zMTI1cS0xLjU5Mzc1IDAgLTIuNDUzMTI1IC0wLjc4MTI1cS0wLjg1OTM3NSAtMC43ODEyNSAtMC44NTkzNzUgLTEuOTg0Mzc1cTAgLTAuNzE4NzUgMC4zMjgxMjUgLTEuMjk2ODc1cTAuMzI4MTI1IC0wLjU5Mzc1IDAuODQzNzUgLTAuOTM3NXEwLjUzMTI1IC0wLjM1OTM3NSAxLjE4NzUgLTAuNTQ2ODc1cTAuNDY4NzUgLTAuMTI1IDEuNDUzMTI1IC0wLjI1cTEuOTg0Mzc1IC0wLjIzNDM3NSAyLjkyMTg3NSAtMC41NjI1cTAuMDE1NjI1IC0wLjM0Mzc1IDAuMDE1NjI1IC0wLjQyMTg3NXEwIC0xLjAgLTAuNDY4NzUgLTEuNDIxODc1cS0wLjYyNSAtMC41NDY4NzUgLTEuODc1IC0wLjU0Njg3NXEtMS4xNTYyNSAwIC0xLjcwMzEyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjgxMjUgMS40MjE4NzVsLTEuNjA5Mzc1IC0wLjIxODc1cTAuMjE4NzUgLTEuMDE1NjI1IDAuNzE4NzUgLTEuNjQwNjI1cTAuNSAtMC42NDA2MjUgMS40NTMxMjUgLTAuOTg0Mzc1cTAuOTUzMTI1IC0wLjM0Mzc1IDIuMTg3NSAtMC4zNDM3NXExLjI1IDAgMi4wMTU2MjUgMC4yOTY4NzVxMC43ODEyNSAwLjI4MTI1IDEuMTQwNjI1IDAuNzM0Mzc1cTAuMzc1IDAuNDM3NSAwLjUxNTYyNSAxLjEwOTM3NXEwLjA3ODEyNSAwLjQyMTg3NSAwLjA3ODEyNSAxLjUxNTYyNWwwIDIuMTg3NXEwIDIuMjgxMjUgMC4xMDkzNzUgMi44OTA2MjVxMC4xMDkzNzUgMC41OTM3NSAwLjQwNjI1IDEuMTU2MjVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzUgMS40NTMxMjUgMC40Mzc1cTAuOTM3NSAwIDEuNjcxODc1IC0wLjQwNjI1cTAuNzUgLTAuNDIxODc1IDEuMDkzNzUgLTEuMTQwNjI1cTAuMjY1NjI1IC0wLjU2MjUgMC4yNjU2MjUgLTEuNjQwNjI1bDAgLTAuNjA5Mzc1em00LjEyNTcwMiA4LjU3ODEyNWwtMC4xODc1IC0xLjUzMTI1cTAuNTQ2ODc1IDAuMTQwNjI1IDAuOTM3NSAwLjE0MDYyNXEwLjU0Njg3NSAwIDAuODc1IC0wLjE4NzVxMC4zMjgxMjUgLTAuMTcxODc1IDAuNTQ2ODc1IC0wLjVxMC4xNTYyNSAtMC4yNSAwLjUgLTEuMjE4NzVxMC4wNDY4NzUgLTAuMTQwNjI1IDAuMTQwNjI1IC0wLjQwNjI1bC0zLjY3MTg3NSAtOS42ODc1bDEuNzY1NjI1IDBsMi4wMTU2MjUgNS41OTM3NXEwLjM5MDYyNSAxLjA3ODEyNSAwLjcwMzEyNSAyLjI1cTAuMjgxMjUgLTEuMTI1IDAuNjcxODc1IC0yLjIwMzEyNWwyLjA3ODEyNSAtNS42NDA2MjVsMS42NDA2MjUgMGwtMy42ODc1IDkuODI4MTI1cS0wLjU5Mzc1IDEuNjA5Mzc1IC0wLjkyMTg3NSAyLjIwMzEyNXEtMC40Mzc1IDAuODEyNSAtMS4wIDEuMTg3NXEtMC41NjI1IDAuMzc1IC0xLjM0Mzc1IDAuMzc1cS0wLjQ4NDM3NSAwIC0xLjA2MjUgLTAuMjAzMTI1em0xMi41MzEyNSAwLjIwMzEyNXEtMS4zNTkzNzUgLTEuNzAzMTI1IC0yLjI5Njg3NSAtNC4wcS0wLjkzNzUgLTIuMjk2ODc1IC0wLjkzNzUgLTQuNzY1NjI1cTAgLTIuMTU2MjUgMC43MDMxMjUgLTQuMTQwNjI1cTAuODI4MTI1IC0yLjMxMjUgMi41MzEyNSAtNC41OTM3NWwxLjE3MTg3NSAwcS0xLjA5Mzc1IDEuODkwNjI1IC0xLjQ1MzEyNSAyLjcwMzEyNXEtMC41NDY4NzUgMS4yNSAtMC44NzUgMi42MjVxLTAuMzkwNjI1IDEuNzAzMTI1IC0wLjM5MDYyNSAzLjQyMTg3NXEwIDQuMzc1IDIuNzE4NzUgOC43NWwtMS4xNzE4NzUgMHptMi40MzE0MjcgLTYuODEyNWwxLjYyNSAtMC4yNXEwLjEyNSAwLjk2ODc1IDAuNzUgMS41cTAuNjI1IDAuNTE1NjI1IDEuNzUgMC41MTU2MjVxMS4xMjUgMCAxLjY3MTg3NSAtMC40NTMxMjVxMC41NDY4NzUgLTAuNDY4NzUgMC41NDY4NzUgLTEuMDkzNzVxMCAtMC41NDY4NzUgLTAuNDg0Mzc1IC0wLjg3NXEtMC4zMjgxMjUgLTAuMjE4NzUgLTEuNjcxODc1IC0wLjU0Njg3NXEtMS44MTI1IC0wLjQ2ODc1IC0yLjUxNTYyNSAtMC43OTY4NzVxLTAuNjg3NSAtMC4zMjgxMjUgLTEuMDQ2ODc1IC0wLjkwNjI1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzUgMC4zMjgxMjUgMS4yNjU2MjUgMC44OTA2MjVxMC40MjE4NzUgMC41NjI1IDAuNTc4MTI1IDEuNWwtMS42MDkzNzUgMC4yMTg3NXEtMC4xMDkzNzUgLTAuNzUgLTAuNjQwNjI1IC0xLjE3MTg3NXEtMC41MTU2MjUgLTAuNDIxODc1IC0xLjQ2ODc1IC0wLjQyMTg3NXEtMS4xNDA2MjUgMCAtMS42MjUgMC4zNzVxLTAuNDY4NzUgMC4zNzUgLTAuNDY4NzUgMC44NzVxMCAwLjMxMjUgMC4xODc1IDAuNTc4MTI1cTAuMjAzMTI1IDAuMjY1NjI1IDAuNjQwNjI1IDAuNDM3NXEwLjIzNDM3NSAwLjA5Mzc1IDEuNDM3NSAwLjQyMTg3NXExLjc1IDAuNDUzMTI1IDIuNDM3NSAwLjc1cTAuNjg3NSAwLjI5Njg3NSAxLjA3ODEyNSAwLjg1OTM3NXEwLjM5MDYyNSAwLjU2MjUgMC4zOTA2MjUgMS40MDYyNXEwIDAuODI4MTI1IC0wLjQ4NDM3NSAxLjU0Njg3NXEtMC40Njg3NSAwLjcxODc1IC0xLjM3NSAxLjEyNXEtMC45MDYyNSAwLjM5MDYyNSAtMi4wNDY4NzUgMC4zOTA2MjVxLTEuODc1IDAgLTIuODc1IC0wLjc4MTI1cS0wLjk4NDM3NSAtMC43ODEyNSAtMS4yNSAtMi4zMjgxMjV6bTE2LjYwOTM3NSAtMC4yMTg3NWwxLjY4NzUgMC4yMDMxMjVxLTAuNDA2MjUgMS40ODQzNzUgLTEuNDg0Mzc1IDIuMzEyNXEtMS4wNzgxMjUgMC44MTI1IC0yLjc2NTYyNSAwLjgxMjVxLTIuMTI1IDAgLTMuMzc1IC0xLjI5Njg3NXEtMS4yMzQzNzUgLTEuMzEyNSAtMS4yMzQzNzUgLTMuNjcxODc1cTAgLTIuNDUzMTI1IDEuMjUgLTMuNzk2ODc1cTEuMjY1NjI1IC0xLjM0Mzc1IDMuMjY1NjI1IC0xLjM0Mzc1cTEuOTM3NSAwIDMuMTU2MjUgMS4zMjgxMjVxMS4yMzQzNzUgMS4zMTI1IDEuMjM0Mzc1IDMuNzAzMTI1cTAgMC4xNTYyNSAwIDAuNDM3NWwtNy4yMTg3NSAwcTAuMDkzNzUgMS41OTM3NSAwLjkwNjI1IDIuNDUzMTI1cTAuODEyNSAwLjg0Mzc1IDIuMDE1NjI1IDAuODQzNzVxMC45MDYyNSAwIDEuNTQ2ODc1IC0wLjQ2ODc1cTAuNjQwNjI1IC0wLjQ4NDM3NSAxLjAxNTYyNSAtMS41MTU2MjV6bS01LjM5MDYyNSAtMi42NTYyNWw1LjQwNjI1IDBxLTAuMTA5Mzc1IC0xLjIxODc1IC0wLjYyNSAtMS44MjgxMjVxLTAuNzgxMjUgLTAuOTUzMTI1IC0yLjAzMTI1IC0wLjk1MzEyNXEtMS4xMjUgMCAtMS45MDYyNSAwLjc2NTYyNXEtMC43NjU2MjUgMC43NSAtMC44NDM3NSAyLjAxNTYyNXptOS41NjMyMzIgNS43NjU2MjVsMCAtMS44NzVsMS44NzUgMGwwIDEuODc1cTAgMS4wMzEyNSAtMC4zNzUgMS42NTYyNXEtMC4zNTkzNzUgMC42NDA2MjUgLTEuMTU2MjUgMC45ODQzNzVsLTAuNDUzMTI1IC0wLjcwMzEyNXEwLjUxNTYyNSAtMC4yMTg3NSAwLjc2NTYyNSAtMC42NzE4NzVxMC4yNSAtMC40Mzc1IDAuMjgxMjUgLTEuMjY1NjI1bC0wLjkzNzUgMHptOS45NDQ3MzMgMGwwIC05LjY3MTg3NWwxLjQ2ODc1IDBsMCAxLjM3NXExLjA2MjUgLTEuNTkzNzUgMy4wNzgxMjUgLTEuNTkzNzVxMC44NzUgMCAxLjYwOTM3NSAwLjMxMjVxMC43MzQzNzUgMC4zMTI1IDEuMDkzNzUgMC44MjgxMjVxMC4zNzUgMC41IDAuNTE1NjI1IDEuMjAzMTI1cTAuMDkzNzUgMC40NTMxMjUgMC4wOTM3NSAxLjU5Mzc1bDAgNS45NTMxMjVsLTEuNjQwNjI1IDBsMCAtNS44OTA2MjVxMCAtMS4wIC0wLjIwMzEyNSAtMS40ODQzNzVxLTAuMTg3NSAtMC41IC0wLjY3MTg3NSAtMC43OTY4NzVxLTAuNDg0Mzc1IC0wLjI5Njg3NSAtMS4xNDA2MjUgLTAuMjk2ODc1cS0xLjA0Njg3NSAwIC0xLjgxMjUgMC42NzE4NzVxLTAuNzUgMC42NTYyNSAtMC43NSAyLjUxNTYyNWwwIDUuMjgxMjVsLTEuNjQwNjI1IDB6bTI0LjE4NDAyMSAtNy44NTkzNzVsLTguODI4MTI1IDBsMCAtMS41MTU2MjVsOC44MjgxMjUgMGwwIDEuNTE1NjI1em0wIDQuMDYyNWwtOC44MjgxMjUgMGwwIC0xLjUzMTI1bDguODI4MTI1IDBsMCAxLjUzMTI1em0xNS42MDk0OTcgMi4yMTg3NWwwIDEuNTc4MTI1bC04LjgyODEyNSAwcS0wLjAxNTYyNSAtMC41OTM3NSAwLjE4NzUgLTEuMTQwNjI1cTAuMzQzNzUgLTAuOTA2MjUgMS4wNzgxMjUgLTEuNzgxMjVxMC43NSAtMC44NzUgMi4xNTYyNSAtMi4wMTU2MjVxMi4xNzE4NzUgLTEuNzgxMjUgMi45Mzc1IC0yLjgyODEyNXEwLjc2NTYyNSAtMS4wNDY4NzUgMC43NjU2MjUgLTEuOTY4NzVxMCAtMC45ODQzNzUgLTAuNzAzMTI1IC0xLjY0MDYyNXEtMC42ODc1IC0wLjY3MTg3NSAtMS44MTI1IC0wLjY3MTg3NXEtMS4xODc1IDAgLTEuOTA2MjUgMC43MTg3NXEtMC43MDMxMjUgMC43MDMxMjUgLTAuNzAzMTI1IDEuOTUzMTI1bC0xLjY4NzUgLTAuMTcxODc1cTAuMTcxODc1IC0xLjg5MDYyNSAxLjI5Njg3NSAtMi44NzVxMS4xNDA2MjUgLTAuOTg0Mzc1IDMuMDMxMjUgLTAuOTg0Mzc1cTEuOTIxODc1IDAgMy4wNDY4NzUgMS4wNjI1cTEuMTI1IDEuMDYyNSAxLjEyNSAyLjY0MDYyNXEwIDAuNzk2ODc1IC0wLjMyODEyNSAxLjU3ODEyNXEtMC4zMjgxMjUgMC43ODEyNSAtMS4wOTM3NSAxLjY0MDYyNXEtMC43NSAwLjg0Mzc1IC0yLjUzMTI1IDIuMzQzNzVxLTEuNDY4NzUgMS4yMzQzNzUgLTEuODkwNjI1IDEuNjg3NXEtMC40MjE4NzUgMC40Mzc1IC0wLjY4NzUgMC44NzVsNi41NDY4NzUgMHptMy4yOTc2MDc0IDUuNWwtMS4xODc1IDBxMi43MzQzNzUgLTQuMzc1IDIuNzM0Mzc1IC04Ljc1cTAgLTEuNzE4NzUgLTAuMzkwNjI1IC0zLjM5MDYyNXEtMC4zMTI1IC0xLjM3NSAtMC44NzUgLTIuNjI1cS0wLjM1OTM3NSAtMC44MjgxMjUgLTEuNDY4NzUgLTIuNzM0Mzc1bDEuMTg3NSAwcTEuNzAzMTI1IDIuMjgxMjUgMi41MzEyNSA0LjU5Mzc1cTAuNjg3NSAxLjk4NDM3NSAwLjY4NzUgNC4xNDA2MjVxMCAyLjQ2ODc1IC0wLjkzNzUgNC43NjU2MjVxLTAuOTM3NSAyLjI5Njg3NSAtMi4yODEyNSA0LjB6IiBmaWxsLXJ1bGU9Im5vbnplcm8iLz48cGF0aCBmaWxsPSIjNjc0ZWE3IiBkPSJtMjQ0LjU1NzM3IDU2OS4wNjg1cS0wLjkyMTg3NSAwLjc2NTYyNSAtMS43NjU2MjUgMS4wOTM3NXEtMC44MjgxMjUgMC4zMTI1IC0xLjc5Njg3NSAwLjMxMjVxLTEuNTkzNzUgMCAtMi40NTMxMjUgLTAuNzgxMjVxLTAuODU5Mzc1IC0wLjc4MTI1IC0wLjg1OTM3NSAtMS45ODQzNzVxMCAtMC43MTg3NSAwLjMyODEyNSAtMS4yOTY4NzVxMC4zMjgxMjUgLTAuNTkzNzUgMC44NDM3NSAtMC45Mzc1cTAuNTMxMjUgLTAuMzU5Mzc1IDEuMTg3NSAtMC41NDY4NzVxMC40Njg3NSAtMC4xMjUgMS40NTMxMjUgLTAuMjVxMS45ODQzNzUgLTAuMjM0Mzc1IDIuOTIxODc1IC0wLjU2MjVxMC4wMTU2MjUgLTAuMzQzNzUgMC4wMTU2MjUgLTAuNDIxODc1cTAgLTEuMCAtMC40Njg3NSAtMS40MjE4NzVxLTAuNjI1IC0wLjU0Njg3NSAtMS44NzUgLTAuNTQ2ODc1cS0xLjE1NjI1IDAgLTEuNzAzMTI1IDAuNDA2MjVxLTAuNTQ2ODc1IDAuNDA2MjUgLTAuODEyNSAxLjQyMTg3NWwtMS42MDkzNzUgLTAuMjE4NzVxMC4yMTg3NSAtMS4wMTU2MjUgMC43MTg3NSAtMS42NDA2MjVxMC41IC0wLjY0MDYyNSAxLjQ1MzEyNSAtMC45ODQzNzVxMC45NTMxMjUgLTAuMzQzNzUgMi4xODc1IC0wLjM0Mzc1cTEuMjUgMCAyLjAxNTYyNSAwLjI5Njg3NXEwLjc4MTI1IDAuMjgxMjUgMS4xNDA2MjUgMC43MzQzNzVxMC4zNzUgMC40Mzc1IDAuNTE1NjI1IDEuMTA5Mzc1cTAuMDc4MTI1IDAuNDIxODc1IDAuMDc4MTI1IDEuNTE1NjI1bDAgMi4xODc1cTAgMi4yODEyNSAwLjEwOTM3NSAyLjg5MDYyNXEwLjEwOTM3NSAwLjU5Mzc1IDAuNDA2MjUgMS4xNTYyNWwtMS43MDMxMjUgMHEtMC4yNjU2MjUgLTAuNTE1NjI1IC0wLjMyODEyNSAtMS4xODc1em0tMC4xNDA2MjUgLTMuNjcxODc1cS0wLjg5MDYyNSAwLjM3NSAtMi42NzE4NzUgMC42MjVxLTEuMDE1NjI1IDAuMTQwNjI1IC0xLjQzNzUgMC4zMjgxMjVxLTAuNDIxODc1IDAuMTg3NSAtMC42NTYyNSAwLjUzMTI1cS0wLjIxODc1IDAuMzQzNzUgLTAuMjE4NzUgMC43ODEyNXEwIDAuNjU2MjUgMC41IDEuMDkzNzVxMC41IDAuNDM3NSAxLjQ1MzEyNSAwLjQzNzVxMC45Mzc1IDAgMS42NzE4NzUgLTAuNDA2MjVxMC43NSAtMC40MjE4NzUgMS4wOTM3NSAtMS4xNDA2MjVxMC4yNjU2MjUgLTAuNTYyNSAwLjI2NTYyNSAtMS42NDA2MjVsMCAtMC42MDkzNzV6bTMuNTQ3NTkyMiAxLjk2ODc1bDEuNjI1IC0wLjI1cTAuMTI1IDAuOTY4NzUgMC43NSAxLjVxMC42MjUgMC41MTU2MjUgMS43NSAwLjUxNTYyNXExLjEyNSAwIDEuNjcxODc1IC0wLjQ1MzEyNXEwLjU0Njg3NSAtMC40Njg3NSAwLjU0Njg3NSAtMS4wOTM3NXEwIC0wLjU0Njg3NSAtMC40ODQzNzUgLTAuODc1cS0wLjMyODEyNSAtMC4yMTg3NSAtMS42NzE4NzUgLTAuNTQ2ODc1cS0xLjgxMjUgLTAuNDY4NzUgLTIuNTE1NjI1IC0wLjc5Njg3NXEtMC42ODc1IC0wLjMyODEyNSAtMS4wNDY4NzUgLTAuOTA2MjVxLTAuMzU5Mzc1IC0wLjU5Mzc1IC0wLjM1OTM3NSAtMS4zMTI1cTAgLTAuNjQwNjI1IDAuMjk2ODc1IC0xLjE4NzVxMC4yOTY4NzUgLTAuNTYyNSAwLjgxMjUgLTAuOTIxODc1cTAuMzc1IC0wLjI4MTI1IDEuMDMxMjUgLTAuNDY4NzVxMC42NzE4NzUgLTAuMjAzMTI1IDEuNDIxODc1IC0wLjIwMzEyNXExLjE0MDYyNSAwIDIuMCAwLjMyODEyNXEwLjg1OTM3NSAwLjMyODEyNSAxLjI2NTYyNSAwLjg5MDYyNXEwLjQyMTg3NSAwLjU2MjUgMC41NzgxMjUgMS41bC0xLjYwOTM3NSAwLjIxODc1cS0wLjEwOTM3NSAtMC43NSAtMC42NDA2MjUgLTEuMTcxODc1cS0wLjUxNTYyNSAtMC40MjE4NzUgLTEuNDY4NzUgLTAuNDIxODc1cS0xLjE0MDYyNSAwIC0xLjYyNSAwLjM3NXEtMC40Njg3NSAwLjM3NSAtMC40Njg3NSAwLjg3NXEwIDAuMzEyNSAwLjE4NzUgMC41NzgxMjVxMC4yMDMxMjUgMC4yNjU2MjUgMC42NDA2MjUgMC40Mzc1cTAuMjM0Mzc1IDAuMDkzNzUgMS40Mzc1IDAuNDIxODc1cTEuNzUgMC40NTMxMjUgMi40Mzc1IDAuNzVxMC42ODc1IDAuMjk2ODc1IDEuMDc4MTI1IDAuODU5Mzc1cTAuMzkwNjI1IDAuNTYyNSAwLjM5MDYyNSAxLjQwNjI1cTAgMC44MjgxMjUgLTAuNDg0Mzc1IDEuNTQ2ODc1cS0wLjQ2ODc1IDAuNzE4NzUgLTEuMzc1IDEuMTI1cS0wLjkwNjI1IDAuMzkwNjI1IC0yLjA0Njg3NSAwLjM5MDYyNXEtMS44NzUgMCAtMi44NzUgLTAuNzgxMjVxLTAuOTg0Mzc1IC0wLjc4MTI1IC0xLjI1IC0yLjMyODEyNXptOS4zMjgxNCAwbDEuNjI1IC0wLjI1cTAuMTI1IDAuOTY4NzUgMC43NSAxLjVxMC42MjUgMC41MTU2MjUgMS43NSAwLjUxNTYyNXExLjEyNSAwIDEuNjcxODc1IC0wLjQ1MzEyNXEwLjU0Njg3NSAtMC40Njg3NSAwLjU0Njg3NSAtMS4wOTM3NXEwIC0wLjU0Njg3NSAtMC40ODQzNzUgLTAuODc1cS0wLjMyODEyNSAtMC4yMTg3NSAtMS42NzE4NzUgLTAuNTQ2ODc1cS0xLjgxMjUgLTAuNDY4NzUgLTIuNTE1NjI1IC0wLjc5Njg3NXEtMC42ODc1IC0wLjMyODEyNSAtMS4wNDY4NzUgLTAuOTA2MjVxLTAuMzU5Mzc1IC0wLjU5Mzc1IC0wLjM1OTM3NSAtMS4zMTI1cTAgLTAuNjQwNjI1IDAuMjk2ODc1IC0xLjE4NzVxMC4yOTY4NzUgLTAuNTYyNSAwLjgxMjUgLTAuOTIxODc1cTAuMzc1IC0wLjI4MTI1IDEuMDMxMjUgLTAuNDY4NzVxMC42NzE4NzUgLTAuMjAzMTI1IDEuNDIxODc1IC0wLjIwMzEyNXExLjE0MDYyNSAwIDIuMCAwLjMyODEyNXEwLjg1OTM3NSAwLjMyODEyNSAxLjI2NTYyNSAwLjg5MDYyNXEwLjQyMTg3NSAwLjU2MjUgMC41NzgxMjUgMS41bC0xLjYwOTM3NSAwLjIxODc1cS0wLjEwOTM3NSAtMC43NSAtMC42NDA2MjUgLTEuMTcxODc1cS0wLjUxNTYyNSAtMC40MjE4NzUgLTEuNDY4NzUgLTAuNDIxODc1cS0xLjE0MDYyNSAwIC0xLjYyNSAwLjM3NXEtMC40Njg3NSAwLjM3NSAtMC40Njg3NSAwLjg3NXEwIDAuMzEyNSAwLjE4NzUgMC41NzgxMjVxMC4yMDMxMjUgMC4yNjU2MjUgMC42NDA2MjUgMC40Mzc1cTAuMjM0Mzc1IDAuMDkzNzUgMS40Mzc1IDAuNDIxODc1cTEuNzUgMC40NTMxMjUgMi40Mzc1IDAuNzVxMC42ODc1IDAuMjk2ODc1IDEuMDc4MTI1IDAuODU5Mzc1cTAuMzkwNjI1IDAuNTYyNSAwLjM5MDYyNSAxLjQwNjI1cTAgMC44MjgxMjUgLTAuNDg0Mzc1IDEuNTQ2ODc1cS0wLjQ2ODc1IDAuNzE4NzUgLTEuMzc1IDEuMTI1cS0wLjkwNjI1IDAuMzkwNjI1IC0yLjA0Njg3NSAwLjM5MDYyNXEtMS44NzUgMCAtMi44NzUgLTAuNzgxMjVxLTAuOTg0Mzc1IC0wLjc4MTI1IC0xLjI1IC0yLjMyODEyNXptMTYuMjk2ODc1IDEuNzAzMTI1cS0wLjkyMTg3NSAwLjc2NTYyNSAtMS43NjU2MjUgMS4wOTM3NXEtMC44MjgxMjUgMC4zMTI1IC0xLjc5Njg3NSAwLjMxMjVxLTEuNTkzNzUgMCAtMi40NTMxMjUgLTAuNzgxMjVxLTAuODU5Mzc1IC0wLjc4MTI1IC0wLjg1OTM3NSAtMS45ODQzNzVxMCAtMC43MTg3NSAwLjMyODEyNSAtMS4yOTY4NzVxMC4zMjgxMjUgLTAuNTkzNzUgMC44NDM3NSAtMC45Mzc1cTAuNTMxMjUgLTAuMzU5Mzc1IDEuMTg3NSAtMC41NDY4NzVxMC40Njg3NSAtMC4xMjUgMS40NTMxMjUgLTAuMjVxMS45ODQzNzUgLTAuMjM0Mzc1IDIuOTIxODc1IC0wLjU2MjVxMC4wMTU2MjUgLTAuMzQzNzUgMC4wMTU2MjUgLTAuNDIxODc1cTAgLTEuMCAtMC40Njg3NSAtMS40MjE4NzVxLTAuNjI1IC0wLjU0Njg3NSAtMS44NzUgLTAuNTQ2ODc1cS0xLjE1NjI1IDAgLTEuNzAzMTI1IDAuNDA2MjVxLTAuNTQ2ODc1IDAuNDA2MjUgLTAuODEyNSAxLjQyMTg3NWwtMS42MDkzNzUgLTAuMjE4NzVxMC4yMTg3NSAtMS4wMTU2MjUgMC43MTg3NSAtMS42NDA2MjVxMC41IC0wLjY0MDYyNSAxLjQ1MzEyNSAtMC45ODQzNzVxMC45NTMxMjUgLTAuMzQzNzUgMi4xODc1IC0wLjM0Mzc1cTEuMjUgMCAyLjAxNTYyNSAwLjI5Njg3NXEwLjc4MTI1IDAuMjgxMjUgMS4xNDA2MjUgMC43MzQzNzVxMC4zNzUgMC40Mzc1IDAuNTE1NjI1IDEuMTA5Mzc1cTAuMDc4MTI1IDAuNDIxODc1IDAuMDc4MTI1IDEuNTE1NjI1bDAgMi4xODc1cTAgMi4yODEyNSAwLjEwOTM3NSAyLjg5MDYyNXEwLjEwOTM3NSAwLjU5Mzc1IDAuNDA2MjUgMS4xNTYyNWwtMS43MDMxMjUgMHEtMC4yNjU2MjUgLTAuNTE1NjI1IC0wLjMyODEyNSAtMS4xODc1em0tMC4xNDA2MjUgLTMuNjcxODc1cS0wLjg5MDYyNSAwLjM3NSAtMi42NzE4NzUgMC42MjVxLTEuMDE1NjI1IDAuMTQwNjI1IC0xLjQzNzUgMC4zMjgxMjVxLTAuNDIxODc1IDAuMTg3NSAtMC42NTYyNSAwLjUzMTI1cS0wLjIxODc1IDAuMzQzNzUgLTAuMjE4NzUgMC43ODEyNXEwIDAuNjU2MjUgMC41IDEuMDkzNzVxMC41IDAuNDM3NSAxLjQ1MzEyNSAwLjQzNzVxMC45Mzc1IDAgMS42NzE4NzUgLTAuNDA2MjVxMC43NSAtMC40MjE4NzUgMS4wOTM3NSAtMS4xNDA2MjVxMC4yNjU2MjUgLTAuNTYyNSAwLjI2NTYyNSAtMS42NDA2MjVsMCAtMC42MDkzNzV6bTQuMTI1NzAyIDguNTc4MTI1bC0wLjE4NzUgLTEuNTMxMjVxMC41NDY4NzUgMC4xNDA2MjUgMC45Mzc1IDAuMTQwNjI1cTAuNTQ2ODc1IDAgMC44NzUgLTAuMTg3NXEwLjMyODEyNSAtMC4xNzE4NzUgMC41NDY4NzUgLTAuNXEwLjE1NjI1IC0wLjI1IDAuNSAtMS4yMTg3NXEwLjA0Njg3NSAtMC4xNDA2MjUgMC4xNDA2MjUgLTAuNDA2MjVsLTMuNjcxODc1IC05LjY4NzVsMS43NjU2MjUgMGwyLjAxNTYyNSA1LjU5Mzc1cTAuMzkwNjI1IDEuMDc4MTI1IDAuNzAzMTI1IDIuMjVxMC4yODEyNSAtMS4xMjUgMC42NzE4NzUgLTIuMjAzMTI1bDIuMDc4MTI1IC01LjY0MDYyNWwxLjY0MDYyNSAwbC0zLjY4NzUgOS44MjgxMjVxLTAuNTkzNzUgMS42MDkzNzUgLTAuOTIxODc1IDIuMjAzMTI1cS0wLjQzNzUgMC44MTI1IC0xLjAgMS4xODc1cS0wLjU2MjUgMC4zNzUgLTEuMzQzNzUgMC4zNzVxLTAuNDg0Mzc1IDAgLTEuMDYyNSAtMC4yMDMxMjV6bTEyLjUzMTI1IDAuMjAzMTI1cS0xLjM1OTM3NSAtMS43MDMxMjUgLTIuMjk2ODc1IC00LjBxLTAuOTM3NSAtMi4yOTY4NzUgLTAuOTM3NSAtNC43NjU2MjVxMCAtMi4xNTYyNSAwLjcwMzEyNSAtNC4xNDA2MjVxMC44MjgxMjUgLTIuMzEyNSAyLjUzMTI1IC00LjU5Mzc1bDEuMTcxODc1IDBxLTEuMDkzNzUgMS44OTA2MjUgLTEuNDUzMTI1IDIuNzAzMTI1cS0wLjU0Njg3NSAxLjI1IC0wLjg3NSAyLjYyNXEtMC4zOTA2MjUgMS43MDMxMjUgLTAuMzkwNjI1IDMuNDIxODc1cTAgNC4zNzUgMi43MTg3NSA4Ljc1bC0xLjE3MTg3NSAwem0yLjQzMTQyNyAtNi44MTI1bDEuNjI1IC0wLjI1cTAuMTI1IDAuOTY4NzUgMC43NSAxLjVxMC42MjUgMC41MTU2MjUgMS43NSAwLjUxNTYyNXExLjEyNSAwIDEuNjcxODc1IC0wLjQ1MzEyNXEwLjU0Njg3NSAtMC40Njg3NSAwLjU0Njg3NSAtMS4wOTM3NXEwIC0wLjU0Njg3NSAtMC40ODQzNzUgLTAuODc1cS0wLjMyODEyNSAtMC4yMTg3NSAtMS42NzE4NzUgLTAuNTQ2ODc1cS0xLjgxMjUgLTAuNDY4NzUgLTIuNTE1NjI1IC0wLjc5Njg3NXEtMC42ODc1IC0wLjMyODEyNSAtMS4wNDY4NzUgLTAuOTA2MjVxLTAuMzU5Mzc1IC0wLjU5Mzc1IC0wLjM1OTM3NSAtMS4zMTI1cTAgLTAuNjQwNjI1IDAuMjk2ODc1IC0xLjE4NzVxMC4yOTY4NzUgLTAuNTYyNSAwLjgxMjUgLTAuOTIxODc1cTAuMzc1IC0wLjI4MTI1IDEuMDMxMjUgLTAuNDY4NzVxMC42NzE4NzUgLTAuMjAzMTI1IDEuNDIxODc1IC0wLjIwMzEyNXExLjE0MDYyNSAwIDIuMCAwLjMyODEyNXEwLjg1OTM3NSAwLjMyODEyNSAxLjI2NTYyNSAwLjg5MDYyNXEwLjQyMTg3NSAwLjU2MjUgMC41NzgxMjUgMS41bC0xLjYwOTM3NSAwLjIxODc1cS0wLjEwOTM3NSAtMC43NSAtMC42NDA2MjUgLTEuMTcxODc1cS0wLjUxNTYyNSAtMC40MjE4NzUgLTEuNDY4NzUgLTAuNDIxODc1cS0xLjE0MDYyNSAwIC0xLjYyNSAwLjM3NXEtMC40Njg3NSAwLjM3NSAtMC40Njg3NSAwLjg3NXEwIDAuMzEyNSAwLjE4NzUgMC41NzgxMjVxMC4yMDMxMjUgMC4yNjU2MjUgMC42NDA2MjUgMC40Mzc1cTAuMjM0Mzc1IDAuMDkzNzUgMS40Mzc1IDAuNDIxODc1cTEuNzUgMC40NTMxMjUgMi40Mzc1IDAuNzVxMC42ODc1IDAuMjk2ODc1IDEuMDc4MTI1IDAuODU5Mzc1cTAuMzkwNjI1IDAuNTYyNSAwLjM5MDYyNSAxLjQwNjI1cTAgMC44MjgxMjUgLTAuNDg0Mzc1IDEuNTQ2ODc1cS0wLjQ2ODc1IDAuNzE4NzUgLTEuMzc1IDEuMTI1cS0wLjkwNjI1IDAuMzkwNjI1IC0yLjA0Njg3NSAwLjM5MDYyNXEtMS44NzUgMCAtMi44NzUgLTAuNzgxMjVxLTAuOTg0Mzc1IC0wLjc4MTI1IC0xLjI1IC0yLjMyODEyNXptMTYuMzEyNSAyLjg5MDYyNWwwIC0xLjQyMTg3NXEtMS4xMjUgMS42NDA2MjUgLTMuMDYyNSAxLjY0MDYyNXEtMC44NTkzNzUgMCAtMS42MDkzNzUgLTAuMzI4MTI1cS0wLjczNDM3NSAtMC4zMjgxMjUgLTEuMDkzNzUgLTAuODI4MTI1cS0wLjM1OTM3NSAtMC41IC0wLjUgLTEuMjE4NzVxLTAuMTA5Mzc1IC0wLjQ2ODc1IC0wLjEwOTM3NSAtMS41MzEyNWwwIC01Ljk4NDM3NWwxLjY0MDYyNSAwbDAgNS4zNTkzNzVxMCAxLjI4MTI1IDAuMTA5Mzc1IDEuNzM0Mzc1cTAuMTU2MjUgMC42NDA2MjUgMC42NTYyNSAxLjAxNTYyNXEwLjUgMC4zNzUgMS4yMzQzNzUgMC4zNzVxMC43MzQzNzUgMCAxLjM3NSAtMC4zNzVxMC42NTYyNSAtMC4zOTA2MjUgMC45MjE4NzUgLTEuMDMxMjVxMC4yNjU2MjUgLTAuNjU2MjUgMC4yNjU2MjUgLTEuODkwNjI1bDAgLTUuMTg3NWwxLjY0MDYyNSAwbDAgOS42NzE4NzVsLTEuNDY4NzUgMHptNS41NDc2MDc0IDBsLTEuNTE1NjI1IDBsMCAtMTMuMzU5Mzc1bDEuNjQwNjI1IDBsMCA0Ljc2NTYyNXExLjA0Njg3NSAtMS4yOTY4NzUgMi42NTYyNSAtMS4yOTY4NzVxMC44OTA2MjUgMCAxLjY4NzUgMC4zNTkzNzVxMC43OTY4NzUgMC4zNTkzNzUgMS4zMTI1IDEuMDE1NjI1cTAuNTE1NjI1IDAuNjQwNjI1IDAuNzk2ODc1IDEuNTYyNXEwLjI5Njg3NSAwLjkyMTg3NSAwLjI5Njg3NSAxLjk2ODc1cTAgMi40ODQzNzUgLTEuMjM0Mzc1IDMuODQzNzVxLTEuMjE4NzUgMS4zNTkzNzUgLTIuOTUzMTI1IDEuMzU5Mzc1cS0xLjcwMzEyNSAwIC0yLjY4NzUgLTEuNDM3NWwwIDEuMjE4NzV6bS0wLjAxNTYyNSAtNC45MDYyNXEwIDEuNzM0Mzc1IDAuNDg0Mzc1IDIuNTE1NjI1cTAuNzY1NjI1IDEuMjY1NjI1IDIuMDkzNzUgMS4yNjU2MjVxMS4wNzgxMjUgMCAxLjg1OTM3NSAtMC45Mzc1cTAuNzgxMjUgLTAuOTM3NSAwLjc4MTI1IC0yLjc4MTI1cTAgLTEuODkwNjI1IC0wLjc1IC0yLjc5Njg3NXEtMC43NSAtMC45MDYyNSAtMS44MjgxMjUgLTAuOTA2MjVxLTEuMDYyNSAwIC0xLjg1OTM3NSAwLjkzNzVxLTAuNzgxMjUgMC45Mzc1IC0wLjc4MTI1IDIuNzAzMTI1em04LjIzNTA3NyAyLjAxNTYyNWwxLjYyNSAtMC4yNXEwLjEyNSAwLjk2ODc1IDAuNzUgMS41cTAuNjI1IDAuNTE1NjI1IDEuNzUgMC41MTU2MjVxMS4xMjUgMCAxLjY3MTg3NSAtMC40NTMxMjVxMC41NDY4NzUgLTAuNDY4NzUgMC41NDY4NzUgLTEuMDkzNzVxMCAtMC41NDY4NzUgLTAuNDg0Mzc1IC0wLjg3NXEtMC4zMjgxMjUgLTAuMjE4NzUgLTEuNjcxODc1IC0wLjU0Njg3NXEtMS44MTI1IC0wLjQ2ODc1IC0yLjUxNTYyNSAtMC43OTY4NzVxLTAuNjg3NSAtMC4zMjgxMjUgLTEuMDQ2ODc1IC0wLjkwNjI1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzUgMC4zMjgxMjUgMS4yNjU2MjUgMC44OTA2MjVxMC40MjE4NzUgMC41NjI1IDAuNTc4MTI1IDEuNWwtMS42MDkzNzUgMC4yMTg3NXEtMC4xMDkzNzUgLTAuNzUgLTAuNjQwNjI1IC0xLjE3MTg3NXEtMC41MTU2MjUgLTAuNDIxODc1IC0xLjQ2ODc1IC0wLjQyMTg3NXEtMS4xNDA2MjUgMCAtMS42MjUgMC4zNzVxLTAuNDY4NzUgMC4zNzUgLTAuNDY4NzUgMC44NzVxMCAwLjMxMjUgMC4xODc1IDAuNTc4MTI1cTAuMjAzMTI1IDAuMjY1NjI1IDAuNjQwNjI1IDAuNDM3NXEwLjIzNDM3NSAwLjA5Mzc1IDEuNDM3NSAwLjQyMTg3NXExLjc1IDAuNDUzMTI1IDIuNDM3NSAwLjc1cTAuNjg3NSAwLjI5Njg3NSAxLjA3ODEyNSAwLjg1OTM3NXEwLjM5MDYyNSAwLjU2MjUgMC4zOTA2MjUgMS40MDYyNXEwIDAuODI4MTI1IC0wLjQ4NDM3NSAxLjU0Njg3NXEtMC40Njg3NSAwLjcxODc1IC0xLjM3NSAxLjEyNXEtMC45MDYyNSAwLjM5MDYyNSAtMi4wNDY4NzUgMC4zOTA2MjVxLTEuODc1IDAgLTIuODc1IC0wLjc4MTI1cS0wLjk4NDM3NSAtMC43ODEyNSAtMS4yNSAtMi4zMjgxMjV6bTE2LjYwOTM3NSAtMC4yMTg3NWwxLjY4NzUgMC4yMDMxMjVxLTAuNDA2MjUgMS40ODQzNzUgLTEuNDg0Mzc1IDIuMzEyNXEtMS4wNzgxMjUgMC44MTI1IC0yLjc2NTYyNSAwLjgxMjVxLTIuMTI1IDAgLTMuMzc1IC0xLjI5Njg3NXEtMS4yMzQzNzUgLTEuMzEyNSAtMS4yMzQzNzUgLTMuNjcxODc1cTAgLTIuNDUzMTI1IDEuMjUgLTMuNzk2ODc1cTEuMjY1NjI1IC0xLjM0Mzc1IDMuMjY1NjI1IC0xLjM0Mzc1cTEuOTM3NSAwIDMuMTU2MjUgMS4zMjgxMjVxMS4yMzQzNzUgMS4zMTI1IDEuMjM0Mzc1IDMuNzAzMTI1cTAgMC4xNTYyNSAwIDAuNDM3NWwtNy4yMTg3NSAwcTAuMDkzNzUgMS41OTM3NSAwLjkwNjI1IDIuNDUzMTI1cTAuODEyNSAwLjg0Mzc1IDIuMDE1NjI1IDAuODQzNzVxMC45MDYyNSAwIDEuNTQ2ODc1IC0wLjQ2ODc1cTAuNjQwNjI1IC0wLjQ4NDM3NSAxLjAxNTYyNSAtMS41MTU2MjV6bS01LjM5MDYyNSAtMi42NTYyNWw1LjQwNjI1IDBxLTAuMTA5Mzc1IC0xLjIxODc1IC0wLjYyNSAtMS44MjgxMjVxLTAuNzgxMjUgLTAuOTUzMTI1IC0yLjAzMTI1IC0wLjk1MzEyNXEtMS4xMjUgMCAtMS45MDYyNSAwLjc2NTYyNXEtMC43NjU2MjUgMC43NSAtMC44NDM3NSAyLjAxNTYyNXptMTIuNzE5NDgyIDQuMjk2ODc1bDAuMjM0Mzc1IDEuNDUzMTI1cS0wLjY4NzUgMC4xNDA2MjUgLTEuMjM0Mzc1IDAuMTQwNjI1cS0wLjg5MDYyNSAwIC0xLjM5MDYyNSAtMC4yODEyNXEtMC40ODQzNzUgLTAuMjgxMjUgLTAuNjg3NSAtMC43MzQzNzVxLTAuMjAzMTI1IC0wLjQ2ODc1IC0wLjIwMzEyNSAtMS45Mzc1bDAgLTUuNTc4MTI1bC0xLjIwMzEyNSAwbDAgLTEuMjY1NjI1bDEuMjAzMTI1IDBsMCAtMi4zOTA2MjVsMS42MjUgLTAuOTg0Mzc1bDAgMy4zNzVsMS42NTYyNSAwbDAgMS4yNjU2MjVsLTEuNjU2MjUgMGwwIDUuNjcxODc1cTAgMC42ODc1IDAuMDc4MTI1IDAuODkwNjI1cTAuMDkzNzUgMC4yMDMxMjUgMC4yODEyNSAwLjMyODEyNXEwLjIwMzEyNSAwLjEwOTM3NSAwLjU3ODEyNSAwLjEwOTM3NXEwLjI2NTYyNSAwIDAuNzE4NzUgLTAuMDYyNXptMS43MzAxNjM2IDEuNDY4NzVsMCAtMTMuMzU5Mzc1bDUuMDE1NjI1IDBxMS41MzEyNSAwIDIuNDUzMTI1IDAuNDA2MjVxMC45MjE4NzUgMC40MDYyNSAxLjQzNzUgMS4yNXEwLjUzMTI1IDAuODQzNzUgMC41MzEyNSAxLjc2NTYyNXEwIDAuODU5Mzc1IC0wLjQ2ODc1IDEuNjI1cS0wLjQ1MzEyNSAwLjc1IC0xLjM5MDYyNSAxLjIwMzEyNXExLjIwMzEyNSAwLjM1OTM3NSAxLjg1OTM3NSAxLjIxODc1cTAuNjU2MjUgMC44NTkzNzUgMC42NTYyNSAyLjAxNTYyNXEwIDAuOTM3NSAtMC40MDYyNSAxLjc1cS0wLjM5MDYyNSAwLjc5Njg3NSAtMC45ODQzNzUgMS4yMzQzNzVxLTAuNTc4MTI1IDAuNDM3NSAtMS40NTMxMjUgMC42NzE4NzVxLTAuODc1IDAuMjE4NzUgLTIuMTU2MjUgMC4yMTg3NWwtNS4wOTM3NSAwem0xLjc4MTI1IC03Ljc1bDIuODc1IDBxMS4xODc1IDAgMS42ODc1IC0wLjE0MDYyNXEwLjY3MTg3NSAtMC4yMDMxMjUgMS4wMTU2MjUgLTAuNjcxODc1cTAuMzQzNzUgLTAuNDY4NzUgMC4zNDM3NSAtMS4xNzE4NzVxMCAtMC42NTYyNSAtMC4zMjgxMjUgLTEuMTU2MjVxLTAuMzEyNSAtMC41MTU2MjUgLTAuOTA2MjUgLTAuNzAzMTI1cS0wLjU5Mzc1IC0wLjE4NzUgLTIuMDMxMjUgLTAuMTg3NWwtMi42NTYyNSAwbDAgNC4wMzEyNXptMCA2LjE3MTg3NWwzLjMxMjUgMHEwLjg1OTM3NSAwIDEuMjAzMTI1IC0wLjA2MjVxMC42MDkzNzUgLTAuMTA5Mzc1IDEuMDE1NjI1IC0wLjM1OTM3NXEwLjQyMTg3NSAtMC4yNjU2MjUgMC42ODc1IC0wLjc1cTAuMjY1NjI1IC0wLjQ4NDM3NSAwLjI2NTYyNSAtMS4xMjVxMCAtMC43NSAtMC4zOTA2MjUgLTEuMjk2ODc1cS0wLjM3NSAtMC41NDY4NzUgLTEuMDYyNSAtMC43NjU2MjVxLTAuNjcxODc1IC0wLjIzNDM3NSAtMS45NTMxMjUgLTAuMjM0Mzc1bC0zLjA3ODEyNSAwbDAgNC41OTM3NXptMTAuNDU5MTk4IDUuMjk2ODc1bC0wLjE4NzUgLTEuNTMxMjVxMC41NDY4NzUgMC4xNDA2MjUgMC45Mzc1IDAuMTQwNjI1cTAuNTQ2ODc1IDAgMC44NzUgLTAuMTg3NXEwLjMyODEyNSAtMC4xNzE4NzUgMC41NDY4NzUgLTAuNXEwLjE1NjI1IC0wLjI1IDAuNSAtMS4yMTg3NXEwLjA0Njg3NSAtMC4xNDA2MjUgMC4xNDA2MjUgLTAuNDA2MjVsLTMuNjcxODc1IC05LjY4NzVsMS43NjU2MjUgMGwyLjAxNTYyNSA1LjU5Mzc1cTAuMzkwNjI1IDEuMDc4MTI1IDAuNzAzMTI1IDIuMjVxMC4yODEyNSAtMS4xMjUgMC42NzE4NzUgLTIuMjAzMTI1bDIuMDc4MTI1IC01LjY0MDYyNWwxLjY0MDYyNSAwbC0zLjY4NzUgOS44MjgxMjVxLTAuNTkzNzUgMS42MDkzNzUgLTAuOTIxODc1IDIuMjAzMTI1cS0wLjQzNzUgMC44MTI1IC0xLjAgMS4xODc1cS0wLjU2MjUgMC4zNzUgLTEuMzQzNzUgMC4zNzVxLTAuNDg0Mzc1IDAgLTEuMDYyNSAtMC4yMDMxMjV6bTkuMDc4MTI1IC0xMC4yMTg3NXEwIC0zLjMyODEyNSAxLjc4MTI1IC01LjIwMzEyNXExLjc4MTI1IC0xLjg5MDYyNSA0LjYwOTM3NSAtMS44OTA2MjVxMS44NDM3NSAwIDMuMzI4MTI1IDAuODkwNjI1cTEuNDg0Mzc1IDAuODc1IDIuMjY1NjI1IDIuNDY4NzVxMC43ODEyNSAxLjU3ODEyNSAwLjc4MTI1IDMuNTc4MTI1cTAgMi4wMzEyNSAtMC44MjgxMjUgMy42NDA2MjVxLTAuODEyNSAxLjU5Mzc1IC0yLjMxMjUgMi40MjE4NzVxLTEuNSAwLjgyODEyNSAtMy4yNSAwLjgyODEyNXEtMS44NzUgMCAtMy4zNTkzNzUgLTAuOTA2MjVxLTEuNDg0Mzc1IC0wLjkyMTg3NSAtMi4yNSAtMi41cS0wLjc2NTYyNSAtMS41NzgxMjUgLTAuNzY1NjI1IC0zLjMyODEyNXptMS44MTI1IDAuMDE1NjI1cTAgMi40MjE4NzUgMS4yOTY4NzUgMy44MTI1cTEuMjk2ODc1IDEuMzkwNjI1IDMuMjY1NjI1IDEuMzkwNjI1cTIuMCAwIDMuMjgxMjUgLTEuNDA2MjVxMS4yODEyNSAtMS40MDYyNSAxLjI4MTI1IC0zLjk4NDM3NXEwIC0xLjYyNSAtMC41NDY4NzUgLTIuODQzNzVxLTAuNTQ2ODc1IC0xLjIxODc1IC0xLjYwOTM3NSAtMS44NzVxLTEuMDYyNSAtMC42NzE4NzUgLTIuMzc1IC0wLjY3MTg3NXEtMS44OTA2MjUgMCAtMy4yNSAxLjI5Njg3NXEtMS4zNDM3NSAxLjI4MTI1IC0xLjM0Mzc1IDQuMjgxMjV6bTE1LjcxNDU2OSA2LjQ4NDM3NWwtMy42ODc1IC05LjY3MTg3NWwxLjczNDM3NSAwbDIuMDc4MTI1IDUuNzk2ODc1cTAuMzI4MTI1IDAuOTM3NSAwLjYyNSAxLjkzNzVxMC4yMDMxMjUgLTAuNzY1NjI1IDAuNjA5Mzc1IC0xLjgyODEyNWwyLjE0MDYyNSAtNS45MDYyNWwxLjY4NzUgMGwtMy42NTYyNSA5LjY3MTg3NWwtMS41MzEyNSAwem0xMy4yNjU2MjUgLTMuMTA5Mzc1bDEuNjg3NSAwLjIwMzEyNXEtMC40MDYyNSAxLjQ4NDM3NSAtMS40ODQzNzUgMi4zMTI1cS0xLjA3ODEyNSAwLjgxMjUgLTIuNzY1NjI1IDAuODEyNXEtMi4xMjUgMCAtMy4zNzUgLTEuMjk2ODc1cS0xLjIzNDM3NSAtMS4zMTI1IC0xLjIzNDM3NSAtMy42NzE4NzVxMCAtMi40NTMxMjUgMS4yNSAtMy43OTY4NzVxMS4yNjU2MjUgLTEuMzQzNzUgMy4yNjU2MjUgLTEuMzQzNzVxMS45Mzc1IDAgMy4xNTYyNSAxLjMyODEyNXExLjIzNDM3NSAxLjMxMjUgMS4yMzQzNzUgMy43MDMxMjVxMCAwLjE1NjI1IDAgMC40Mzc1bC03LjIxODc1IDBxMC4wOTM3NSAxLjU5Mzc1IDAuOTA2MjUgMi40NTMxMjVxMC44MTI1IDAuODQzNzUgMi4wMTU2MjUgMC44NDM3NXEwLjkwNjI1IDAgMS41NDY4NzUgLTAuNDY4NzVxMC42NDA2MjUgLTAuNDg0Mzc1IDEuMDE1NjI1IC0xLjUxNTYyNXptLTUuMzkwNjI1IC0yLjY1NjI1bDUuNDA2MjUgMHEtMC4xMDkzNzUgLTEuMjE4NzUgLTAuNjI1IC0xLjgyODEyNXEtMC43ODEyNSAtMC45NTMxMjUgLTIuMDMxMjUgLTAuOTUzMTI1cS0xLjEyNSAwIC0xLjkwNjI1IDAuNzY1NjI1cS0wLjc2NTYyNSAwLjc1IC0wLjg0Mzc1IDIuMDE1NjI1em05LjEyNTcwMiA1Ljc2NTYyNWwwIC05LjY3MTg3NWwxLjQ2ODc1IDBsMCAxLjQ2ODc1cTAuNTYyNSAtMS4wMzEyNSAxLjAzMTI1IC0xLjM1OTM3NXEwLjQ4NDM3NSAtMC4zMjgxMjUgMS4wNjI1IC0wLjMyODEyNXEwLjgyODEyNSAwIDEuNjg3NSAwLjUzMTI1bC0wLjU2MjUgMS41MTU2MjVxLTAuNjA5Mzc1IC0wLjM1OTM3NSAtMS4yMDMxMjUgLTAuMzU5Mzc1cS0wLjU0Njg3NSAwIC0wLjk2ODc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjMyODEyNSAtMC42MDkzNzUgMC44OTA2MjVxLTAuMjgxMjUgMC44NzUgLTAuMjgxMjUgMS45MjE4NzVsMCA1LjA2MjVsLTEuNjI1IDB6bTYuMTgxNDI3IDBsMCAtMTMuMzU5Mzc1bDEuNjQwNjI1IDBsMCAxMy4zNTkzNzVsLTEuNjQwNjI1IDB6bTEwLjUwNDIxMSAtMS4xODc1cS0wLjkyMTg3NSAwLjc2NTYyNSAtMS43NjU2MjUgMS4wOTM3NXEtMC44MjgxMjUgMC4zMTI1IC0xLjc5Njg3NSAwLjMxMjVxLTEuNTkzNzUgMCAtMi40NTMxMjUgLTAuNzgxMjVxLTAuODU5Mzc1IC0wLjc4MTI1IC0wLjg1OTM3NSAtMS45ODQzNzVxMCAtMC43MTg3NSAwLjMyODEyNSAtMS4yOTY4NzVxMC4zMjgxMjUgLTAuNTkzNzUgMC44NDM3NSAtMC45Mzc1cTAuNTMxMjUgLTAuMzU5Mzc1IDEuMTg3NSAtMC41NDY4NzVxMC40Njg3NSAtMC4xMjUgMS40NTMxMjUgLTAuMjVxMS45ODQzNzUgLTAuMjM0Mzc1IDIuOTIxODc1IC0wLjU2MjVxMC4wMTU2MjUgLTAuMzQzNzUgMC4wMTU2MjUgLTAuNDIxODc1cTAgLTEuMCAtMC40Njg3NSAtMS40MjE4NzVxLTAuNjI1IC0wLjU0Njg3NSAtMS44NzUgLTAuNTQ2ODc1cS0xLjE1NjI1IDAgLTEuNzAzMTI1IDAuNDA2MjVxLTAuNTQ2ODc1IDAuNDA2MjUgLTAuODEyNSAxLjQyMTg3NWwtMS42MDkzNzUgLTAuMjE4NzVxMC4yMTg3NSAtMS4wMTU2MjUgMC43MTg3NSAtMS42NDA2MjVxMC41IC0wLjY0MDYyNSAxLjQ1MzEyNSAtMC45ODQzNzVxMC45NTMxMjUgLTAuMzQzNzUgMi4xODc1IC0wLjM0Mzc1cTEuMjUgMCAyLjAxNTYyNSAwLjI5Njg3NXEwLjc4MTI1IDAuMjgxMjUgMS4xNDA2MjUgMC43MzQzNzVxMC4zNzUgMC40Mzc1IDAuNTE1NjI1IDEuMTA5Mzc1cTAuMDc4MTI1IDAuNDIxODc1IDAuMDc4MTI1IDEuNTE1NjI1bDAgMi4xODc1cTAgMi4yODEyNSAwLjEwOTM3NSAyLjg5MDYyNXEwLjEwOTM3NSAwLjU5Mzc1IDAuNDA2MjUgMS4xNTYyNWwtMS43MDMxMjUgMHEtMC4yNjU2MjUgLTAuNTE1NjI1IC0wLjMyODEyNSAtMS4xODc1em0tMC4xNDA2MjUgLTMuNjcxODc1cS0wLjg5MDYyNSAwLjM3NSAtMi42NzE4NzUgMC42MjVxLTEuMDE1NjI1IDAuMTQwNjI1IC0xLjQzNzUgMC4zMjgxMjVxLTAuNDIxODc1IDAuMTg3NSAtMC42NTYyNSAwLjUzMTI1cS0wLjIxODc1IDAuMzQzNzUgLTAuMjE4NzUgMC43ODEyNXEwIDAuNjU2MjUgMC41IDEuMDkzNzVxMC41IDAuNDM3NSAxLjQ1MzEyNSAwLjQzNzVxMC45Mzc1IDAgMS42NzE4NzUgLTAuNDA2MjVxMC43NSAtMC40MjE4NzUgMS4wOTM3NSAtMS4xNDA2MjVxMC4yNjU2MjUgLTAuNTYyNSAwLjI2NTYyNSAtMS42NDA2MjVsMCAtMC42MDkzNzV6bTQuMjAzODI3IDguNTYyNWwwIC0xMy4zNzVsMS40ODQzNzUgMGwwIDEuMjVxMC41MzEyNSAtMC43MzQzNzUgMS4xODc1IC0xLjA5Mzc1cTAuNjcxODc1IC0wLjM3NSAxLjYyNSAtMC4zNzVxMS4yMzQzNzUgMCAyLjE3MTg3NSAwLjY0MDYyNXEwLjk1MzEyNSAwLjYyNSAxLjQzNzUgMS43OTY4NzVxMC40ODQzNzUgMS4xNTYyNSAwLjQ4NDM3NSAyLjU0Njg3NXEwIDEuNDg0Mzc1IC0wLjUzMTI1IDIuNjcxODc1cS0wLjUzMTI1IDEuMTg3NSAtMS41NDY4NzUgMS44MjgxMjVxLTEuMDE1NjI1IDAuNjI1IC0yLjE0MDYyNSAwLjYyNXEtMC44MTI1IDAgLTEuNDY4NzUgLTAuMzQzNzVxLTAuNjU2MjUgLTAuMzQzNzUgLTEuMDYyNSAtMC44NzVsMCA0LjcwMzEyNWwtMS42NDA2MjUgMHptMS40ODQzNzUgLTguNDg0Mzc1cTAgMS44NTkzNzUgMC43NSAyLjc2NTYyNXEwLjc2NTYyNSAwLjg5MDYyNSAxLjgyODEyNSAwLjg5MDYyNXExLjA5Mzc1IDAgMS44NzUgLTAuOTIxODc1cTAuNzgxMjUgLTAuOTM3NSAwLjc4MTI1IC0yLjg3NXEwIC0xLjg0Mzc1IC0wLjc2NTYyNSAtMi43NjU2MjVxLTAuNzUgLTAuOTIxODc1IC0xLjgxMjUgLTAuOTIxODc1cS0xLjA0Njg3NSAwIC0xLjg1OTM3NSAwLjk4NDM3NXEtMC43OTY4NzUgMC45Njg3NSAtMC43OTY4NzUgMi44NDM3NXptOC4yMzUxMDcgMS44OTA2MjVsMS42MjUgLTAuMjVxMC4xMjUgMC45Njg3NSAwLjc1IDEuNXEwLjYyNSAwLjUxNTYyNSAxLjc1IDAuNTE1NjI1cTEuMTI1IDAgMS42NzE4NzUgLTAuNDUzMTI1cTAuNTQ2ODc1IC0wLjQ2ODc1IDAuNTQ2ODc1IC0xLjA5Mzc1cTAgLTAuNTQ2ODc1IC0wLjQ4NDM3NSAtMC44NzVxLTAuMzI4MTI1IC0wLjIxODc1IC0xLjY3MTg3NSAtMC41NDY4NzVxLTEuODEyNSAtMC40Njg3NSAtMi41MTU2MjUgLTAuNzk2ODc1cS0wLjY4NzUgLTAuMzI4MTI1IC0xLjA0Njg3NSAtMC45MDYyNXEtMC4zNTkzNzUgLTAuNTkzNzUgLTAuMzU5Mzc1IC0xLjMxMjVxMCAtMC42NDA2MjUgMC4yOTY4NzUgLTEuMTg3NXEwLjI5Njg3NSAtMC41NjI1IDAuODEyNSAtMC45MjE4NzVxMC4zNzUgLTAuMjgxMjUgMS4wMzEyNSAtMC40Njg3NXEwLjY3MTg3NSAtMC4yMDMxMjUgMS40MjE4NzUgLTAuMjAzMTI1cTEuMTQwNjI1IDAgMi4wIDAuMzI4MTI1cTAuODU5Mzc1IDAuMzI4MTI1IDEuMjY1NjI1IDAuODkwNjI1cTAuNDIxODc1IDAuNTYyNSAwLjU3ODEyNSAxLjVsLTEuNjA5Mzc1IDAuMjE4NzVxLTAuMTA5Mzc1IC0wLjc1IC0wLjY0MDYyNSAtMS4xNzE4NzVxLTAuNTE1NjI1IC0wLjQyMTg3NSAtMS40Njg3NSAtMC40MjE4NzVxLTEuMTQwNjI1IDAgLTEuNjI1IDAuMzc1cS0wLjQ2ODc1IDAuMzc1IC0wLjQ2ODc1IDAuODc1cTAgMC4zMTI1IDAuMTg3NSAwLjU3ODEyNXEwLjIwMzEyNSAwLjI2NTYyNSAwLjY0MDYyNSAwLjQzNzVxMC4yMzQzNzUgMC4wOTM3NSAxLjQzNzUgMC40MjE4NzVxMS43NSAwLjQ1MzEyNSAyLjQzNzUgMC43NXEwLjY4NzUgMC4yOTY4NzUgMS4wNzgxMjUgMC44NTkzNzVxMC4zOTA2MjUgMC41NjI1IDAuMzkwNjI1IDEuNDA2MjVxMCAwLjgyODEyNSAtMC40ODQzNzUgMS41NDY4NzVxLTAuNDY4NzUgMC43MTg3NSAtMS4zNzUgMS4xMjVxLTAuOTA2MjUgMC4zOTA2MjUgLTIuMDQ2ODc1IDAuMzkwNjI1cS0xLjg3NSAwIC0yLjg3NSAtMC43ODEyNXEtMC45ODQzNzUgLTAuNzgxMjUgLTEuMjUgLTIuMzI4MTI1em0xMy4xMDkzNzUgNi44MTI1cS0xLjM1OTM3NSAtMS43MDMxMjUgLTIuMjk2ODc1IC00LjBxLTAuOTM3NSAtMi4yOTY4NzUgLTAuOTM3NSAtNC43NjU2MjVxMCAtMi4xNTYyNSAwLjcwMzEyNSAtNC4xNDA2MjVxMC44MjgxMjUgLTIuMzEyNSAyLjUzMTI1IC00LjU5Mzc1bDEuMTcxODc1IDBxLTEuMDkzNzUgMS44OTA2MjUgLTEuNDUzMTI1IDIuNzAzMTI1cS0wLjU0Njg3NSAxLjI1IC0wLjg3NSAyLjYyNXEtMC4zOTA2MjUgMS43MDMxMjUgLTAuMzkwNjI1IDMuNDIxODc1cTAgNC4zNzUgMi43MTg3NSA4Ljc1bC0xLjE3MTg3NSAwem0yLjQzMTQyNyAtNi44MTI1bDEuNjI1IC0wLjI1cTAuMTI1IDAuOTY4NzUgMC43NSAxLjVxMC42MjUgMC41MTU2MjUgMS43NSAwLjUxNTYyNXExLjEyNSAwIDEuNjcxODc1IC0wLjQ1MzEyNXEwLjU0Njg3NSAtMC40Njg3NSAwLjU0Njg3NSAtMS4wOTM3NXEwIC0wLjU0Njg3NSAtMC40ODQzNzUgLTAuODc1cS0wLjMyODEyNSAtMC4yMTg3NSAtMS42NzE4NzUgLTAuNTQ2ODc1cS0xLjgxMjUgLTAuNDY4NzUgLTIuNTE1NjI1IC0wLjc5Njg3NXEtMC42ODc1IC0wLjMyODEyNSAtMS4wNDY4NzUgLTAuOTA2MjVxLTAuMzU5Mzc1IC0wLjU5Mzc1IC0wLjM1OTM3NSAtMS4zMTI1cTAgLTAuNjQwNjI1IDAuMjk2ODc1IC0xLjE4NzVxMC4yOTY4NzUgLTAuNTYyNSAwLjgxMjUgLTAuOTIxODc1cTAuMzc1IC0wLjI4MTI1IDEuMDMxMjUgLTAuNDY4NzVxMC42NzE4NzUgLTAuMjAzMTI1IDEuNDIxODc1IC0wLjIwMzEyNXExLjE0MDYyNSAwIDIuMCAwLjMyODEyNXEwLjg1OTM3NSAwLjMyODEyNSAxLjI2NTYyNSAwLjg5MDYyNXEwLjQyMTg3NSAwLjU2MjUgMC41NzgxMjUgMS41bC0xLjYwOTM3NSAwLjIxODc1cS0wLjEwOTM3NSAtMC43NSAtMC42NDA2MjUgLTEuMTcxODc1cS0wLjUxNTYyNSAtMC40MjE4NzUgLTEuNDY4NzUgLTAuNDIxODc1cS0xLjE0MDYyNSAwIC0xLjYyNSAwLjM3NXEtMC40Njg3NSAwLjM3NSAtMC40Njg3NSAwLjg3NXEwIDAuMzEyNSAwLjE4NzUgMC41NzgxMjVxMC4yMDMxMjUgMC4yNjU2MjUgMC42NDA2MjUgMC40Mzc1cTAuMjM0Mzc1IDAuMDkzNzUgMS40Mzc1IDAuNDIxODc1cTEuNzUgMC40NTMxMjUgMi40Mzc1IDAuNzVxMC42ODc1IDAuMjk2ODc1IDEuMDc4MTI1IDAuODU5Mzc1cTAuMzkwNjI1IDAuNTYyNSAwLjM5MDYyNSAxLjQwNjI1cTAgMC44MjgxMjUgLTAuNDg0Mzc1IDEuNTQ2ODc1cS0wLjQ2ODc1IDAuNzE4NzUgLTEuMzc1IDEuMTI1cS0wLjkwNjI1IDAuMzkwNjI1IC0yLjA0Njg3NSAwLjM5MDYyNXEtMS44NzUgMCAtMi44NzUgLTAuNzgxMjVxLTAuOTg0Mzc1IC0wLjc4MTI1IC0xLjI1IC0yLjMyODEyNXptMTYuNjA5Mzc1IC0wLjIxODc1bDEuNjg3NSAwLjIwMzEyNXEtMC40MDYyNSAxLjQ4NDM3NSAtMS40ODQzNzUgMi4zMTI1cS0xLjA3ODEyNSAwLjgxMjUgLTIuNzY1NjI1IDAuODEyNXEtMi4xMjUgMCAtMy4zNzUgLTEuMjk2ODc1cS0xLjIzNDM3NSAtMS4zMTI1IC0xLjIzNDM3NSAtMy42NzE4NzVxMCAtMi40NTMxMjUgMS4yNSAtMy43OTY4NzVxMS4yNjU2MjUgLTEuMzQzNzUgMy4yNjU2MjUgLTEuMzQzNzVxMS45Mzc1IDAgMy4xNTYyNSAxLjMyODEyNXExLjIzNDM3NSAxLjMxMjUgMS4yMzQzNzUgMy43MDMxMjVxMCAwLjE1NjI1IDAgMC40Mzc1bC03LjIxODc1IDBxMC4wOTM3NSAxLjU5Mzc1IDAuOTA2MjUgMi40NTMxMjVxMC44MTI1IDAuODQzNzUgMi4wMTU2MjUgMC44NDM3NXEwLjkwNjI1IDAgMS41NDY4NzUgLTAuNDY4NzVxMC42NDA2MjUgLTAuNDg0Mzc1IDEuMDE1NjI1IC0xLjUxNTYyNXptLTUuMzkwNjI1IC0yLjY1NjI1bDUuNDA2MjUgMHEtMC4xMDkzNzUgLTEuMjE4NzUgLTAuNjI1IC0xLjgyODEyNXEtMC43ODEyNSAtMC45NTMxMjUgLTIuMDMxMjUgLTAuOTUzMTI1cS0xLjEyNSAwIC0xLjkwNjI1IDAuNzY1NjI1cS0wLjc2NTYyNSAwLjc1IC0wLjg0Mzc1IDIuMDE1NjI1em05LjU2MzIwMiA1Ljc2NTYyNWwwIC0xLjg3NWwxLjg3NSAwbDAgMS44NzVxMCAxLjAzMTI1IC0wLjM3NSAxLjY1NjI1cS0wLjM1OTM3NSAwLjY0MDYyNSAtMS4xNTYyNSAwLjk4NDM3NWwtMC40NTMxMjUgLTAuNzAzMTI1cTAuNTE1NjI1IC0wLjIxODc1IDAuNzY1NjI1IC0wLjY3MTg3NXEwLjI1IC0wLjQzNzUgMC4yODEyNSAtMS4yNjU2MjVsLTAuOTM3NSAwem05LjkyOTEwOCAwbDAgLTkuNjcxODc1bDEuNDY4NzUgMGwwIDEuNDY4NzVxMC41NjI1IC0xLjAzMTI1IDEuMDMxMjUgLTEuMzU5Mzc1cTAuNDg0Mzc1IC0wLjMyODEyNSAxLjA2MjUgLTAuMzI4MTI1cTAuODI4MTI1IDAgMS42ODc1IDAuNTMxMjVsLTAuNTYyNSAxLjUxNTYyNXEtMC42MDkzNzUgLTAuMzU5Mzc1IC0xLjIwMzEyNSAtMC4zNTkzNzVxLTAuNTQ2ODc1IDAgLTAuOTY4NzUgMC4zMjgxMjVxLTAuNDIxODc1IDAuMzI4MTI1IC0wLjYwOTM3NSAwLjg5MDYyNXEtMC4yODEyNSAwLjg3NSAtMC4yODEyNSAxLjkyMTg3NWwwIDUuMDYyNWwtMS42MjUgMHptNS42MTg5MjcgLTQuODQzNzVxMCAtMi42ODc1IDEuNDg0Mzc1IC0zLjk2ODc1cTEuMjUgLTEuMDc4MTI1IDMuMDQ2ODc1IC0xLjA3ODEyNXEyLjAgMCAzLjI2NTYyNSAxLjMxMjVxMS4yNjU2MjUgMS4yOTY4NzUgMS4yNjU2MjUgMy42MDkzNzVxMCAxLjg1OTM3NSAtMC41NjI1IDIuOTM3NXEtMC41NjI1IDEuMDYyNSAtMS42NDA2MjUgMS42NTYyNXEtMS4wNjI1IDAuNTkzNzUgLTIuMzI4MTI1IDAuNTkzNzVxLTIuMDMxMjUgMCAtMy4yODEyNSAtMS4yOTY4NzVxLTEuMjUgLTEuMzEyNSAtMS4yNSAtMy43NjU2MjV6bTEuNjg3NSAwcTAgMS44NTkzNzUgMC43OTY4NzUgMi43OTY4NzVxMC44MTI1IDAuOTIxODc1IDIuMDQ2ODc1IDAuOTIxODc1cTEuMjE4NzUgMCAyLjAzMTI1IC0wLjkyMTg3NXEwLjgxMjUgLTAuOTM3NSAwLjgxMjUgLTIuODQzNzVxMCAtMS43OTY4NzUgLTAuODEyNSAtMi43MTg3NXEtMC44MTI1IC0wLjkyMTg3NSAtMi4wMzEyNSAtMC45MjE4NzVxLTEuMjM0Mzc1IDAgLTIuMDQ2ODc1IDAuOTIxODc1cS0wLjc5Njg3NSAwLjkwNjI1IC0wLjc5Njg3NSAyLjc2NTYyNXptOS4yOTc2MDcgLTYuNjI1bDAgLTEuODkwNjI1bDEuNjQwNjI1IDBsMCAxLjg5MDYyNWwtMS42NDA2MjUgMHptMCAxMS40Njg3NWwwIC05LjY3MTg3NWwxLjY0MDYyNSAwbDAgOS42NzE4NzVsLTEuNjQwNjI1IDB6bTUuMjIyOTYxNCAzLjkyMTg3NWwtMS4xODc1IDBxMi43MzQzNzUgLTQuMzc1IDIuNzM0Mzc1IC04Ljc1cTAgLTEuNzE4NzUgLTAuMzkwNjI1IC0zLjM5MDYyNXEtMC4zMTI1IC0xLjM3NSAtMC44NzUgLTIuNjI1cS0wLjM1OTM3NSAtMC44MjgxMjUgLTEuNDY4NzUgLTIuNzM0Mzc1bDEuMTg3NSAwcTEuNzAzMTI1IDIuMjgxMjUgMi41MzEyNSA0LjU5Mzc1cTAuNjg3NSAxLjk4NDM3NSAwLjY4NzUgNC4xNDA2MjVxMCAyLjQ2ODc1IC0wLjkzNzUgNC43NjU2MjVxLTAuOTM3NSAyLjI5Njg3NSAtMi4yODEyNSA0LjB6bTYuMjEyNjc3IDBsLTEuMTg3NSAwcTIuNzM0Mzc1IC00LjM3NSAyLjczNDM3NSAtOC43NXEwIC0xLjcxODc1IC0wLjM5MDYyNSAtMy4zOTA2MjVxLTAuMzEyNSAtMS4zNzUgLTAuODc1IC0yLjYyNXEtMC4zNTkzNzUgLTAuODI4MTI1IC0xLjQ2ODc1IC0yLjczNDM3NWwxLjE4NzUgMHExLjcwMzEyNSAyLjI4MTI1IDIuNTMxMjUgNC41OTM3NXEwLjY4NzUzMDUgMS45ODQzNzUgMC42ODc1MzA1IDQuMTQwNjI1cTAgMi40Njg3NSAtMC45Mzc1MzA1IDQuNzY1NjI1cS0wLjkzNzUgMi4yOTY4NzUgLTIuMjgxMjUgNC4weiIgZmlsbC1ydWxlPSJub256ZXJvIi8+PHBhdGggZmlsbD0iI2U2OTEzOCIgZD0ibTI0NC41NTczNyA1OTEuMDY4NXEtMC45MjE4NzUgMC43NjU2MjUgLTEuNzY1NjI1IDEuMDkzNzVxLTAuODI4MTI1IDAuMzEyNSAtMS43OTY4NzUgMC4zMTI1cS0xLjU5Mzc1IDAgLTIuNDUzMTI1IC0wLjc4MTI1cS0wLjg1OTM3NSAtMC43ODEyNSAtMC44NTkzNzUgLTEuOTg0Mzc1cTAgLTAuNzE4NzUgMC4zMjgxMjUgLTEuMjk2ODc1cTAuMzI4MTI1IC0wLjU5Mzc1IDAuODQzNzUgLTAuOTM3NXEwLjUzMTI1IC0wLjM1OTM3NSAxLjE4NzUgLTAuNTQ2ODc1cTAuNDY4NzUgLTAuMTI1IDEuNDUzMTI1IC0wLjI1cTEuOTg0Mzc1IC0wLjIzNDM3NSAyLjkyMTg3NSAtMC41NjI1cTAuMDE1NjI1IC0wLjM0Mzc1IDAuMDE1NjI1IC0wLjQyMTg3NXEwIC0xLjAgLTAuNDY4NzUgLTEuNDIxODc1cS0wLjYyNSAtMC41NDY4NzUgLTEuODc1IC0wLjU0Njg3NXEtMS4xNTYyNSAwIC0xLjcwMzEyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjgxMjUgMS40MjE4NzVsLTEuNjA5Mzc1IC0wLjIxODc1cTAuMjE4NzUgLTEuMDE1NjI1IDAuNzE4NzUgLTEuNjQwNjI1cTAuNSAtMC42NDA2MjUgMS40NTMxMjUgLTAuOTg0Mzc1cTAuOTUzMTI1IC0wLjM0Mzc1IDIuMTg3NSAtMC4zNDM3NXExLjI1IDAgMi4wMTU2MjUgMC4yOTY4NzVxMC43ODEyNSAwLjI4MTI1IDEuMTQwNjI1IDAuNzM0Mzc1cTAuMzc1IDAuNDM3NSAwLjUxNTYyNSAxLjEwOTM3NXEwLjA3ODEyNSAwLjQyMTg3NSAwLjA3ODEyNSAxLjUxNTYyNWwwIDIuMTg3NXEwIDIuMjgxMjUgMC4xMDkzNzUgMi44OTA2MjVxMC4xMDkzNzUgMC41OTM3NSAwLjQwNjI1IDEuMTU2MjVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzUgMS40NTMxMjUgMC40Mzc1cTAuOTM3NSAwIDEuNjcxODc1IC0wLjQwNjI1cTAuNzUgLTAuNDIxODc1IDEuMDkzNzUgLTEuMTQwNjI1cTAuMjY1NjI1IC0wLjU2MjUgMC4yNjU2MjUgLTEuNjQwNjI1bDAgLTAuNjA5Mzc1em0zLjU0NzU5MjIgMS45Njg3NWwxLjYyNSAtMC4yNXEwLjEyNSAwLjk2ODc1IDAuNzUgMS41cTAuNjI1IDAuNTE1NjI1IDEuNzUgMC41MTU2MjVxMS4xMjUgMCAxLjY3MTg3NSAtMC40NTMxMjVxMC41NDY4NzUgLTAuNDY4NzUgMC41NDY4NzUgLTEuMDkzNzVxMCAtMC41NDY4NzUgLTAuNDg0Mzc1IC0wLjg3NXEtMC4zMjgxMjUgLTAuMjE4NzUgLTEuNjcxODc1IC0wLjU0Njg3NXEtMS44MTI1IC0wLjQ2ODc1IC0yLjUxNTYyNSAtMC43OTY4NzVxLTAuNjg3NSAtMC4zMjgxMjUgLTEuMDQ2ODc1IC0wLjkwNjI1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzUgMC4zMjgxMjUgMS4yNjU2MjUgMC44OTA2MjVxMC40MjE4NzUgMC41NjI1IDAuNTc4MTI1IDEuNWwtMS42MDkzNzUgMC4yMTg3NXEtMC4xMDkzNzUgLTAuNzUgLTAuNjQwNjI1IC0xLjE3MTg3NXEtMC41MTU2MjUgLTAuNDIxODc1IC0xLjQ2ODc1IC0wLjQyMTg3NXEtMS4xNDA2MjUgMCAtMS42MjUgMC4zNzVxLTAuNDY4NzUgMC4zNzUgLTAuNDY4NzUgMC44NzVxMCAwLjMxMjUgMC4xODc1IDAuNTc4MTI1cTAuMjAzMTI1IDAuMjY1NjI1IDAuNjQwNjI1IDAuNDM3NXEwLjIzNDM3NSAwLjA5Mzc1IDEuNDM3NSAwLjQyMTg3NXExLjc1IDAuNDUzMTI1IDIuNDM3NSAwLjc1cTAuNjg3NSAwLjI5Njg3NSAxLjA3ODEyNSAwLjg1OTM3NXEwLjM5MDYyNSAwLjU2MjUgMC4zOTA2MjUgMS40MDYyNXEwIDAuODI4MTI1IC0wLjQ4NDM3NSAxLjU0Njg3NXEtMC40Njg3NSAwLjcxODc1IC0xLjM3NSAxLjEyNXEtMC45MDYyNSAwLjM5MDYyNSAtMi4wNDY4NzUgMC4zOTA2MjVxLTEuODc1IDAgLTIuODc1IC0wLjc4MTI1cS0wLjk4NDM3NSAtMC43ODEyNSAtMS4yNSAtMi4zMjgxMjV6bTkuMzI4MTQgMGwxLjYyNSAtMC4yNXEwLjEyNSAwLjk2ODc1IDAuNzUgMS41cTAuNjI1IDAuNTE1NjI1IDEuNzUgMC41MTU2MjVxMS4xMjUgMCAxLjY3MTg3NSAtMC40NTMxMjVxMC41NDY4NzUgLTAuNDY4NzUgMC41NDY4NzUgLTEuMDkzNzVxMCAtMC41NDY4NzUgLTAuNDg0Mzc1IC0wLjg3NXEtMC4zMjgxMjUgLTAuMjE4NzUgLTEuNjcxODc1IC0wLjU0Njg3NXEtMS44MTI1IC0wLjQ2ODc1IC0yLjUxNTYyNSAtMC43OTY4NzVxLTAuNjg3NSAtMC4zMjgxMjUgLTEuMDQ2ODc1IC0wLjkwNjI1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzUgMC4zMjgxMjUgMS4yNjU2MjUgMC44OTA2MjVxMC40MjE4NzUgMC41NjI1IDAuNTc4MTI1IDEuNWwtMS42MDkzNzUgMC4yMTg3NXEtMC4xMDkzNzUgLTAuNzUgLTAuNjQwNjI1IC0xLjE3MTg3NXEtMC41MTU2MjUgLTAuNDIxODc1IC0xLjQ2ODc1IC0wLjQyMTg3NXEtMS4xNDA2MjUgMCAtMS42MjUgMC4zNzVxLTAuNDY4NzUgMC4zNzUgLTAuNDY4NzUgMC44NzVxMCAwLjMxMjUgMC4xODc1IDAuNTc4MTI1cTAuMjAzMTI1IDAuMjY1NjI1IDAuNjQwNjI1IDAuNDM3NXEwLjIzNDM3NSAwLjA5Mzc1IDEuNDM3NSAwLjQyMTg3NXExLjc1IDAuNDUzMTI1IDIuNDM3NSAwLjc1cTAuNjg3NSAwLjI5Njg3NSAxLjA3ODEyNSAwLjg1OTM3NXEwLjM5MDYyNSAwLjU2MjUgMC4zOTA2MjUgMS40MDYyNXEwIDAuODI4MTI1IC0wLjQ4NDM3NSAxLjU0Njg3NXEtMC40Njg3NSAwLjcxODc1IC0xLjM3NSAxLjEyNXEtMC45MDYyNSAwLjM5MDYyNSAtMi4wNDY4NzUgMC4zOTA2MjVxLTEuODc1IDAgLTIuODc1IC0wLjc4MTI1cS0wLjk4NDM3NSAtMC43ODEyNSAtMS4yNSAtMi4zMjgxMjV6bTE2LjI5Njg3NSAxLjcwMzEyNXEtMC45MjE4NzUgMC43NjU2MjUgLTEuNzY1NjI1IDEuMDkzNzVxLTAuODI4MTI1IDAuMzEyNSAtMS43OTY4NzUgMC4zMTI1cS0xLjU5Mzc1IDAgLTIuNDUzMTI1IC0wLjc4MTI1cS0wLjg1OTM3NSAtMC43ODEyNSAtMC44NTkzNzUgLTEuOTg0Mzc1cTAgLTAuNzE4NzUgMC4zMjgxMjUgLTEuMjk2ODc1cTAuMzI4MTI1IC0wLjU5Mzc1IDAuODQzNzUgLTAuOTM3NXEwLjUzMTI1IC0wLjM1OTM3NSAxLjE4NzUgLTAuNTQ2ODc1cTAuNDY4NzUgLTAuMTI1IDEuNDUzMTI1IC0wLjI1cTEuOTg0Mzc1IC0wLjIzNDM3NSAyLjkyMTg3NSAtMC41NjI1cTAuMDE1NjI1IC0wLjM0Mzc1IDAuMDE1NjI1IC0wLjQyMTg3NXEwIC0xLjAgLTAuNDY4NzUgLTEuNDIxODc1cS0wLjYyNSAtMC41NDY4NzUgLTEuODc1IC0wLjU0Njg3NXEtMS4xNTYyNSAwIC0xLjcwMzEyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjgxMjUgMS40MjE4NzVsLTEuNjA5Mzc1IC0wLjIxODc1cTAuMjE4NzUgLTEuMDE1NjI1IDAuNzE4NzUgLTEuNjQwNjI1cTAuNSAtMC42NDA2MjUgMS40NTMxMjUgLTAuOTg0Mzc1cTAuOTUzMTI1IC0wLjM0Mzc1IDIuMTg3NSAtMC4zNDM3NXExLjI1IDAgMi4wMTU2MjUgMC4yOTY4NzVxMC43ODEyNSAwLjI4MTI1IDEuMTQwNjI1IDAuNzM0Mzc1cTAuMzc1IDAuNDM3NSAwLjUxNTYyNSAxLjEwOTM3NXEwLjA3ODEyNSAwLjQyMTg3NSAwLjA3ODEyNSAxLjUxNTYyNWwwIDIuMTg3NXEwIDIuMjgxMjUgMC4xMDkzNzUgMi44OTA2MjVxMC4xMDkzNzUgMC41OTM3NSAwLjQwNjI1IDEuMTU2MjVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzUgMS40NTMxMjUgMC40Mzc1cTAuOTM3NSAwIDEuNjcxODc1IC0wLjQwNjI1cTAuNzUgLTAuNDIxODc1IDEuMDkzNzUgLTEuMTQwNjI1cTAuMjY1NjI1IC0wLjU2MjUgMC4yNjU2MjUgLTEuNjQwNjI1bDAgLTAuNjA5Mzc1em00LjEyNTcwMiA4LjU3ODEyNWwtMC4xODc1IC0xLjUzMTI1cTAuNTQ2ODc1IDAuMTQwNjI1IDAuOTM3NSAwLjE0MDYyNXEwLjU0Njg3NSAwIDAuODc1IC0wLjE4NzVxMC4zMjgxMjUgLTAuMTcxODc1IDAuNTQ2ODc1IC0wLjVxMC4xNTYyNSAtMC4yNSAwLjUgLTEuMjE4NzVxMC4wNDY4NzUgLTAuMTQwNjI1IDAuMTQwNjI1IC0wLjQwNjI1bC0zLjY3MTg3NSAtOS42ODc1bDEuNzY1NjI1IDBsMi4wMTU2MjUgNS41OTM3NXEwLjM5MDYyNSAxLjA3ODEyNSAwLjcwMzEyNSAyLjI1cTAuMjgxMjUgLTEuMTI1IDAuNjcxODc1IC0yLjIwMzEyNWwyLjA3ODEyNSAtNS42NDA2MjVsMS42NDA2MjUgMGwtMy42ODc1IDkuODI4MTI1cS0wLjU5Mzc1IDEuNjA5Mzc1IC0wLjkyMTg3NSAyLjIwMzEyNXEtMC40Mzc1IDAuODEyNSAtMS4wIDEuMTg3NXEtMC41NjI1IDAuMzc1IC0xLjM0Mzc1IDAuMzc1cS0wLjQ4NDM3NSAwIC0xLjA2MjUgLTAuMjAzMTI1em0xMi41MzEyNSAwLjIwMzEyNXEtMS4zNTkzNzUgLTEuNzAzMTI1IC0yLjI5Njg3NSAtNC4wcS0wLjkzNzUgLTIuMjk2ODc1IC0wLjkzNzUgLTQuNzY1NjI1cTAgLTIuMTU2MjUgMC43MDMxMjUgLTQuMTQwNjI1cTAuODI4MTI1IC0yLjMxMjUgMi41MzEyNSAtNC41OTM3NWwxLjE3MTg3NSAwcS0xLjA5Mzc1IDEuODkwNjI1IC0xLjQ1MzEyNSAyLjcwMzEyNXEtMC41NDY4NzUgMS4yNSAtMC44NzUgMi42MjVxLTAuMzkwNjI1IDEuNzAzMTI1IC0wLjM5MDYyNSAzLjQyMTg3NXEwIDQuMzc1IDIuNzE4NzUgOC43NWwtMS4xNzE4NzUgMHptMi40MzE0MjcgLTYuODEyNWwxLjYyNSAtMC4yNXEwLjEyNSAwLjk2ODc1IDAuNzUgMS41cTAuNjI1IDAuNTE1NjI1IDEuNzUgMC41MTU2MjVxMS4xMjUgMCAxLjY3MTg3NSAtMC40NTMxMjVxMC41NDY4NzUgLTAuNDY4NzUgMC41NDY4NzUgLTEuMDkzNzVxMCAtMC41NDY4NzUgLTAuNDg0Mzc1IC0wLjg3NXEtMC4zMjgxMjUgLTAuMjE4NzUgLTEuNjcxODc1IC0wLjU0Njg3NXEtMS44MTI1IC0wLjQ2ODc1IC0yLjUxNTYyNSAtMC43OTY4NzVxLTAuNjg3NSAtMC4zMjgxMjUgLTEuMDQ2ODc1IC0wLjkwNjI1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzUgMC4zMjgxMjUgMS4yNjU2MjUgMC44OTA2MjVxMC40MjE4NzUgMC41NjI1IDAuNTc4MTI1IDEuNWwtMS42MDkzNzUgMC4yMTg3NXEtMC4xMDkzNzUgLTAuNzUgLTAuNjQwNjI1IC0xLjE3MTg3NXEtMC41MTU2MjUgLTAuNDIxODc1IC0xLjQ2ODc1IC0wLjQyMTg3NXEtMS4xNDA2MjUgMCAtMS42MjUgMC4zNzVxLTAuNDY4NzUgMC4zNzUgLTAuNDY4NzUgMC44NzVxMCAwLjMxMjUgMC4xODc1IDAuNTc4MTI1cTAuMjAzMTI1IDAuMjY1NjI1IDAuNjQwNjI1IDAuNDM3NXEwLjIzNDM3NSAwLjA5Mzc1IDEuNDM3NSAwLjQyMTg3NXExLjc1IDAuNDUzMTI1IDIuNDM3NSAwLjc1cTAuNjg3NSAwLjI5Njg3NSAxLjA3ODEyNSAwLjg1OTM3NXEwLjM5MDYyNSAwLjU2MjUgMC4zOTA2MjUgMS40MDYyNXEwIDAuODI4MTI1IC0wLjQ4NDM3NSAxLjU0Njg3NXEtMC40Njg3NSAwLjcxODc1IC0xLjM3NSAxLjEyNXEtMC45MDYyNSAwLjM5MDYyNSAtMi4wNDY4NzUgMC4zOTA2MjVxLTEuODc1IDAgLTIuODc1IC0wLjc4MTI1cS0wLjk4NDM3NSAtMC43ODEyNSAtMS4yNSAtMi4zMjgxMjV6bTE2LjYwOTM3NSAtMC4yMTg3NWwxLjY4NzUgMC4yMDMxMjVxLTAuNDA2MjUgMS40ODQzNzUgLTEuNDg0Mzc1IDIuMzEyNXEtMS4wNzgxMjUgMC44MTI1IC0yLjc2NTYyNSAwLjgxMjVxLTIuMTI1IDAgLTMuMzc1IC0xLjI5Njg3NXEtMS4yMzQzNzUgLTEuMzEyNSAtMS4yMzQzNzUgLTMuNjcxODc1cTAgLTIuNDUzMTI1IDEuMjUgLTMuNzk2ODc1cTEuMjY1NjI1IC0xLjM0Mzc1IDMuMjY1NjI1IC0xLjM0Mzc1cTEuOTM3NSAwIDMuMTU2MjUgMS4zMjgxMjVxMS4yMzQzNzUgMS4zMTI1IDEuMjM0Mzc1IDMuNzAzMTI1cTAgMC4xNTYyNSAwIDAuNDM3NWwtNy4yMTg3NSAwcTAuMDkzNzUgMS41OTM3NSAwLjkwNjI1IDIuNDUzMTI1cTAuODEyNSAwLjg0Mzc1IDIuMDE1NjI1IDAuODQzNzVxMC45MDYyNSAwIDEuNTQ2ODc1IC0wLjQ2ODc1cTAuNjQwNjI1IC0wLjQ4NDM3NSAxLjAxNTYyNSAtMS41MTU2MjV6bS01LjM5MDYyNSAtMi42NTYyNWw1LjQwNjI1IDBxLTAuMTA5Mzc1IC0xLjIxODc1IC0wLjYyNSAtMS44MjgxMjVxLTAuNzgxMjUgLTAuOTUzMTI1IC0yLjAzMTI1IC0wLjk1MzEyNXEtMS4xMjUgMCAtMS45MDYyNSAwLjc2NTYyNXEtMC43NjU2MjUgMC43NSAtMC44NDM3NSAyLjAxNTYyNXptOS4xNzI2MDcgOS40Njg3NWwwIC0xNy4wNjI1bDMuNjA5Mzc1IDBsMCAxLjM1OTM3NWwtMS45Njg3NSAwbDAgMTQuMzQzNzVsMS45Njg3NSAwbDAgMS4zNTkzNzVsLTMuNjA5Mzc1IDB6bTUuNTczOTEzNiAtMy43MDMxMjVsMCAtMS44NzVsMS44NzUgMGwwIDEuODc1cTAgMS4wMzEyNSAtMC4zNzUgMS42NTYyNXEtMC4zNTkzNzUgMC42NDA2MjUgLTEuMTU2MjUgMC45ODQzNzVsLTAuNDUzMTI1IC0wLjcwMzEyNXEwLjUxNTYyNSAtMC4yMTg3NSAwLjc2NTYyNSAtMC42NzE4NzVxMC4yNSAtMC40Mzc1IDAuMjgxMjUgLTEuMjY1NjI1bC0wLjkzNzUgMHptOS4yODg0ODMgLTIuODkwNjI1bDEuNjI1IC0wLjI1cTAuMTI1IDAuOTY4NzUgMC43NSAxLjVxMC42MjUgMC41MTU2MjUgMS43NSAwLjUxNTYyNXExLjEyNSAwIDEuNjcxODc1IC0wLjQ1MzEyNXEwLjU0Njg3NSAtMC40Njg3NSAwLjU0Njg3NSAtMS4wOTM3NXEwIC0wLjU0Njg3NSAtMC40ODQzNzUgLTAuODc1cS0wLjMyODEyNSAtMC4yMTg3NSAtMS42NzE4NzUgLTAuNTQ2ODc1cS0xLjgxMjUgLTAuNDY4NzUgLTIuNTE1NjI1IC0wLjc5Njg3NXEtMC42ODc1IC0wLjMyODEyNSAtMS4wNDY4NzUgLTAuOTA2MjVxLTAuMzU5Mzc1IC0wLjU5Mzc1IC0wLjM1OTM3NSAtMS4zMTI1cTAgLTAuNjQwNjI1IDAuMjk2ODc1IC0xLjE4NzVxMC4yOTY4NzUgLTAuNTYyNSAwLjgxMjUgLTAuOTIxODc1cTAuMzc1IC0wLjI4MTI1IDEuMDMxMjUgLTAuNDY4NzVxMC42NzE4NzUgLTAuMjAzMTI1IDEuNDIxODc1IC0wLjIwMzEyNXExLjE0MDYyNSAwIDIuMCAwLjMyODEyNXEwLjg1OTM3NSAwLjMyODEyNSAxLjI2NTYyNSAwLjg5MDYyNXEwLjQyMTg3NSAwLjU2MjUgMC41NzgxMjUgMS41bC0xLjYwOTM3NSAwLjIxODc1cS0wLjEwOTM3NSAtMC43NSAtMC42NDA2MjUgLTEuMTcxODc1cS0wLjUxNTYyNSAtMC40MjE4NzUgLTEuNDY4NzUgLTAuNDIxODc1cS0xLjE0MDYyNSAwIC0xLjYyNSAwLjM3NXEtMC40Njg3NSAwLjM3NSAtMC40Njg3NSAwLjg3NXEwIDAuMzEyNSAwLjE4NzUgMC41NzgxMjVxMC4yMDMxMjUgMC4yNjU2MjUgMC42NDA2MjUgMC40Mzc1cTAuMjM0Mzc1IDAuMDkzNzUgMS40Mzc1IDAuNDIxODc1cTEuNzUgMC40NTMxMjUgMi40Mzc1IDAuNzVxMC42ODc1IDAuMjk2ODc1IDEuMDc4MTI1IDAuODU5Mzc1cTAuMzkwNjI1IDAuNTYyNSAwLjM5MDYyNSAxLjQwNjI1cTAgMC44MjgxMjUgLTAuNDg0Mzc1IDEuNTQ2ODc1cS0wLjQ2ODc1IDAuNzE4NzUgLTEuMzc1IDEuMTI1cS0wLjkwNjI1IDAuMzkwNjI1IC0yLjA0Njg3NSAwLjM5MDYyNXEtMS44NzUgMCAtMi44NzUgLTAuNzgxMjVxLTAuOTg0Mzc1IC0wLjc4MTI1IC0xLjI1IC0yLjMyODEyNXptMTYuNjA5Mzc1IC0wLjIxODc1bDEuNjg3NSAwLjIwMzEyNXEtMC40MDYyNSAxLjQ4NDM3NSAtMS40ODQzNzUgMi4zMTI1cS0xLjA3ODEyNSAwLjgxMjUgLTIuNzY1NjI1IDAuODEyNXEtMi4xMjUgMCAtMy4zNzUgLTEuMjk2ODc1cS0xLjIzNDM3NSAtMS4zMTI1IC0xLjIzNDM3NSAtMy42NzE4NzVxMCAtMi40NTMxMjUgMS4yNSAtMy43OTY4NzVxMS4yNjU2MjUgLTEuMzQzNzUgMy4yNjU2MjUgLTEuMzQzNzVxMS45Mzc1IDAgMy4xNTYyNSAxLjMyODEyNXExLjIzNDM3NSAxLjMxMjUgMS4yMzQzNzUgMy43MDMxMjVxMCAwLjE1NjI1IDAgMC40Mzc1bC03LjIxODc1IDBxMC4wOTM3NSAxLjU5Mzc1IDAuOTA2MjUgMi40NTMxMjVxMC44MTI1IDAuODQzNzUgMi4wMTU2MjUgMC44NDM3NXEwLjkwNjI1IDAgMS41NDY4NzUgLTAuNDY4NzVxMC42NDA2MjUgLTAuNDg0Mzc1IDEuMDE1NjI1IC0xLjUxNTYyNXptLTUuMzkwNjI1IC0yLjY1NjI1bDUuNDA2MjUgMHEtMC4xMDkzNzUgLTEuMjE4NzUgLTAuNjI1IC0xLjgyODEyNXEtMC43ODEyNSAtMC45NTMxMjUgLTIuMDMxMjUgLTAuOTUzMTI1cS0xLjEyNSAwIC0xLjkwNjI1IDAuNzY1NjI1cS0wLjc2NTYyNSAwLjc1IC0wLjg0Mzc1IDIuMDE1NjI1em0xMi41NDc2MDcgNy42ODc1bDAgLTEuNjQwNjI1cS0xLjIxODc1IC0wLjE1NjI1IC0yLjAgLTAuNTQ2ODc1cS0wLjc2NTYyNSAtMC40MDYyNSAtMS4zMjgxMjUgLTEuMjgxMjVxLTAuNTYyNSAtMC44OTA2MjUgLTAuNjQwNjI1IC0yLjE1NjI1bDEuNjQwNjI1IC0wLjMxMjVxMC4xODc1IDEuMzEyNSAwLjY3MTg3NSAxLjkzNzVxMC43MDMxMjUgMC44NzUgMS42NTYyNSAwLjk2ODc1bDAgLTUuMjE4NzVxLTEuMCAtMC4xODc1IC0yLjA2MjUgLTAuNzgxMjVxLTAuNzgxMjUgLTAuNDM3NSAtMS4yMDMxMjUgLTEuMjAzMTI1cS0wLjQyMTg3NSAtMC43ODEyNSAtMC40MjE4NzUgLTEuNzY1NjI1cTAgLTEuNzUgMS4yMzQzNzUgLTIuODI4MTI1cTAuODI4MTI1IC0wLjczNDM3NSAyLjQ1MzEyNSAtMC44OTA2MjVsMCAtMC43ODEyNWwwLjk2ODc1IDBsMCAwLjc4MTI1cTEuNDM3NSAwLjEyNSAyLjI2NTYyNSAwLjgyODEyNXExLjA3ODEyNSAwLjkwNjI1IDEuMjk2ODc1IDIuNDUzMTI1bC0xLjY4NzUgMC4yNjU2MjVxLTAuMTU2MjUgLTAuOTY4NzUgLTAuNjI1IC0xLjQ4NDM3NXEtMC40NTMxMjUgLTAuNTE1NjI1IC0xLjI1IC0wLjY4NzVsMCA0LjczNDM3NXExLjIzNDM3NSAwLjMxMjUgMS42NDA2MjUgMC40ODQzNzVxMC43NjU2MjUgMC4zMjgxMjUgMS4yNSAwLjgxMjVxMC40ODQzNzUgMC40ODQzNzUgMC43MzQzNzUgMS4xNTYyNXEwLjI2NTYyNSAwLjY1NjI1IDAuMjY1NjI1IDEuNDM3NXEwIDEuNzAzMTI1IC0xLjA5Mzc1IDIuODQzNzVxLTEuMDc4MTI1IDEuMTQwNjI1IC0yLjc5Njg3NSAxLjIxODc1bDAgMS42NTYyNWwtMC45Njg3NSAwem0wIC0xNC4zNTkzNzVxLTAuOTUzMTI1IDAuMTU2MjUgLTEuNSAwLjc4MTI1cS0wLjU0Njg3NSAwLjYwOTM3NSAtMC41NDY4NzUgMS40NTMxMjVxMCAwLjg0Mzc1IDAuNDY4NzUgMS40MDYyNXEwLjQ2ODc1IDAuNTYyNSAxLjU3ODEyNSAwLjkwNjI1bDAgLTQuNTQ2ODc1em0wLjk2ODc1IDExLjMyODEyNXEwLjk1MzEyNSAtMC4xMDkzNzUgMS41NzgxMjUgLTAuODEyNXEwLjYyNSAtMC43MTg3NSAwLjYyNSAtMS43NjU2MjVxMCAtMC44OTA2MjUgLTAuNDM3NSAtMS40Mzc1cS0wLjQzNzUgLTAuNTQ2ODc1IC0xLjc2NTYyNSAtMC45Njg3NWwwIDQuOTg0Mzc1em0xMi4yNjYzMjcgMS4xMDkzNzVsMCAtMS4yMTg3NXEtMC45MDYyNSAxLjQzNzUgLTIuNzAzMTI1IDEuNDM3NXEtMS4xNTYyNSAwIC0yLjEyNSAtMC42NDA2MjVxLTAuOTY4NzUgLTAuNjQwNjI1IC0xLjUgLTEuNzgxMjVxLTAuNTMxMjUgLTEuMTQwNjI1IC0wLjUzMTI1IC0yLjYyNXEwIC0xLjQ1MzEyNSAwLjQ4NDM3NSAtMi42MjVxMC40ODQzNzUgLTEuMTg3NSAxLjQzNzUgLTEuODEyNXEwLjk2ODc1IC0wLjYyNSAyLjE3MTg3NSAtMC42MjVxMC44NzUgMCAxLjU0Njg3NSAwLjM3NXEwLjY4NzUgMC4zNTkzNzUgMS4xMDkzNzUgMC45NTMxMjVsMCAtNC43OTY4NzVsMS42NDA2MjUgMGwwIDEzLjM1OTM3NWwtMS41MzEyNSAwem0tNS4xNzE4NzUgLTQuODI4MTI1cTAgMS44NTkzNzUgMC43ODEyNSAyLjc4MTI1cTAuNzgxMjUgMC45MjE4NzUgMS44NDM3NSAwLjkyMTg3NXExLjA3ODEyNSAwIDEuODI4MTI1IC0wLjg3NXEwLjc1IC0wLjg5MDYyNSAwLjc1IC0yLjY4NzVxMCAtMS45ODQzNzUgLTAuNzY1NjI1IC0yLjkwNjI1cS0wLjc2NTYyNSAtMC45Mzc1IC0xLjg5MDYyNSAtMC45Mzc1cS0xLjA3ODEyNSAwIC0xLjgxMjUgMC44OTA2MjVxLTAuNzM0Mzc1IDAuODkwNjI1IC0wLjczNDM3NSAyLjgxMjV6bTE1LjkwNjk4MiAxLjcxODc1bDEuNjg3NSAwLjIwMzEyNXEtMC40MDYyNSAxLjQ4NDM3NSAtMS40ODQzNzUgMi4zMTI1cS0xLjA3ODEyNSAwLjgxMjUgLTIuNzY1NjI1IDAuODEyNXEtMi4xMjUgMCAtMy4zNzUgLTEuMjk2ODc1cS0xLjIzNDM3NSAtMS4zMTI1IC0xLjIzNDM3NSAtMy42NzE4NzVxMCAtMi40NTMxMjUgMS4yNSAtMy43OTY4NzVxMS4yNjU2MjUgLTEuMzQzNzUgMy4yNjU2MjUgLTEuMzQzNzVxMS45Mzc1IDAgMy4xNTYyNSAxLjMyODEyNXExLjIzNDM3NSAxLjMxMjUgMS4yMzQzNzUgMy43MDMxMjVxMCAwLjE1NjI1IDAgMC40Mzc1bC03LjIxODc1IDBxMC4wOTM3NSAxLjU5Mzc1IDAuOTA2MjUgMi40NTMxMjVxMC44MTI1IDAuODQzNzUgMi4wMTU2MjUgMC44NDM3NXEwLjkwNjI1IDAgMS41NDY4NzUgLTAuNDY4NzVxMC42NDA2MjUgLTAuNDg0Mzc1IDEuMDE1NjI1IC0xLjUxNTYyNXptLTUuMzkwNjI1IC0yLjY1NjI1bDUuNDA2MjUgMHEtMC4xMDkzNzUgLTEuMjE4NzUgLTAuNjI1IC0xLjgyODEyNXEtMC43ODEyNSAtMC45NTMxMjUgLTIuMDMxMjUgLTAuOTUzMTI1cS0xLjEyNSAwIC0xLjkwNjI1IDAuNzY1NjI1cS0wLjc2NTYyNSAwLjc1IC0wLjg0Mzc1IDIuMDE1NjI1em04LjA0NzU3NyA1Ljc2NTYyNWwzLjUzMTI1IC01LjAzMTI1bC0zLjI2NTYyNSAtNC42NDA2MjVsMi4wNDY4NzUgMGwxLjQ4NDM3NSAyLjI2NTYyNXEwLjQyMTg3NSAwLjY0MDYyNSAwLjY3MTg3NSAxLjA3ODEyNXEwLjQwNjI1IC0wLjU5Mzc1IDAuNzM0Mzc1IC0xLjA2MjVsMS42NDA2MjUgLTIuMjgxMjVsMS45NTMxMjUgMGwtMy4zNDM3NSA0LjU0Njg3NWwzLjU5Mzc1IDUuMTI1bC0yLjAxNTYyNSAwbC0xLjk4NDM3NSAtMy4wbC0wLjUxNTYyNSAtMC44MTI1bC0yLjU0Njg3NSAzLjgxMjVsLTEuOTg0Mzc1IDB6bTI0LjIzMDE5NCAtNy44NTkzNzVsLTguODI4MTI1IDBsMCAtMS41MTU2MjVsOC44MjgxMjUgMGwwIDEuNTE1NjI1em0wIDQuMDYyNWwtOC44MjgxMjUgMGwwIC0xLjUzMTI1bDguODI4MTI1IDBsMCAxLjUzMTI1em0xMC44OTQ5NTg1IC00LjA2MjVsLTguODI4MTI1IDBsMCAtMS41MTU2MjVsOC44MjgxMjUgMGwwIDEuNTE1NjI1em0wIDQuMDYyNWwtOC44MjgxMjUgMGwwIC0xLjUzMTI1bDguODI4MTI1IDBsMCAxLjUzMTI1em03LjUzMTM3MiAtNC44MjgxMjVsLTAuNDUzMTI1IC0yLjU0Njg3NWwwIC0yLjE4NzVsMS44NTkzNzUgMGwwIDIuMTg3NWwtMC40MDYyNSAyLjU0Njg3NWwtMS4wIDB6bTMuMDE1NjI1IDBsLTAuNDUzMTI1IC0yLjU0Njg3NWwwIC0yLjE4NzVsMS44NzUgMGwwIDIuMTg3NWwtMC40Mzc1IDIuNTQ2ODc1bC0wLjk4NDM3NSAwem03LjEwNjk5NDYgNy4xNTYyNWwwLjIzNDM3NSAxLjQ1MzEyNXEtMC42ODc1IDAuMTQwNjI1IC0xLjIzNDM3NSAwLjE0MDYyNXEtMC44OTA2MjUgMCAtMS4zOTA2MjUgLTAuMjgxMjVxLTAuNDg0Mzc1IC0wLjI4MTI1IC0wLjY4NzUgLTAuNzM0Mzc1cS0wLjIwMzEyNSAtMC40Njg3NSAtMC4yMDMxMjUgLTEuOTM3NWwwIC01LjU3ODEyNWwtMS4yMDMxMjUgMGwwIC0xLjI2NTYyNWwxLjIwMzEyNSAwbDAgLTIuMzkwNjI1bDEuNjI1IC0wLjk4NDM3NWwwIDMuMzc1bDEuNjU2MjUgMGwwIDEuMjY1NjI1bC0xLjY1NjI1IDBsMCA1LjY3MTg3NXEwIDAuNjg3NSAwLjA3ODEyNSAwLjg5MDYyNXEwLjA5Mzc1IDAuMjAzMTI1IDAuMjgxMjUgMC4zMjgxMjVxMC4yMDMxMjUgMC4xMDkzNzUgMC41NzgxMjUgMC4xMDkzNzVxMC4yNjU2MjUgMCAwLjcxODc1IC0wLjA2MjV6bTEuNTg5NTM4NiAxLjQ2ODc1bDAgLTkuNjcxODc1bDEuNDY4NzUgMGwwIDEuNDY4NzVxMC41NjI1IC0xLjAzMTI1IDEuMDMxMjUgLTEuMzU5Mzc1cTAuNDg0Mzc1IC0wLjMyODEyNSAxLjA2MjUgLTAuMzI4MTI1cTAuODI4MTI1IDAgMS42ODc1IDAuNTMxMjVsLTAuNTYyNSAxLjUxNTYyNXEtMC42MDkzNzUgLTAuMzU5Mzc1IC0xLjIwMzEyNSAtMC4zNTkzNzVxLTAuNTQ2ODc1IDAgLTAuOTY4NzUgMC4zMjgxMjVxLTAuNDIxODc1IDAuMzI4MTI1IC0wLjYwOTM3NSAwLjg5MDYyNXEtMC4yODEyNSAwLjg3NSAtMC4yODEyNSAxLjkyMTg3NWwwIDUuMDYyNWwtMS42MjUgMHptOS44MDY0MjcgLTEuNDY4NzVsMC4yMzQzNzUgMS40NTMxMjVxLTAuNjg3NSAwLjE0MDYyNSAtMS4yMzQzNzUgMC4xNDA2MjVxLTAuODkwNjI1IDAgLTEuMzkwNjI1IC0wLjI4MTI1cS0wLjQ4NDM3NSAtMC4yODEyNSAtMC42ODc1IC0wLjczNDM3NXEtMC4yMDMxMjUgLTAuNDY4NzUgLTAuMjAzMTI1IC0xLjkzNzVsMCAtNS41NzgxMjVsLTEuMjAzMTI1IDBsMCAtMS4yNjU2MjVsMS4yMDMxMjUgMGwwIC0yLjM5MDYyNWwxLjYyNSAtMC45ODQzNzVsMCAzLjM3NWwxLjY1NjI1IDBsMCAxLjI2NTYyNWwtMS42NTYyNSAwbDAgNS42NzE4NzVxMCAwLjY4NzUgMC4wNzgxMjUgMC44OTA2MjVxMC4wOTM3NSAwLjIwMzEyNSAwLjI4MTI1IDAuMzI4MTI1cTAuMjAzMTI1IDAuMTA5Mzc1IDAuNTc4MTI1IDAuMTA5Mzc1cTAuMjY1NjI1IDAgMC43MTg3NSAtMC4wNjI1em0xLjY4MzMxOTEgLTcuMTU2MjVsLTAuNDUzMTI1IC0yLjU0Njg3NWwwIC0yLjE4NzVsMS44NTkzNzUgMGwwIDIuMTg3NWwtMC40MDYyNSAyLjU0Njg3NWwtMS4wIDB6bTMuMDE1NjI1IDBsLTAuNDUzMTI1IC0yLjU0Njg3NWwwIC0yLjE4NzVsMS44NzUgMGwwIDIuMTg3NWwtMC40Mzc1IDIuNTQ2ODc1bC0wLjk4NDM3NSAwem02LjI2MzIxNCAxMi4zMjgxMjVsLTMuNjA5Mzc1IDBsMCAtMS4zNTkzNzVsMS45Njg3NSAwbDAgLTE0LjM0Mzc1bC0xLjk2ODc1IDBsMCAtMS4zNTkzNzVsMy42MDkzNzUgMGwwIDE3LjA2MjV6bTMuNTI3MDY5IDAuMjE4NzVsLTEuMTg3NSAwcTIuNzM0Mzc1IC00LjM3NSAyLjczNDM3NSAtOC43NXEwIC0xLjcxODc1IC0wLjM5MDYyNSAtMy4zOTA2MjVxLTAuMzEyNSAtMS4zNzUgLTAuODc1IC0yLjYyNXEtMC4zNTkzNzUgLTAuODI4MTI1IC0xLjQ2ODc1IC0yLjczNDM3NWwxLjE4NzUgMHExLjcwMzEyNSAyLjI4MTI1IDIuNTMxMjUgNC41OTM3NXEwLjY4NzUgMS45ODQzNzUgMC42ODc1IDQuMTQwNjI1cTAgMi40Njg3NSAtMC45Mzc1IDQuNzY1NjI1cS0wLjkzNzUgMi4yOTY4NzUgLTIuMjgxMjUgNC4weiIgZmlsbC1ydWxlPSJub256ZXJvIi8+PHBhdGggZmlsbD0iI2NmZTJmMyIgZD0ibTQ5Mi40NTAxMyAzMDMuMzMzMzRsMTUzLjc3OTU0IDBsMCA5Ni4yMzQ4M2MtNzYuODg5NzcgMCAtNzYuODg5NzcgMzYuNjY3MjM2IC0xNTMuNzc5NTQgMTUuODMzNTg4eiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PHBhdGggc3Ryb2tlPSIjNDM0MzQzIiBzdHJva2Utd2lkdGg9IjMuMCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLWxpbmVjYXA9ImJ1dHQiIGQ9Im00OTIuNDUwMTMgMzAzLjMzMzM0bDE1My43Nzk1NCAwbDAgOTYuMjM0ODNjLTc2Ljg4OTc3IDAgLTc2Ljg4OTc3IDM2LjY2NzIzNiAtMTUzLjc3OTU0IDE1LjgzMzU4OHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIGZpbGw9IiNmNGNjY2MiIGQ9Im01MDguNDUwMTMgMzE5LjMzMzM0bDE1My43Nzk1NCAwbDAgOTYuMjM0ODNjLTc2Ljg4OTc3IDAgLTc2Ljg4OTc3IDM2LjY2NzIzNiAtMTUzLjc3OTU0IDE1LjgzMzU4OHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIHN0cm9rZT0iIzQzNDM0MyIgc3Ryb2tlLXdpZHRoPSIzLjAiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS1saW5lY2FwPSJidXR0IiBkPSJtNTA4LjQ1MDEzIDMxOS4zMzMzNGwxNTMuNzc5NTQgMGwwIDk2LjIzNDgzYy03Ni44ODk3NyAwIC03Ni44ODk3NyAzNi42NjcyMzYgLTE1My43Nzk1NCAxNS44MzM1ODh6IiBmaWxsLXJ1bGU9ImV2ZW5vZGQiLz48cGF0aCBmaWxsPSIjY2ZlMmYzIiBkPSJtNTI0LjQ1MDEzIDMzNS4zMzMzNGwxNTMuNzc5NTQgMGwwIDk2LjIzNDgzYy03Ni44ODk3NyAwIC03Ni44ODk3NyAzNi42NjcyMzYgLTE1My43Nzk1NCAxNS44MzM1ODh6IiBmaWxsLXJ1bGU9ImV2ZW5vZGQiLz48cGF0aCBzdHJva2U9IiM0MzQzNDMiIHN0cm9rZS13aWR0aD0iMy4wIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBzdHJva2UtbGluZWNhcD0iYnV0dCIgZD0ibTUyNC40NTAxMyAzMzUuMzMzMzRsMTUzLjc3OTU0IDBsMCA5Ni4yMzQ4M2MtNzYuODg5NzcgMCAtNzYuODg5NzcgMzYuNjY3MjM2IC0xNTMuNzc5NTQgMTUuODMzNTg4eiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PHBhdGggZmlsbD0iIzAwMDAwMCIgZmlsbC1vcGFjaXR5PSIwLjAiIGQ9Im00NDcuMzQxMTMgNDY0LjIyMDQ2bDI1OC4yMDQ3IDBsMCA1OS43NDgwNDdsLTI1OC4yMDQ3IDB6IiBmaWxsLXJ1bGU9ImV2ZW5vZGQiLz48cGF0aCBmaWxsPSIjMDAwMDAwIiBkPSJtNDU3LjU3NTUgNDkxLjE0MDQ3bDAgLTkuNjcxODc1bDEuNDY4NzUgMGwwIDEuMzU5Mzc1cTAuNDUzMTI1IC0wLjcxODc1IDEuMjAzMTI1IC0xLjE0MDYyNXEwLjc2NTYyNSAtMC40Mzc1IDEuNzE4NzUgLTAuNDM3NXExLjA3ODEyNSAwIDEuNzY1NjI1IDAuNDUzMTI1cTAuNjg3NSAwLjQzNzUgMC45Njg3NSAxLjIzNDM3NXExLjE1NjI1IC0xLjY4NzUgMi45ODQzNzUgLTEuNjg3NXExLjQ1MzEyNSAwIDIuMjE4NzUgMC43OTY4NzVxMC43ODEyNSAwLjc5Njg3NSAwLjc4MTI1IDIuNDUzMTI1bDAgNi42NDA2MjVsLTEuNjQwNjI1IDBsMCAtNi4wOTM3NXEwIC0wLjk4NDM3NSAtMC4xNTYyNSAtMS40MDYyNXEtMC4xNTYyNSAtMC40Mzc1IC0wLjU3ODEyNSAtMC43MDMxMjVxLTAuNDIxODc1IC0wLjI2NTYyNSAtMC45ODQzNzUgLTAuMjY1NjI1cS0xLjAxNTYyNSAwIC0xLjY4NzUgMC42ODc1cS0wLjY3MTg3NSAwLjY3MTg3NSAtMC42NzE4NzUgMi4xNTYyNWwwIDUuNjI1bC0xLjY0MDYyNSAwbDAgLTYuMjgxMjVxMCAtMS4wOTM3NSAtMC40MDYyNSAtMS42NDA2MjVxLTAuNDA2MjUgLTAuNTQ2ODc1IC0xLjMxMjUgLTAuNTQ2ODc1cS0wLjY4NzUgMCAtMS4yODEyNSAwLjM1OTM3NXEtMC41OTM3NSAwLjM1OTM3NSAtMC44NTkzNzUgMS4wNjI1cS0wLjI1IDAuNzAzMTI1IC0wLjI1IDIuMDMxMjVsMCA1LjAxNTYyNWwtMS42NDA2MjUgMHptMjIuMTY1ODAyIC0zLjEwOTM3NWwxLjY4NzUgMC4yMDMxMjVxLTAuNDA2MjUgMS40ODQzNzUgLTEuNDg0Mzc1IDIuMzEyNXEtMS4wNzgxMjUgMC44MTI1IC0yLjc2NTYyNSAwLjgxMjVxLTIuMTI1IDAgLTMuMzc1IC0xLjI5Njg3NXEtMS4yMzQzNzUgLTEuMzEyNSAtMS4yMzQzNzUgLTMuNjcxODc1cTAgLTIuNDUzMTI1IDEuMjUgLTMuNzk2ODc1cTEuMjY1NjI1IC0xLjM0Mzc1IDMuMjY1NjI1IC0xLjM0Mzc1cTEuOTM3NSAwIDMuMTU2MjUgMS4zMjgxMjVxMS4yMzQzNzUgMS4zMTI1IDEuMjM0Mzc1IDMuNzAzMTI1cTAgMC4xNTYyNSAwIDAuNDM3NWwtNy4yMTg3NSAwcTAuMDkzNzUgMS41OTM3NSAwLjkwNjI1IDIuNDUzMTI1cTAuODEyNSAwLjg0Mzc1IDIuMDE1NjI1IDAuODQzNzVxMC45MDYyNSAwIDEuNTQ2ODc1IC0wLjQ2ODc1cTAuNjQwNjI1IC0wLjQ4NDM3NSAxLjAxNTYyNSAtMS41MTU2MjV6bS01LjM5MDYyNSAtMi42NTYyNWw1LjQwNjI1IDBxLTAuMTA5Mzc1IC0xLjIxODc1IC0wLjYyNSAtMS44MjgxMjVxLTAuNzgxMjUgLTAuOTUzMTI1IC0yLjAzMTI1IC0wLjk1MzEyNXEtMS4xMjUgMCAtMS45MDYyNSAwLjc2NTYyNXEtMC43NjU2MjUgMC43NSAtMC44NDM3NSAyLjAxNTYyNXptMTIuNzE5NDUyIDQuMjk2ODc1bDAuMjM0Mzc1IDEuNDUzMTI1cS0wLjY4NzUgMC4xNDA2MjUgLTEuMjM0Mzc1IDAuMTQwNjI1cS0wLjg5MDYyNSAwIC0xLjM5MDYyNSAtMC4yODEyNXEtMC40ODQzNzUgLTAuMjgxMjUgLTAuNjg3NSAtMC43MzQzNzVxLTAuMjAzMTI1IC0wLjQ2ODc1IC0wLjIwMzEyNSAtMS45Mzc1bDAgLTUuNTc4MTI1bC0xLjIwMzEyNSAwbDAgLTEuMjY1NjI1bDEuMjAzMTI1IDBsMCAtMi4zOTA2MjVsMS42MjUgLTAuOTg0Mzc1bDAgMy4zNzVsMS42NTYyNSAwbDAgMS4yNjU2MjVsLTEuNjU2MjUgMGwwIDUuNjcxODc1cTAgMC42ODc1IDAuMDc4MTI1IDAuODkwNjI1cTAuMDkzNzUgMC4yMDMxMjUgMC4yODEyNSAwLjMyODEyNXEwLjIwMzEyNSAwLjEwOTM3NSAwLjU3ODEyNSAwLjEwOTM3NXEwLjI2NTYyNSAwIDAuNzE4NzUgLTAuMDYyNXptNy45MTc2OTQgMC4yODEyNXEtMC45MjE4NzUgMC43NjU2MjUgLTEuNzY1NjI1IDEuMDkzNzVxLTAuODI4MTI1IDAuMzEyNSAtMS43OTY4NzUgMC4zMTI1cS0xLjU5Mzc1IDAgLTIuNDUzMTI1IC0wLjc4MTI1cS0wLjg1OTM3NSAtMC43ODEyNSAtMC44NTkzNzUgLTEuOTg0Mzc1cTAgLTAuNzE4NzUgMC4zMjgxMjUgLTEuMjk2ODc1cTAuMzI4MTI1IC0wLjU5Mzc1IDAuODQzNzUgLTAuOTM3NXEwLjUzMTI1IC0wLjM1OTM3NSAxLjE4NzUgLTAuNTQ2ODc1cTAuNDY4NzUgLTAuMTI1IDEuNDUzMTI1IC0wLjI1cTEuOTg0Mzc1IC0wLjIzNDM3NSAyLjkyMTg3NSAtMC41NjI1cTAuMDE1NjI1IC0wLjM0Mzc1IDAuMDE1NjI1IC0wLjQyMTg3NXEwIC0xLjAgLTAuNDY4NzUgLTEuNDIxODc1cS0wLjYyNSAtMC41NDY4NzUgLTEuODc1IC0wLjU0Njg3NXEtMS4xNTYyNSAwIC0xLjcwMzEyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjgxMjUgMS40MjE4NzVsLTEuNjA5Mzc1IC0wLjIxODc1cTAuMjE4NzUgLTEuMDE1NjI1IDAuNzE4NzUgLTEuNjQwNjI1cTAuNSAtMC42NDA2MjUgMS40NTMxMjUgLTAuOTg0Mzc1cTAuOTUzMTI1IC0wLjM0Mzc1IDIuMTg3NSAtMC4zNDM3NXExLjI1IDAgMi4wMTU2MjUgMC4yOTY4NzVxMC43ODEyNSAwLjI4MTI1IDEuMTQwNjI1IDAuNzM0Mzc1cTAuMzc1IDAuNDM3NSAwLjUxNTYyNSAxLjEwOTM3NXEwLjA3ODEyNSAwLjQyMTg3NSAwLjA3ODEyNSAxLjUxNTYyNWwwIDIuMTg3NXEwIDIuMjgxMjUgMC4xMDkzNzUgMi44OTA2MjVxMC4xMDkzNzUgMC41OTM3NSAwLjQwNjI1IDEuMTU2MjVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzUgMS40NTMxMjUgMC40Mzc1cTAuOTM3NSAwIDEuNjcxODc1IC0wLjQwNjI1cTAuNzUgLTAuNDIxODc1IDEuMDkzNzUgLTEuMTQwNjI1cTAuMjY1NjI1IC0wLjU2MjUgMC4yNjU2MjUgLTEuNjQwNjI1bDAgLTAuNjA5Mzc1em0xMC40Njk0NTIgNC44NTkzNzVsMCAtMS4yMTg3NXEtMC45MDYyNSAxLjQzNzUgLTIuNzAzMTI1IDEuNDM3NXEtMS4xNTYyNSAwIC0yLjEyNSAtMC42NDA2MjVxLTAuOTY4NzUgLTAuNjQwNjI1IC0xLjUgLTEuNzgxMjVxLTAuNTMxMjUgLTEuMTQwNjI1IC0wLjUzMTI1IC0yLjYyNXEwIC0xLjQ1MzEyNSAwLjQ4NDM3NSAtMi42MjVxMC40ODQzNzUgLTEuMTg3NSAxLjQzNzUgLTEuODEyNXEwLjk2ODc1IC0wLjYyNSAyLjE3MTg3NSAtMC42MjVxMC44NzUgMCAxLjU0Njg3NSAwLjM3NXEwLjY4NzUgMC4zNTkzNzUgMS4xMDkzNzUgMC45NTMxMjVsMCAtNC43OTY4NzVsMS42NDA2MjUgMGwwIDEzLjM1OTM3NWwtMS41MzEyNSAwem0tNS4xNzE4NzUgLTQuODI4MTI1cTAgMS44NTkzNzUgMC43ODEyNSAyLjc4MTI1cTAuNzgxMjUgMC45MjE4NzUgMS44NDM3NSAwLjkyMTg3NXExLjA3ODEyNSAwIDEuODI4MTI1IC0wLjg3NXEwLjc1IC0wLjg5MDYyNSAwLjc1IC0yLjY4NzVxMCAtMS45ODQzNzUgLTAuNzY1NjI1IC0yLjkwNjI1cS0wLjc2NTYyNSAtMC45Mzc1IC0xLjg5MDYyNSAtMC45Mzc1cS0xLjA3ODEyNSAwIC0xLjgxMjUgMC44OTA2MjVxLTAuNzM0Mzc1IDAuODkwNjI1IC0wLjczNDM3NSAyLjgxMjV6bTE1LjU5NDQ4MiAzLjY0MDYyNXEtMC45MjE4NzUgMC43NjU2MjUgLTEuNzY1NjI1IDEuMDkzNzVxLTAuODI4MTI1IDAuMzEyNSAtMS43OTY4NzUgMC4zMTI1cS0xLjU5Mzc1IDAgLTIuNDUzMTI1IC0wLjc4MTI1cS0wLjg1OTM3NSAtMC43ODEyNSAtMC44NTkzNzUgLTEuOTg0Mzc1cTAgLTAuNzE4NzUgMC4zMjgxMjUgLTEuMjk2ODc1cTAuMzI4MTI1IC0wLjU5Mzc1IDAuODQzNzUgLTAuOTM3NXEwLjUzMTI1IC0wLjM1OTM3NSAxLjE4NzUgLTAuNTQ2ODc1cTAuNDY4NzUgLTAuMTI1IDEuNDUzMTI1IC0wLjI1cTEuOTg0Mzc1IC0wLjIzNDM3NSAyLjkyMTg3NSAtMC41NjI1cTAuMDE1NjI1IC0wLjM0Mzc1IDAuMDE1NjI1IC0wLjQyMTg3NXEwIC0xLjAgLTAuNDY4NzUgLTEuNDIxODc1cS0wLjYyNSAtMC41NDY4NzUgLTEuODc1IC0wLjU0Njg3NXEtMS4xNTYyNSAwIC0xLjcwMzEyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjgxMjUgMS40MjE4NzVsLTEuNjA5Mzc1IC0wLjIxODc1cTAuMjE4NzUgLTEuMDE1NjI1IDAuNzE4NzUgLTEuNjQwNjI1cTAuNSAtMC42NDA2MjUgMS40NTMxMjUgLTAuOTg0Mzc1cTAuOTUzMTI1IC0wLjM0Mzc1IDIuMTg3NSAtMC4zNDM3NXExLjI1IDAgMi4wMTU2MjUgMC4yOTY4NzVxMC43ODEyNSAwLjI4MTI1IDEuMTQwNjI1IDAuNzM0Mzc1cTAuMzc1IDAuNDM3NSAwLjUxNTYyNSAxLjEwOTM3NXEwLjA3ODEyNSAwLjQyMTg3NSAwLjA3ODEyNSAxLjUxNTYyNWwwIDIuMTg3NXEwIDIuMjgxMjUgMC4xMDkzNzUgMi44OTA2MjVxMC4xMDkzNzUgMC41OTM3NSAwLjQwNjI1IDEuMTU2MjVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzUgMS40NTMxMjUgMC40Mzc1cTAuOTM3NSAwIDEuNjcxODc1IC0wLjQwNjI1cTAuNzUgLTAuNDIxODc1IDEuMDkzNzUgLTEuMTQwNjI1cTAuMjY1NjI1IC0wLjU2MjUgMC4yNjU2MjUgLTEuNjQwNjI1bDAgLTAuNjA5Mzc1em03Ljc4MTk4MjQgMy4zOTA2MjVsMC4yMzQzNzUgMS40NTMxMjVxLTAuNjg3NSAwLjE0MDYyNSAtMS4yMzQzNzUgMC4xNDA2MjVxLTAuODkwNjI1IDAgLTEuMzkwNjI1IC0wLjI4MTI1cS0wLjQ4NDM3NSAtMC4yODEyNSAtMC42ODc1IC0wLjczNDM3NXEtMC4yMDMxMjUgLTAuNDY4NzUgLTAuMjAzMTI1IC0xLjkzNzVsMCAtNS41NzgxMjVsLTEuMjAzMTI1IDBsMCAtMS4yNjU2MjVsMS4yMDMxMjUgMGwwIC0yLjM5MDYyNWwxLjYyNSAtMC45ODQzNzVsMCAzLjM3NWwxLjY1NjI1IDBsMCAxLjI2NTYyNWwtMS42NTYyNSAwbDAgNS42NzE4NzVxMCAwLjY4NzUgMC4wNzgxMjUgMC44OTA2MjVxMC4wOTM3NSAwLjIwMzEyNSAwLjI4MTI1IDAuMzI4MTI1cTAuMjAzMTI1IDAuMTA5Mzc1IDAuNTc4MTI1IDAuMTA5Mzc1cTAuMjY1NjI1IDAgMC43MTg3NSAtMC4wNjI1em03LjkxNzY2MzYgMC4yODEyNXEtMC45MjE4NzUgMC43NjU2MjUgLTEuNzY1NjI1IDEuMDkzNzVxLTAuODI4MTI1IDAuMzEyNSAtMS43OTY4NzUgMC4zMTI1cS0xLjU5Mzc1IDAgLTIuNDUzMTI1IC0wLjc4MTI1cS0wLjg1OTM3NSAtMC43ODEyNSAtMC44NTkzNzUgLTEuOTg0Mzc1cTAgLTAuNzE4NzUgMC4zMjgxMjUgLTEuMjk2ODc1cTAuMzI4MTI1IC0wLjU5Mzc1IDAuODQzNzUgLTAuOTM3NXEwLjUzMTI1IC0wLjM1OTM3NSAxLjE4NzUgLTAuNTQ2ODc1cTAuNDY4NzUgLTAuMTI1IDEuNDUzMTI1IC0wLjI1cTEuOTg0Mzc1IC0wLjIzNDM3NSAyLjkyMTg3NSAtMC41NjI1cTAuMDE1NjI1IC0wLjM0Mzc1IDAuMDE1NjI1IC0wLjQyMTg3NXEwIC0xLjAgLTAuNDY4NzUgLTEuNDIxODc1cS0wLjYyNSAtMC41NDY4NzUgLTEuODc1IC0wLjU0Njg3NXEtMS4xNTYyNSAwIC0xLjcwMzEyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjgxMjUgMS40MjE4NzVsLTEuNjA5Mzc1IC0wLjIxODc1cTAuMjE4NzUgLTEuMDE1NjI1IDAuNzE4NzUgLTEuNjQwNjI1cTAuNSAtMC42NDA2MjUgMS40NTMxMjUgLTAuOTg0Mzc1cTAuOTUzMTI1IC0wLjM0Mzc1IDIuMTg3NSAtMC4zNDM3NXExLjI1IDAgMi4wMTU2MjUgMC4yOTY4NzVxMC43ODEyNSAwLjI4MTI1IDEuMTQwNjI1IDAuNzM0Mzc1cTAuMzc1IDAuNDM3NSAwLjUxNTYyNSAxLjEwOTM3NXEwLjA3ODEyNSAwLjQyMTg3NSAwLjA3ODEyNSAxLjUxNTYyNWwwIDIuMTg3NXEwIDIuMjgxMjUgMC4xMDkzNzUgMi44OTA2MjVxMC4xMDkzNzUgMC41OTM3NSAwLjQwNjI1IDEuMTU2MjVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzUgMS40NTMxMjUgMC40Mzc1cTAuOTM3NSAwIDEuNjcxODc1IC0wLjQwNjI1cTAuNzUgLTAuNDIxODc1IDEuMDkzNzUgLTEuMTQwNjI1cTAuMjY1NjI1IC0wLjU2MjUgMC4yNjU2MjUgLTEuNjQwNjI1bDAgLTAuNjA5Mzc1em03LjMyODg1NzQgOC43ODEyNXEtMS4zNTkzNzUgLTEuNzAzMTI1IC0yLjI5Njg3NSAtNC4wcS0wLjkzNzUgLTIuMjk2ODc1IC0wLjkzNzUgLTQuNzY1NjI1cTAgLTIuMTU2MjUgMC43MDMxMjUgLTQuMTQwNjI1cTAuODI4MTI1IC0yLjMxMjUgMi41MzEyNSAtNC41OTM3NWwxLjE3MTg3NSAwcS0xLjA5Mzc1IDEuODkwNjI1IC0xLjQ1MzEyNSAyLjcwMzEyNXEtMC41NDY4NzUgMS4yNSAtMC44NzUgMi42MjVxLTAuMzkwNjI1IDEuNzAzMTI1IC0wLjM5MDYyNSAzLjQyMTg3NXEwIDQuMzc1IDIuNzE4NzUgOC43NWwtMS4xNzE4NzUgMHptMi40MzEzOTY1IC02LjgxMjVsMS42MjUgLTAuMjVxMC4xMjUgMC45Njg3NSAwLjc1IDEuNXEwLjYyNSAwLjUxNTYyNSAxLjc1IDAuNTE1NjI1cTEuMTI1IDAgMS42NzE4NzUgLTAuNDUzMTI1cTAuNTQ2ODc1IC0wLjQ2ODc1IDAuNTQ2ODc1IC0xLjA5Mzc1cTAgLTAuNTQ2ODc1IC0wLjQ4NDM3NSAtMC44NzVxLTAuMzI4MTI1IC0wLjIxODc1IC0xLjY3MTg3NSAtMC41NDY4NzVxLTEuODEyNSAtMC40Njg3NSAtMi41MTU2MjUgLTAuNzk2ODc1cS0wLjY4NzUgLTAuMzI4MTI1IC0xLjA0Njg3NSAtMC45MDYyNXEtMC4zNTkzNzUgLTAuNTkzNzUgLTAuMzU5Mzc1IC0xLjMxMjVxMCAtMC42NDA2MjUgMC4yOTY4NzUgLTEuMTg3NXEwLjI5Njg3NSAtMC41NjI1IDAuODEyNSAtMC45MjE4NzVxMC4zNzUgLTAuMjgxMjUgMS4wMzEyNSAtMC40Njg3NXEwLjY3MTg3NSAtMC4yMDMxMjUgMS40MjE4NzUgLTAuMjAzMTI1cTEuMTQwNjI1IDAgMi4wIDAuMzI4MTI1cTAuODU5Mzc1IDAuMzI4MTI1IDEuMjY1NjI1IDAuODkwNjI1cTAuNDIxODc1IDAuNTYyNSAwLjU3ODEyNSAxLjVsLTEuNjA5Mzc1IDAuMjE4NzVxLTAuMTA5Mzc1IC0wLjc1IC0wLjY0MDYyNSAtMS4xNzE4NzVxLTAuNTE1NjI1IC0wLjQyMTg3NSAtMS40Njg3NSAtMC40MjE4NzVxLTEuMTQwNjI1IDAgLTEuNjI1IDAuMzc1cS0wLjQ2ODc1IDAuMzc1IC0wLjQ2ODc1IDAuODc1cTAgMC4zMTI1IDAuMTg3NSAwLjU3ODEyNXEwLjIwMzEyNSAwLjI2NTYyNSAwLjY0MDYyNSAwLjQzNzVxMC4yMzQzNzUgMC4wOTM3NSAxLjQzNzUgMC40MjE4NzVxMS43NSAwLjQ1MzEyNSAyLjQzNzUgMC43NXEwLjY4NzUgMC4yOTY4NzUgMS4wNzgxMjUgMC44NTkzNzVxMC4zOTA2MjUgMC41NjI1IDAuMzkwNjI1IDEuNDA2MjVxMCAwLjgyODEyNSAtMC40ODQzNzUgMS41NDY4NzVxLTAuNDY4NzUgMC43MTg3NSAtMS4zNzUgMS4xMjVxLTAuOTA2MjUgMC4zOTA2MjUgLTIuMDQ2ODc1IDAuMzkwNjI1cS0xLjg3NSAwIC0yLjg3NSAtMC43ODEyNXEtMC45ODQzNzUgLTAuNzgxMjUgLTEuMjUgLTIuMzI4MTI1em0xNi42MDkzNzUgLTAuMjE4NzVsMS42ODc1IDAuMjAzMTI1cS0wLjQwNjI1IDEuNDg0Mzc1IC0xLjQ4NDM3NSAyLjMxMjVxLTEuMDc4MTI1IDAuODEyNSAtMi43NjU2MjUgMC44MTI1cS0yLjEyNSAwIC0zLjM3NSAtMS4yOTY4NzVxLTEuMjM0Mzc1IC0xLjMxMjUgLTEuMjM0Mzc1IC0zLjY3MTg3NXEwIC0yLjQ1MzEyNSAxLjI1IC0zLjc5Njg3NXExLjI2NTYyNSAtMS4zNDM3NSAzLjI2NTYyNSAtMS4zNDM3NXExLjkzNzUgMCAzLjE1NjI1IDEuMzI4MTI1cTEuMjM0Mzc1IDEuMzEyNSAxLjIzNDM3NSAzLjcwMzEyNXEwIDAuMTU2MjUgMCAwLjQzNzVsLTcuMjE4NzUgMHEwLjA5Mzc1IDEuNTkzNzUgMC45MDYyNSAyLjQ1MzEyNXEwLjgxMjUgMC44NDM3NSAyLjAxNTYyNSAwLjg0Mzc1cTAuOTA2MjUgMCAxLjU0Njg3NSAtMC40Njg3NXEwLjY0MDYyNSAtMC40ODQzNzUgMS4wMTU2MjUgLTEuNTE1NjI1em0tNS4zOTA2MjUgLTIuNjU2MjVsNS40MDYyNSAwcS0wLjEwOTM3NSAtMS4yMTg3NSAtMC42MjUgLTEuODI4MTI1cS0wLjc4MTI1IC0wLjk1MzEyNSAtMi4wMzEyNSAtMC45NTMxMjVxLTEuMTI1IDAgLTEuOTA2MjUgMC43NjU2MjVxLTAuNzY1NjI1IDAuNzUgLTAuODQzNzUgMi4wMTU2MjV6bTEwLjIxOTQ4MiA5LjY4NzVsLTEuMTg3NSAwcTIuNzM0Mzc1IC00LjM3NSAyLjczNDM3NSAtOC43NXEwIC0xLjcxODc1IC0wLjM5MDYyNSAtMy4zOTA2MjVxLTAuMzEyNSAtMS4zNzUgLTAuODc1IC0yLjYyNXEtMC4zNTkzNzUgLTAuODI4MTI1IC0xLjQ2ODc1IC0yLjczNDM3NWwxLjE4NzUgMHExLjcwMzEyNSAyLjI4MTI1IDIuNTMxMjUgNC41OTM3NXEwLjY4NzUgMS45ODQzNzUgMC42ODc1IDQuMTQwNjI1cTAgMi40Njg3NSAtMC45Mzc1IDQuNzY1NjI1cS0wLjkzNzUgMi4yOTY4NzUgLTIuMjgxMjUgNC4weiIgZmlsbC1ydWxlPSJub256ZXJvIi8+PHBhdGggZmlsbD0iI2NjMDAwMCIgZD0ibTQ1Ny41NzU1IDUxMy4xNDA0NGwwIC05LjY3MTg0NDVsMS40Njg3NSAwbDAgMS4zNTkzNzVxMC40NTMxMjUgLTAuNzE4NzUgMS4yMDMxMjUgLTEuMTQwNjI1cTAuNzY1NjI1IC0wLjQzNzUgMS43MTg3NSAtMC40Mzc1cTEuMDc4MTI1IDAgMS43NjU2MjUgMC40NTMxMjVxMC42ODc1IDAuNDM3NSAwLjk2ODc1IDEuMjM0Mzc1cTEuMTU2MjUgLTEuNjg3NSAyLjk4NDM3NSAtMS42ODc1cTEuNDUzMTI1IDAgMi4yMTg3NSAwLjc5Njg3NXEwLjc4MTI1IDAuNzk2ODc1IDAuNzgxMjUgMi40NTMxMjVsMCA2LjY0MDU5NDVsLTEuNjQwNjI1IDBsMCAtNi4wOTM3MTk1cTAgLTAuOTg0Mzc1IC0wLjE1NjI1IC0xLjQwNjI1cS0wLjE1NjI1IC0wLjQzNzUgLTAuNTc4MTI1IC0wLjcwMzEyNXEtMC40MjE4NzUgLTAuMjY1NjI1IC0wLjk4NDM3NSAtMC4yNjU2MjVxLTEuMDE1NjI1IDAgLTEuNjg3NSAwLjY4NzVxLTAuNjcxODc1IDAuNjcxODc1IC0wLjY3MTg3NSAyLjE1NjI1bDAgNS42MjQ5Njk1bC0xLjY0MDYyNSAwbDAgLTYuMjgxMjE5NXEwIC0xLjA5Mzc1IC0wLjQwNjI1IC0xLjY0MDYyNXEtMC40MDYyNSAtMC41NDY4NzUgLTEuMzEyNSAtMC41NDY4NzVxLTAuNjg3NSAwIC0xLjI4MTI1IDAuMzU5Mzc1cS0wLjU5Mzc1IDAuMzU5Mzc1IC0wLjg1OTM3NSAxLjA2MjVxLTAuMjUgMC43MDMxMjUgLTAuMjUgMi4wMzEyNWwwIDUuMDE1NTk0NWwtMS42NDA2MjUgMHptMjIuMTY1ODAyIC0zLjEwOTM0NDVsMS42ODc1IDAuMjAzMTI1cS0wLjQwNjI1IDEuNDg0Mzc1IC0xLjQ4NDM3NSAyLjMxMjQ2OTVxLTEuMDc4MTI1IDAuODEyNSAtMi43NjU2MjUgMC44MTI1cS0yLjEyNSAwIC0zLjM3NSAtMS4yOTY4NzVxLTEuMjM0Mzc1IC0xLjMxMjQ2OTUgLTEuMjM0Mzc1IC0zLjY3MTg0NDVxMCAtMi40NTMxMjUgMS4yNSAtMy43OTY4NzVxMS4yNjU2MjUgLTEuMzQzNzUgMy4yNjU2MjUgLTEuMzQzNzVxMS45Mzc1IDAgMy4xNTYyNSAxLjMyODEyNXExLjIzNDM3NSAxLjMxMjUgMS4yMzQzNzUgMy43MDMxMjVxMCAwLjE1NjI1IDAgMC40Mzc1bC03LjIxODc1IDBxMC4wOTM3NSAxLjU5Mzc1IDAuOTA2MjUgMi40NTMxMjVxMC44MTI1IDAuODQzNzE5NSAyLjAxNTYyNSAwLjg0MzcxOTVxMC45MDYyNSAwIDEuNTQ2ODc1IC0wLjQ2ODcxOTQ4cTAuNjQwNjI1IC0wLjQ4NDM3NSAxLjAxNTYyNSAtMS41MTU2MjV6bS01LjM5MDYyNSAtMi42NTYyNWw1LjQwNjI1IDBxLTAuMTA5Mzc1IC0xLjIxODc1IC0wLjYyNSAtMS44MjgxMjVxLTAuNzgxMjUgLTAuOTUzMTI1IC0yLjAzMTI1IC0wLjk1MzEyNXEtMS4xMjUgMCAtMS45MDYyNSAwLjc2NTYyNXEtMC43NjU2MjUgMC43NSAtMC44NDM3NSAyLjAxNTYyNXptMTIuNzE5NDUyIDQuMjk2ODc1bDAuMjM0Mzc1IDEuNDUzMDk0NXEtMC42ODc1IDAuMTQwNjI1IC0xLjIzNDM3NSAwLjE0MDYyNXEtMC44OTA2MjUgMCAtMS4zOTA2MjUgLTAuMjgxMjVxLTAuNDg0Mzc1IC0wLjI4MTI1IC0wLjY4NzUgLTAuNzM0Mzc1cS0wLjIwMzEyNSAtMC40Njg3MTk0OCAtMC4yMDMxMjUgLTEuOTM3NDY5NWwwIC01LjU3ODEyNWwtMS4yMDMxMjUgMGwwIC0xLjI2NTYyNWwxLjIwMzEyNSAwbDAgLTIuMzkwNjI1bDEuNjI1IC0wLjk4NDM3NWwwIDMuMzc1bDEuNjU2MjUgMGwwIDEuMjY1NjI1bC0xLjY1NjI1IDBsMCA1LjY3MTg3NXEwIDAuNjg3NSAwLjA3ODEyNSAwLjg5MDYyNXEwLjA5Mzc1IDAuMjAzMTI1IDAuMjgxMjUgMC4zMjgxMjVxMC4yMDMxMjUgMC4xMDkzNzUgMC41NzgxMjUgMC4xMDkzNzVxMC4yNjU2MjUgMCAwLjcxODc1IC0wLjA2MjV6bTcuOTE3Njk0IDAuMjgxMjVxLTAuOTIxODc1IDAuNzY1NTk0NSAtMS43NjU2MjUgMS4wOTM3MTk1cS0wLjgyODEyNSAwLjMxMjUgLTEuNzk2ODc1IDAuMzEyNXEtMS41OTM3NSAwIC0yLjQ1MzEyNSAtMC43ODEyNXEtMC44NTkzNzUgLTAuNzgxMjE5NSAtMC44NTkzNzUgLTEuOTg0MzQ0NXEwIC0wLjcxODc1IDAuMzI4MTI1IC0xLjI5Njg3NXEwLjMyODEyNSAtMC41OTM3NSAwLjg0Mzc1IC0wLjkzNzVxMC41MzEyNSAtMC4zNTkzNzUgMS4xODc1IC0wLjU0Njg3NXEwLjQ2ODc1IC0wLjEyNSAxLjQ1MzEyNSAtMC4yNXExLjk4NDM3NSAtMC4yMzQzNzUgMi45MjE4NzUgLTAuNTYyNXEwLjAxNTYyNSAtMC4zNDM3NSAwLjAxNTYyNSAtMC40MjE4NzVxMCAtMS4wIC0wLjQ2ODc1IC0xLjQyMTg3NXEtMC42MjUgLTAuNTQ2ODc1IC0xLjg3NSAtMC41NDY4NzVxLTEuMTU2MjUgMCAtMS43MDMxMjUgMC40MDYyNXEtMC41NDY4NzUgMC40MDYyNSAtMC44MTI1IDEuNDIxODc1bC0xLjYwOTM3NSAtMC4yMTg3NXEwLjIxODc1IC0xLjAxNTYyNSAwLjcxODc1IC0xLjY0MDYyNXEwLjUgLTAuNjQwNjI1IDEuNDUzMTI1IC0wLjk4NDM3NXEwLjk1MzEyNSAtMC4zNDM3NSAyLjE4NzUgLTAuMzQzNzVxMS4yNSAwIDIuMDE1NjI1IDAuMjk2ODc1cTAuNzgxMjUgMC4yODEyNSAxLjE0MDYyNSAwLjczNDM3NXEwLjM3NSAwLjQzNzUgMC41MTU2MjUgMS4xMDkzNzVxMC4wNzgxMjUgMC40MjE4NzUgMC4wNzgxMjUgMS41MTU2MjVsMCAyLjE4NzVxMCAyLjI4MTI1IDAuMTA5Mzc1IDIuODkwNjI1cTAuMTA5Mzc1IDAuNTkzNzE5NSAwLjQwNjI1IDEuMTU2MjE5NWwtMS43MDMxMjUgMHEtMC4yNjU2MjUgLTAuNTE1NjI1IC0wLjMyODEyNSAtMS4xODc0Njk1em0tMC4xNDA2MjUgLTMuNjcxODc1cS0wLjg5MDYyNSAwLjM3NSAtMi42NzE4NzUgMC42MjVxLTEuMDE1NjI1IDAuMTQwNjI1IC0xLjQzNzUgMC4zMjgxMjVxLTAuNDIxODc1IDAuMTg3NSAtMC42NTYyNSAwLjUzMTI1cS0wLjIxODc1IDAuMzQzNzUgLTAuMjE4NzUgMC43ODEyNXEwIDAuNjU2MjUgMC41IDEuMDkzNzVxMC41IDAuNDM3NDY5NDggMS40NTMxMjUgMC40Mzc0Njk0OHEwLjkzNzUgMCAxLjY3MTg3NSAtMC40MDYyMTk0OHEwLjc1IC0wLjQyMTg3NSAxLjA5Mzc1IC0xLjE0MDYyNXEwLjI2NTYyNSAtMC41NjI1IDAuMjY1NjI1IC0xLjY0MDYyNWwwIC0wLjYwOTM3NXptMTAuNDY5NDUyIDQuODU5MzQ0NWwwIC0xLjIxODcxOTVxLTAuOTA2MjUgMS40Mzc0Njk1IC0yLjcwMzEyNSAxLjQzNzQ2OTVxLTEuMTU2MjUgMCAtMi4xMjUgLTAuNjQwNjI1cS0wLjk2ODc1IC0wLjY0MDYyNSAtMS41IC0xLjc4MTIxOTVxLTAuNTMxMjUgLTEuMTQwNjI1IC0wLjUzMTI1IC0yLjYyNXEwIC0xLjQ1MzEyNSAwLjQ4NDM3NSAtMi42MjVxMC40ODQzNzUgLTEuMTg3NSAxLjQzNzUgLTEuODEyNXEwLjk2ODc1IC0wLjYyNSAyLjE3MTg3NSAtMC42MjVxMC44NzUgMCAxLjU0Njg3NSAwLjM3NXEwLjY4NzUgMC4zNTkzNzUgMS4xMDkzNzUgMC45NTMxMjVsMCAtNC43OTY4NzVsMS42NDA2MjUgMGwwIDEzLjM1OTM0NDVsLTEuNTMxMjUgMHptLTUuMTcxODc1IC00LjgyODA5NDVxMCAxLjg1OTM3NSAwLjc4MTI1IDIuNzgxMjVxMC43ODEyNSAwLjkyMTg0NDUgMS44NDM3NSAwLjkyMTg0NDVxMS4wNzgxMjUgMCAxLjgyODEyNSAtMC44NzQ5Njk1cTAuNzUgLTAuODkwNjI1IDAuNzUgLTIuNjg3NXEwIC0xLjk4NDM3NSAtMC43NjU2MjUgLTIuOTA2MjVxLTAuNzY1NjI1IC0wLjkzNzUgLTEuODkwNjI1IC0wLjkzNzVxLTEuMDc4MTI1IDAgLTEuODEyNSAwLjg5MDYyNXEtMC43MzQzNzUgMC44OTA2MjUgLTAuNzM0Mzc1IDIuODEyNXptMTUuNTk0NDgyIDMuNjQwNjI1cS0wLjkyMTg3NSAwLjc2NTU5NDUgLTEuNzY1NjI1IDEuMDkzNzE5NXEtMC44MjgxMjUgMC4zMTI1IC0xLjc5Njg3NSAwLjMxMjVxLTEuNTkzNzUgMCAtMi40NTMxMjUgLTAuNzgxMjVxLTAuODU5Mzc1IC0wLjc4MTIxOTUgLTAuODU5Mzc1IC0xLjk4NDM0NDVxMCAtMC43MTg3NSAwLjMyODEyNSAtMS4yOTY4NzVxMC4zMjgxMjUgLTAuNTkzNzUgMC44NDM3NSAtMC45Mzc1cTAuNTMxMjUgLTAuMzU5Mzc1IDEuMTg3NSAtMC41NDY4NzVxMC40Njg3NSAtMC4xMjUgMS40NTMxMjUgLTAuMjVxMS45ODQzNzUgLTAuMjM0Mzc1IDIuOTIxODc1IC0wLjU2MjVxMC4wMTU2MjUgLTAuMzQzNzUgMC4wMTU2MjUgLTAuNDIxODc1cTAgLTEuMCAtMC40Njg3NSAtMS40MjE4NzVxLTAuNjI1IC0wLjU0Njg3NSAtMS44NzUgLTAuNTQ2ODc1cS0xLjE1NjI1IDAgLTEuNzAzMTI1IDAuNDA2MjVxLTAuNTQ2ODc1IDAuNDA2MjUgLTAuODEyNSAxLjQyMTg3NWwtMS42MDkzNzUgLTAuMjE4NzVxMC4yMTg3NSAtMS4wMTU2MjUgMC43MTg3NSAtMS42NDA2MjVxMC41IC0wLjY0MDYyNSAxLjQ1MzEyNSAtMC45ODQzNzVxMC45NTMxMjUgLTAuMzQzNzUgMi4xODc1IC0wLjM0Mzc1cTEuMjUgMCAyLjAxNTYyNSAwLjI5Njg3NXEwLjc4MTI1IDAuMjgxMjUgMS4xNDA2MjUgMC43MzQzNzVxMC4zNzUgMC40Mzc1IDAuNTE1NjI1IDEuMTA5Mzc1cTAuMDc4MTI1IDAuNDIxODc1IDAuMDc4MTI1IDEuNTE1NjI1bDAgMi4xODc1cTAgMi4yODEyNSAwLjEwOTM3NSAyLjg5MDYyNXEwLjEwOTM3NSAwLjU5MzcxOTUgMC40MDYyNSAxLjE1NjIxOTVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NDY5NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzQ2OTQ4IDEuNDUzMTI1IDAuNDM3NDY5NDhxMC45Mzc1IDAgMS42NzE4NzUgLTAuNDA2MjE5NDhxMC43NSAtMC40MjE4NzUgMS4wOTM3NSAtMS4xNDA2MjVxMC4yNjU2MjUgLTAuNTYyNSAwLjI2NTYyNSAtMS42NDA2MjVsMCAtMC42MDkzNzV6bTcuNzgxOTgyNCAzLjM5MDYyNWwwLjIzNDM3NSAxLjQ1MzA5NDVxLTAuNjg3NSAwLjE0MDYyNSAtMS4yMzQzNzUgMC4xNDA2MjVxLTAuODkwNjI1IDAgLTEuMzkwNjI1IC0wLjI4MTI1cS0wLjQ4NDM3NSAtMC4yODEyNSAtMC42ODc1IC0wLjczNDM3NXEtMC4yMDMxMjUgLTAuNDY4NzE5NDggLTAuMjAzMTI1IC0xLjkzNzQ2OTVsMCAtNS41NzgxMjVsLTEuMjAzMTI1IDBsMCAtMS4yNjU2MjVsMS4yMDMxMjUgMGwwIC0yLjM5MDYyNWwxLjYyNSAtMC45ODQzNzVsMCAzLjM3NWwxLjY1NjI1IDBsMCAxLjI2NTYyNWwtMS42NTYyNSAwbDAgNS42NzE4NzVxMCAwLjY4NzUgMC4wNzgxMjUgMC44OTA2MjVxMC4wOTM3NSAwLjIwMzEyNSAwLjI4MTI1IDAuMzI4MTI1cTAuMjAzMTI1IDAuMTA5Mzc1IDAuNTc4MTI1IDAuMTA5Mzc1cTAuMjY1NjI1IDAgMC43MTg3NSAtMC4wNjI1em03LjkxNzY2MzYgMC4yODEyNXEtMC45MjE4NzUgMC43NjU1OTQ1IC0xLjc2NTYyNSAxLjA5MzcxOTVxLTAuODI4MTI1IDAuMzEyNSAtMS43OTY4NzUgMC4zMTI1cS0xLjU5Mzc1IDAgLTIuNDUzMTI1IC0wLjc4MTI1cS0wLjg1OTM3NSAtMC43ODEyMTk1IC0wLjg1OTM3NSAtMS45ODQzNDQ1cTAgLTAuNzE4NzUgMC4zMjgxMjUgLTEuMjk2ODc1cTAuMzI4MTI1IC0wLjU5Mzc1IDAuODQzNzUgLTAuOTM3NXEwLjUzMTI1IC0wLjM1OTM3NSAxLjE4NzUgLTAuNTQ2ODc1cTAuNDY4NzUgLTAuMTI1IDEuNDUzMTI1IC0wLjI1cTEuOTg0Mzc1IC0wLjIzNDM3NSAyLjkyMTg3NSAtMC41NjI1cTAuMDE1NjI1IC0wLjM0Mzc1IDAuMDE1NjI1IC0wLjQyMTg3NXEwIC0xLjAgLTAuNDY4NzUgLTEuNDIxODc1cS0wLjYyNSAtMC41NDY4NzUgLTEuODc1IC0wLjU0Njg3NXEtMS4xNTYyNSAwIC0xLjcwMzEyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjgxMjUgMS40MjE4NzVsLTEuNjA5Mzc1IC0wLjIxODc1cTAuMjE4NzUgLTEuMDE1NjI1IDAuNzE4NzUgLTEuNjQwNjI1cTAuNSAtMC42NDA2MjUgMS40NTMxMjUgLTAuOTg0Mzc1cTAuOTUzMTI1IC0wLjM0Mzc1IDIuMTg3NSAtMC4zNDM3NXExLjI1IDAgMi4wMTU2MjUgMC4yOTY4NzVxMC43ODEyNSAwLjI4MTI1IDEuMTQwNjI1IDAuNzM0Mzc1cTAuMzc1IDAuNDM3NSAwLjUxNTYyNSAxLjEwOTM3NXEwLjA3ODEyNSAwLjQyMTg3NSAwLjA3ODEyNSAxLjUxNTYyNWwwIDIuMTg3NXEwIDIuMjgxMjUgMC4xMDkzNzUgMi44OTA2MjVxMC4xMDkzNzUgMC41OTM3MTk1IDAuNDA2MjUgMS4xNTYyMTk1bC0xLjcwMzEyNSAwcS0wLjI2NTYyNSAtMC41MTU2MjUgLTAuMzI4MTI1IC0xLjE4NzQ2OTV6bS0wLjE0MDYyNSAtMy42NzE4NzVxLTAuODkwNjI1IDAuMzc1IC0yLjY3MTg3NSAwLjYyNXEtMS4wMTU2MjUgMC4xNDA2MjUgLTEuNDM3NSAwLjMyODEyNXEtMC40MjE4NzUgMC4xODc1IC0wLjY1NjI1IDAuNTMxMjVxLTAuMjE4NzUgMC4zNDM3NSAtMC4yMTg3NSAwLjc4MTI1cTAgMC42NTYyNSAwLjUgMS4wOTM3NXEwLjUgMC40Mzc0Njk0OCAxLjQ1MzEyNSAwLjQzNzQ2OTQ4cTAuOTM3NSAwIDEuNjcxODc1IC0wLjQwNjIxOTQ4cTAuNzUgLTAuNDIxODc1IDEuMDkzNzUgLTEuMTQwNjI1cTAuMjY1NjI1IC0wLjU2MjUgMC4yNjU2MjUgLTEuNjQwNjI1bDAgLTAuNjA5Mzc1em03LjMyODg1NzQgOC43ODEyMTk1cS0xLjM1OTM3NSAtMS43MDMxMjUgLTIuMjk2ODc1IC00LjBxLTAuOTM3NSAtMi4yOTY4NDQ1IC0wLjkzNzUgLTQuNzY1NTk0NXEwIC0yLjE1NjI1IDAuNzAzMTI1IC00LjE0MDYyNXEwLjgyODEyNSAtMi4zMTI1IDIuNTMxMjUgLTQuNTkzNzVsMS4xNzE4NzUgMHEtMS4wOTM3NSAxLjg5MDYyNSAtMS40NTMxMjUgMi43MDMxMjVxLTAuNTQ2ODc1IDEuMjUgLTAuODc1IDIuNjI1cS0wLjM5MDYyNSAxLjcwMzEyNSAtMC4zOTA2MjUgMy40MjE4NzVxMCA0LjM3NDk2OTUgMi43MTg3NSA4Ljc0OTk2OTVsLTEuMTcxODc1IDB6bTIuNDMxMzk2NSAtNi44MTI0Njk1bDEuNjI1IC0wLjI1cTAuMTI1IDAuOTY4NzUgMC43NSAxLjVxMC42MjUgMC41MTU1OTQ1IDEuNzUgMC41MTU1OTQ1cTEuMTI1IDAgMS42NzE4NzUgLTAuNDUzMDk0NDhxMC41NDY4NzUgLTAuNDY4NzUgMC41NDY4NzUgLTEuMDkzNzVxMCAtMC41NDY4NzUgLTAuNDg0Mzc1IC0wLjg3NXEtMC4zMjgxMjUgLTAuMjE4NzUgLTEuNjcxODc1IC0wLjU0Njg3NXEtMS44MTI1IC0wLjQ2ODc1IC0yLjUxNTYyNSAtMC43OTY4NzVxLTAuNjg3NSAtMC4zMjgxMjUgLTEuMDQ2ODc1IC0wLjkwNjI1cS0wLjM1OTM3NSAtMC41OTM3NSAtMC4zNTkzNzUgLTEuMzEyNXEwIC0wLjY0MDYyNSAwLjI5Njg3NSAtMS4xODc1cTAuMjk2ODc1IC0wLjU2MjUgMC44MTI1IC0wLjkyMTg3NXEwLjM3NSAtMC4yODEyNSAxLjAzMTI1IC0wLjQ2ODc1cTAuNjcxODc1IC0wLjIwMzEyNSAxLjQyMTg3NSAtMC4yMDMxMjVxMS4xNDA2MjUgMCAyLjAgMC4zMjgxMjVxMC44NTkzNzUgMC4zMjgxMjUgMS4yNjU2MjUgMC44OTA2MjVxMC40MjE4NzUgMC41NjI1IDAuNTc4MTI1IDEuNWwtMS42MDkzNzUgMC4yMTg3NXEtMC4xMDkzNzUgLTAuNzUgLTAuNjQwNjI1IC0xLjE3MTg3NXEtMC41MTU2MjUgLTAuNDIxODc1IC0xLjQ2ODc1IC0wLjQyMTg3NXEtMS4xNDA2MjUgMCAtMS42MjUgMC4zNzVxLTAuNDY4NzUgMC4zNzUgLTAuNDY4NzUgMC44NzVxMCAwLjMxMjUgMC4xODc1IDAuNTc4MTI1cTAuMjAzMTI1IDAuMjY1NjI1IDAuNjQwNjI1IDAuNDM3NXEwLjIzNDM3NSAwLjA5Mzc1IDEuNDM3NSAwLjQyMTg3NXExLjc1IDAuNDUzMTI1IDIuNDM3NSAwLjc1cTAuNjg3NSAwLjI5Njg3NSAxLjA3ODEyNSAwLjg1OTM3NXEwLjM5MDYyNSAwLjU2MjUgMC4zOTA2MjUgMS40MDYyNXEwIDAuODI4MTI1IC0wLjQ4NDM3NSAxLjU0Njg3NXEtMC40Njg3NSAwLjcxODcxOTUgLTEuMzc1IDEuMTI0OTY5NXEtMC45MDYyNSAwLjM5MDYyNSAtMi4wNDY4NzUgMC4zOTA2MjVxLTEuODc1IDAgLTIuODc1IC0wLjc4MTI1cS0wLjk4NDM3NSAtMC43ODEyMTk1IC0xLjI1IC0yLjMyODA5NDV6bTE2LjYwOTM3NSAtMC4yMTg3NWwxLjY4NzUgMC4yMDMxMjVxLTAuNDA2MjUgMS40ODQzNzUgLTEuNDg0Mzc1IDIuMzEyNDY5NXEtMS4wNzgxMjUgMC44MTI1IC0yLjc2NTYyNSAwLjgxMjVxLTIuMTI1IDAgLTMuMzc1IC0xLjI5Njg3NXEtMS4yMzQzNzUgLTEuMzEyNDY5NSAtMS4yMzQzNzUgLTMuNjcxODQ0NXEwIC0yLjQ1MzEyNSAxLjI1IC0zLjc5Njg3NXExLjI2NTYyNSAtMS4zNDM3NSAzLjI2NTYyNSAtMS4zNDM3NXExLjkzNzUgMCAzLjE1NjI1IDEuMzI4MTI1cTEuMjM0Mzc1IDEuMzEyNSAxLjIzNDM3NSAzLjcwMzEyNXEwIDAuMTU2MjUgMCAwLjQzNzVsLTcuMjE4NzUgMHEwLjA5Mzc1IDEuNTkzNzUgMC45MDYyNSAyLjQ1MzEyNXEwLjgxMjUgMC44NDM3MTk1IDIuMDE1NjI1IDAuODQzNzE5NXEwLjkwNjI1IDAgMS41NDY4NzUgLTAuNDY4NzE5NDhxMC42NDA2MjUgLTAuNDg0Mzc1IDEuMDE1NjI1IC0xLjUxNTYyNXptLTUuMzkwNjI1IC0yLjY1NjI1bDUuNDA2MjUgMHEtMC4xMDkzNzUgLTEuMjE4NzUgLTAuNjI1IC0xLjgyODEyNXEtMC43ODEyNSAtMC45NTMxMjUgLTIuMDMxMjUgLTAuOTUzMTI1cS0xLjEyNSAwIC0xLjkwNjI1IDAuNzY1NjI1cS0wLjc2NTYyNSAwLjc1IC0wLjg0Mzc1IDIuMDE1NjI1em0xMC4yMTk0ODIgOS42ODc0Njk1bC0xLjE4NzUgMHEyLjczNDM3NSAtNC4zNzUgMi43MzQzNzUgLTguNzQ5OTY5NXEwIC0xLjcxODc1IC0wLjM5MDYyNSAtMy4zOTA2MjVxLTAuMzEyNSAtMS4zNzUgLTAuODc1IC0yLjYyNXEtMC4zNTkzNzUgLTAuODI4MTI1IC0xLjQ2ODc1IC0yLjczNDM3NWwxLjE4NzUgMHExLjcwMzEyNSAyLjI4MTI1IDIuNTMxMjUgNC41OTM3NXEwLjY4NzUgMS45ODQzNzUgMC42ODc1IDQuMTQwNjI1cTAgMi40Njg3NSAtMC45Mzc1IDQuNzY1NTk0NXEtMC45Mzc1IDIuMjk2ODc1IC0yLjI4MTI1IDQuMHptOC41NDA3NzE1IC0yLjBsMCAtMS42NDA2MjVxLTEuMjE4NzUgLTAuMTU2MjUgLTIuMCAtMC41NDY4NzVxLTAuNzY1NjI1IC0wLjQwNjI1IC0xLjMyODEyNSAtMS4yODEyMTk1cS0wLjU2MjUgLTAuODkwNjI1IC0wLjY0MDYyNSAtMi4xNTYyNWwxLjY0MDYyNSAtMC4zMTI1cTAuMTg3NSAxLjMxMjUgMC42NzE4NzUgMS45Mzc1cTAuNzAzMTI1IDAuODc1IDEuNjU2MjUgMC45Njg3MTk1bDAgLTUuMjE4NzE5NXEtMS4wIC0wLjE4NzUgLTIuMDYyNSAtMC43ODEyNXEtMC43ODEyNSAtMC40Mzc1IC0xLjIwMzEyNSAtMS4yMDMxMjVxLTAuNDIxODc1IC0wLjc4MTI1IC0wLjQyMTg3NSAtMS43NjU2MjVxMCAtMS43NSAxLjIzNDM3NSAtMi44MjgxMjVxMC44MjgxMjUgLTAuNzM0Mzc1IDIuNDUzMTI1IC0wLjg5MDYyNWwwIC0wLjc4MTI1bDAuOTY4NzUgMGwwIDAuNzgxMjVxMS40Mzc1IDAuMTI1IDIuMjY1NjI1IDAuODI4MTI1cTEuMDc4MTI1IDAuOTA2MjUgMS4yOTY4NzUgMi40NTMxMjVsLTEuNjg3NSAwLjI2NTYyNXEtMC4xNTYyNSAtMC45Njg3NSAtMC42MjUgLTEuNDg0Mzc1cS0wLjQ1MzEyNSAtMC41MTU2MjUgLTEuMjUgLTAuNjg3NWwwIDQuNzM0Mzc1cTEuMjM0Mzc1IDAuMzEyNSAxLjY0MDYyNSAwLjQ4NDM3NXEwLjc2NTYyNSAwLjMyODEyNSAxLjI1IDAuODEyNXEwLjQ4NDM3NSAwLjQ4NDM3NSAwLjczNDM3NSAxLjE1NjI1cTAuMjY1NjI1IDAuNjU2MjUgMC4yNjU2MjUgMS40Mzc1cTAgMS43MDMxMjUgLTEuMDkzNzUgMi44NDM3MTk1cS0xLjA3ODEyNSAxLjE0MDYyNSAtMi43OTY4NzUgMS4yMTg3NWwwIDEuNjU2MjVsLTAuOTY4NzUgMHptMCAtMTQuMzU5MzQ0NXEtMC45NTMxMjUgMC4xNTYyNSAtMS41IDAuNzgxMjVxLTAuNTQ2ODc1IDAuNjA5Mzc1IC0wLjU0Njg3NSAxLjQ1MzEyNXEwIDAuODQzNzUgMC40Njg3NSAxLjQwNjI1cTAuNDY4NzUgMC41NjI1IDEuNTc4MTI1IDAuOTA2MjVsMCAtNC41NDY4NzV6bTAuOTY4NzUgMTEuMzI4MDk0NXEwLjk1MzEyNSAtMC4xMDkzNDQ0OCAxLjU3ODEyNSAtMC44MTI0Njk1cTAuNjI1IC0wLjcxODc1IDAuNjI1IC0xLjc2NTYyNXEwIC0wLjg5MDYyNSAtMC40Mzc1IC0xLjQzNzVxLTAuNDM3NSAtMC41NDY4NzUgLTEuNzY1NjI1IC0wLjk2ODc1bDAgNC45ODQzNDQ1em02LjAwMDczMjQgMS4xMDkzNzVsMCAtOS42NzE4NDQ1bDEuNDY4NzUgMGwwIDEuMzU5Mzc1cTAuNDUzMTI1IC0wLjcxODc1IDEuMjAzMTI1IC0xLjE0MDYyNXEwLjc2NTYyNSAtMC40Mzc1IDEuNzE4NzUgLTAuNDM3NXExLjA3ODEyNSAwIDEuNzY1NjI1IDAuNDUzMTI1cTAuNjg3NSAwLjQzNzUgMC45Njg3NSAxLjIzNDM3NXExLjE1NjI1IC0xLjY4NzUgMi45ODQzNzUgLTEuNjg3NXExLjQ1MzEyNSAwIDIuMjE4NzUgMC43OTY4NzVxMC43ODEyNSAwLjc5Njg3NSAwLjc4MTI1IDIuNDUzMTI1bDAgNi42NDA1OTQ1bC0xLjY0MDYyNSAwbDAgLTYuMDkzNzE5NXEwIC0wLjk4NDM3NSAtMC4xNTYyNSAtMS40MDYyNXEtMC4xNTYyNSAtMC40Mzc1IC0wLjU3ODEyNSAtMC43MDMxMjVxLTAuNDIxODc1IC0wLjI2NTYyNSAtMC45ODQzNzUgLTAuMjY1NjI1cS0xLjAxNTYyNSAwIC0xLjY4NzUgMC42ODc1cS0wLjY3MTg3NSAwLjY3MTg3NSAtMC42NzE4NzUgMi4xNTYyNWwwIDUuNjI0OTY5NWwtMS42NDA2MjUgMGwwIC02LjI4MTIxOTVxMCAtMS4wOTM3NSAtMC40MDYyNSAtMS42NDA2MjVxLTAuNDA2MjUgLTAuNTQ2ODc1IC0xLjMxMjUgLTAuNTQ2ODc1cS0wLjY4NzUgMCAtMS4yODEyNSAwLjM1OTM3NXEtMC41OTM3NSAwLjM1OTM3NSAtMC44NTkzNzUgMS4wNjI1cS0wLjI1IDAuNzAzMTI1IC0wLjI1IDIuMDMxMjVsMCA1LjAxNTU5NDVsLTEuNjQwNjI1IDB6bTE0LjkzMTQ1NzUgLTQuODQzNzE5NXEwIC0yLjY4NzUgMS40ODQzNzUgLTMuOTY4NzVxMS4yNSAtMS4wNzgxMjUgMy4wNDY4NzUgLTEuMDc4MTI1cTIuMCAwIDMuMjY1NjI1IDEuMzEyNXExLjI2NTYyNSAxLjI5Njg3NSAxLjI2NTYyNSAzLjYwOTM3NXEwIDEuODU5Mzc1IC0wLjU2MjUgMi45Mzc1cS0wLjU2MjUgMS4wNjI0Njk1IC0xLjY0MDYyNSAxLjY1NjIxOTVxLTEuMDYyNSAwLjU5Mzc1IC0yLjMyODEyNSAwLjU5Mzc1cS0yLjAzMTI1IDAgLTMuMjgxMjUgLTEuMjk2ODc1cS0xLjI1IC0xLjMxMjQ2OTUgLTEuMjUgLTMuNzY1NTk0NXptMS42ODc1IDBxMCAxLjg1OTM3NSAwLjc5Njg3NSAyLjc5Njg3NXEwLjgxMjUgMC45MjE4NDQ1IDIuMDQ2ODc1IDAuOTIxODQ0NXExLjIxODc1IDAgMi4wMzEyNSAtMC45MjE4NDQ1cTAuODEyNSAtMC45Mzc1IDAuODEyNSAtMi44NDM3NXEwIC0xLjc5Njg3NSAtMC44MTI1IC0yLjcxODc1cS0wLjgxMjUgLTAuOTIxODc1IC0yLjAzMTI1IC0wLjkyMTg3NXEtMS4yMzQzNzUgMCAtMi4wNDY4NzUgMC45MjE4NzVxLTAuNzk2ODc1IDAuOTA2MjUgLTAuNzk2ODc1IDIuNzY1NjI1em0xNS41NjMxNzEgNC44NDM3MTk1bDAgLTEuMjE4NzE5NXEtMC45MDYyNSAxLjQzNzQ2OTUgLTIuNzAzMTI1IDEuNDM3NDY5NXEtMS4xNTYyNSAwIC0yLjEyNSAtMC42NDA2MjVxLTAuOTY4NzUgLTAuNjQwNjI1IC0xLjUgLTEuNzgxMjE5NXEtMC41MzEyNSAtMS4xNDA2MjUgLTAuNTMxMjUgLTIuNjI1cTAgLTEuNDUzMTI1IDAuNDg0Mzc1IC0yLjYyNXEwLjQ4NDM3NSAtMS4xODc1IDEuNDM3NSAtMS44MTI1cTAuOTY4NzUgLTAuNjI1IDIuMTcxODc1IC0wLjYyNXEwLjg3NSAwIDEuNTQ2ODc1IDAuMzc1cTAuNjg3NSAwLjM1OTM3NSAxLjEwOTM3NSAwLjk1MzEyNWwwIC00Ljc5Njg3NWwxLjY0MDYyNSAwbDAgMTMuMzU5MzQ0NWwtMS41MzEyNSAwem0tNS4xNzE4NzUgLTQuODI4MDk0NXEwIDEuODU5Mzc1IDAuNzgxMjUgMi43ODEyNXEwLjc4MTI1IDAuOTIxODQ0NSAxLjg0Mzc1IDAuOTIxODQ0NXExLjA3ODEyNSAwIDEuODI4MTI1IC0wLjg3NDk2OTVxMC43NSAtMC44OTA2MjUgMC43NSAtMi42ODc1cTAgLTEuOTg0Mzc1IC0wLjc2NTYyNSAtMi45MDYyNXEtMC43NjU2MjUgLTAuOTM3NSAtMS44OTA2MjUgLTAuOTM3NXEtMS4wNzgxMjUgMCAtMS44MTI1IDAuODkwNjI1cS0wLjczNDM3NSAwLjg5MDYyNSAtMC43MzQzNzUgMi44MTI1em0xNS45MDY5ODIgMS43MTg3NWwxLjY4NzUgMC4yMDMxMjVxLTAuNDA2MjUgMS40ODQzNzUgLTEuNDg0Mzc1IDIuMzEyNDY5NXEtMS4wNzgxMjUgMC44MTI1IC0yLjc2NTYyNSAwLjgxMjVxLTIuMTI1IDAgLTMuMzc1IC0xLjI5Njg3NXEtMS4yMzQzNzUgLTEuMzEyNDY5NSAtMS4yMzQzNzUgLTMuNjcxODQ0NXEwIC0yLjQ1MzEyNSAxLjI1IC0zLjc5Njg3NXExLjI2NTYyNSAtMS4zNDM3NSAzLjI2NTYyNSAtMS4zNDM3NXExLjkzNzUgMCAzLjE1NjI1IDEuMzI4MTI1cTEuMjM0Mzc1IDEuMzEyNSAxLjIzNDM3NSAzLjcwMzEyNXEwIDAuMTU2MjUgMCAwLjQzNzVsLTcuMjE4NzUgMHEwLjA5Mzc1IDEuNTkzNzUgMC45MDYyNSAyLjQ1MzEyNXEwLjgxMjUgMC44NDM3MTk1IDIuMDE1NjI1IDAuODQzNzE5NXEwLjkwNjI1IDAgMS41NDY4NzUgLTAuNDY4NzE5NDhxMC42NDA2MjUgLTAuNDg0Mzc1IDEuMDE1NjI1IC0xLjUxNTYyNXptLTUuMzkwNjI1IC0yLjY1NjI1bDUuNDA2MjUgMHEtMC4xMDkzNzUgLTEuMjE4NzUgLTAuNjI1IC0xLjgyODEyNXEtMC43ODEyNSAtMC45NTMxMjUgLTIuMDMxMjUgLTAuOTUzMTI1cS0xLjEyNSAwIC0xLjkwNjI1IDAuNzY1NjI1cS0wLjc2NTYyNSAwLjc1IC0wLjg0Mzc1IDIuMDE1NjI1em05LjA5NDQ4MiA1Ljc2NTU5NDVsMCAtMTMuMzU5MzQ0NWwxLjY0MDYyNSAwbDAgMTMuMzU5MzQ0NWwtMS42NDA2MjUgMHptNC40ODg1ODY0IDBsMCAtMTMuMzU5MzQ0NWw5LjAxNTYyNSAwbDAgMS41NzgxMjVsLTcuMjUgMGwwIDQuMTQwNjI1bDYuMjY1NjI1IDBsMCAxLjU3ODEyNWwtNi4yNjU2MjUgMGwwIDYuMDYyNDY5NWwtMS43NjU2MjUgMHptMTAuNDg5Njg1IC00Ljg0MzcxOTVxMCAtMi42ODc1IDEuNDg0Mzc1IC0zLjk2ODc1cTEuMjUgLTEuMDc4MTI1IDMuMDQ2ODc1IC0xLjA3ODEyNXEyLjAgMCAzLjI2NTYyNSAxLjMxMjVxMS4yNjU2MjUgMS4yOTY4NzUgMS4yNjU2MjUgMy42MDkzNzVxMCAxLjg1OTM3NSAtMC41NjI1IDIuOTM3NXEtMC41NjI1IDEuMDYyNDY5NSAtMS42NDA2MjUgMS42NTYyMTk1cS0xLjA2MjUgMC41OTM3NSAtMi4zMjgxMjUgMC41OTM3NXEtMi4wMzEyNSAwIC0zLjI4MTI1IC0xLjI5Njg3NXEtMS4yNSAtMS4zMTI0Njk1IC0xLjI1IC0zLjc2NTU5NDV6bTEuNjg3NSAwcTAgMS44NTkzNzUgMC43OTY4NzUgMi43OTY4NzVxMC44MTI1IDAuOTIxODQ0NSAyLjA0Njg3NSAwLjkyMTg0NDVxMS4yMTg3NSAwIDIuMDMxMjUgLTAuOTIxODQ0NXEwLjgxMjUgLTAuOTM3NSAwLjgxMjUgLTIuODQzNzVxMCAtMS43OTY4NzUgLTAuODEyNSAtMi43MTg3NXEtMC44MTI1IC0wLjkyMTg3NSAtMi4wMzEyNSAtMC45MjE4NzVxLTEuMjM0Mzc1IDAgLTIuMDQ2ODc1IDAuOTIxODc1cS0wLjc5Njg3NSAwLjkwNjI1IC0wLjc5Njg3NSAyLjc2NTYyNXptOS4yODE5ODIgNC44NDM3MTk1bDAgLTkuNjcxODQ0NWwxLjQ2ODc1IDBsMCAxLjQ2ODc1cTAuNTYyNSAtMS4wMzEyNSAxLjAzMTI1IC0xLjM1OTM3NXEwLjQ4NDM3NSAtMC4zMjgxMjUgMS4wNjI1IC0wLjMyODEyNXEwLjgyODEyNSAwIDEuNjg3NSAwLjUzMTI1bC0wLjU2MjUgMS41MTU2MjVxLTAuNjA5Mzc1IC0wLjM1OTM3NSAtMS4yMDMxMjUgLTAuMzU5Mzc1cS0wLjU0Njg3NSAwIC0wLjk2ODc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjMyODEyNSAtMC42MDkzNzUgMC44OTA2MjVxLTAuMjgxMjUgMC44NzUgLTAuMjgxMjUgMS45MjE4NzVsMCA1LjA2MjQ2OTVsLTEuNjI1IDB6bTYuMjI4MzMyNSAwbDAgLTkuNjcxODQ0NWwxLjQ2ODc1IDBsMCAxLjM1OTM3NXEwLjQ1MzEyNSAtMC43MTg3NSAxLjIwMzEyNSAtMS4xNDA2MjVxMC43NjU2MjUgLTAuNDM3NSAxLjcxODc1IC0wLjQzNzVxMS4wNzgxMjUgMCAxLjc2NTYyNSAwLjQ1MzEyNXEwLjY4NzUgMC40Mzc1IDAuOTY4NzUgMS4yMzQzNzVxMS4xNTYyNSAtMS42ODc1IDIuOTg0Mzc1IC0xLjY4NzVxMS40NTMxMjUgMCAyLjIxODc1IDAuNzk2ODc1cTAuNzgxMjUgMC43OTY4NzUgMC43ODEyNSAyLjQ1MzEyNWwwIDYuNjQwNTk0NWwtMS42NDA2MjUgMGwwIC02LjA5MzcxOTVxMCAtMC45ODQzNzUgLTAuMTU2MjUgLTEuNDA2MjVxLTAuMTU2MjUgLTAuNDM3NSAtMC41NzgxMjUgLTAuNzAzMTI1cS0wLjQyMTg3NSAtMC4yNjU2MjUgLTAuOTg0Mzc1IC0wLjI2NTYyNXEtMS4wMTU2MjUgMCAtMS42ODc1IDAuNjg3NXEtMC42NzE4NzUgMC42NzE4NzUgLTAuNjcxODc1IDIuMTU2MjVsMCA1LjYyNDk2OTVsLTEuNjQwNjI1IDBsMCAtNi4yODEyMTk1cTAgLTEuMDkzNzUgLTAuNDA2MjUgLTEuNjQwNjI1cS0wLjQwNjI1IC0wLjU0Njg3NSAtMS4zMTI1IC0wLjU0Njg3NXEtMC42ODc1IDAgLTEuMjgxMjUgMC4zNTkzNzVxLTAuNTkzNzUgMC4zNTkzNzUgLTAuODU5Mzc1IDEuMDYyNXEtMC4yNSAwLjcwMzEyNSAtMC4yNSAyLjAzMTI1bDAgNS4wMTU1OTQ1bC0xLjY0MDYyNSAwem0yMS44Njg4OTYgMGwwIC0xLjQyMTg0NDVxLTEuMTI1IDEuNjQwNTk0NSAtMy4wNjI1IDEuNjQwNTk0NXEtMC44NTkzNzUgMCAtMS42MDkzNzUgLTAuMzI4MTI1cS0wLjczNDM3NSAtMC4zMjgxMjUgLTEuMDkzNzUgLTAuODI4MTI1cS0wLjM1OTM3NSAtMC40OTk5Njk0OCAtMC41IC0xLjIxODcxOTVxLTAuMTA5Mzc1IC0wLjQ2ODc1IC0wLjEwOTM3NSAtMS41MzEyNWwwIC01Ljk4NDM3NWwxLjY0MDYyNSAwbDAgNS4zNTkzNzVxMCAxLjI4MTI1IDAuMTA5Mzc1IDEuNzM0Mzc1cTAuMTU2MjUgMC42NDA2MjUgMC42NTYyNSAxLjAxNTYyNXEwLjUgMC4zNzUgMS4yMzQzNzUgMC4zNzVxMC43MzQzNzUgMCAxLjM3NSAtMC4zNzVxMC42NTYyNSAtMC4zOTA2MjUgMC45MjE4NzUgLTEuMDMxMjVxMC4yNjU2MjUgLTAuNjU2MjUgMC4yNjU2MjUgLTEuODkwNjI1bDAgLTUuMTg3NWwxLjY0MDYyNSAwbDAgOS42NzE4NDQ1bC0xLjQ2ODc1IDB6bTQuMDAwNzMyNCAwbDAgLTEzLjM1OTM0NDVsMS42NDA2MjUgMGwwIDEzLjM1OTM0NDVsLTEuNjQwNjI1IDB6bTEwLjUwNDIxMSAtMS4xODc0Njk1cS0wLjkyMTg3NSAwLjc2NTU5NDUgLTEuNzY1NjI1IDEuMDkzNzE5NXEtMC44MjgxMjUgMC4zMTI1IC0xLjc5Njg3NSAwLjMxMjVxLTEuNTkzNzUgMCAtMi40NTMxMjUgLTAuNzgxMjVxLTAuODU5Mzc1IC0wLjc4MTIxOTUgLTAuODU5Mzc1IC0xLjk4NDM0NDVxMCAtMC43MTg3NSAwLjMyODEyNSAtMS4yOTY4NzVxMC4zMjgxMjUgLTAuNTkzNzUgMC44NDM3NSAtMC45Mzc1cTAuNTMxMjUgLTAuMzU5Mzc1IDEuMTg3NSAtMC41NDY4NzVxMC40Njg3NSAtMC4xMjUgMS40NTMxMjUgLTAuMjVxMS45ODQzNzUgLTAuMjM0Mzc1IDIuOTIxODc1IC0wLjU2MjVxMC4wMTU2MjUgLTAuMzQzNzUgMC4wMTU2MjUgLTAuNDIxODc1cTAgLTEuMCAtMC40Njg3NSAtMS40MjE4NzVxLTAuNjI1IC0wLjU0Njg3NSAtMS44NzUgLTAuNTQ2ODc1cS0xLjE1NjI1IDAgLTEuNzAzMTI1IDAuNDA2MjVxLTAuNTQ2ODc1IDAuNDA2MjUgLTAuODEyNSAxLjQyMTg3NWwtMS42MDkzNzUgLTAuMjE4NzVxMC4yMTg3NSAtMS4wMTU2MjUgMC43MTg3NSAtMS42NDA2MjVxMC41IC0wLjY0MDYyNSAxLjQ1MzEyNSAtMC45ODQzNzVxMC45NTMxMjUgLTAuMzQzNzUgMi4xODc1IC0wLjM0Mzc1cTEuMjUgMCAyLjAxNTYyNSAwLjI5Njg3NXEwLjc4MTI1IDAuMjgxMjUgMS4xNDA2MjUgMC43MzQzNzVxMC4zNzUgMC40Mzc1IDAuNTE1NjI1IDEuMTA5Mzc1cTAuMDc4MTI1IDAuNDIxODc1IDAuMDc4MTI1IDEuNTE1NjI1bDAgMi4xODc1cTAgMi4yODEyNSAwLjEwOTM3NSAyLjg5MDYyNXEwLjEwOTM3NSAwLjU5MzcxOTUgMC40MDYyNSAxLjE1NjIxOTVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NDY5NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzQ2OTQ4IDEuNDUzMTI1IDAuNDM3NDY5NDhxMC45Mzc1IDAgMS42NzE4NzUgLTAuNDA2MjE5NDhxMC43NSAtMC40MjE4NzUgMS4wOTM3NSAtMS4xNDA2MjVxMC4yNjU2MjUgLTAuNTYyNSAwLjI2NTYyNSAtMS42NDA2MjVsMCAtMC42MDkzNzV6IiBmaWxsLXJ1bGU9Im5vbnplcm8iLz48cGF0aCBmaWxsPSIjZmNlNWNkIiBkPSJtMjQzLjU2OTU1IDE4Mi41NTY0M2w0Mi42NzcxNTUgMGwwIDI4NC4yMjA1bC00Mi42NzcxNTUgMHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIHN0cm9rZT0iIzY2NjY2NiIgc3Ryb2tlLXdpZHRoPSIxLjAiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS1saW5lY2FwPSJidXR0IiBzdHJva2UtZGFzaGFycmF5PSIxLjAsMy4wIiBkPSJtMjQzLjU2OTU1IDE4Mi41NTY0M2w0Mi42NzcxNTUgMGwwIDI4NC4yMjA1bC00Mi42NzcxNTUgMHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIGZpbGw9IiMwMDAwMDAiIGZpbGwtb3BhY2l0eT0iMC4wIiBkPSJtMjE0Ljc3MTY1IDEyNS42NDU4NWwwIDBjMCAtNS4wNzM1NzggNC4xMTI5NjEgLTkuMTg2NTMxIDkuMTg2NTM5IC05LjE4NjUzMWwxMzguNzYwNzcgMGMyLjQzNjQzMiAwIDQuNzczMDcxMyAwLjk2Nzg2NSA2LjQ5NTg4IDIuNjkwNjczOGMxLjcyMjgwODggMS43MjI4MDg4IDIuNjkwNjczOCA0LjA1OTQ0MDYgMi42OTA2NzM4IDYuNDk1ODU3MmwwIDM2Ljc0NTA1YzAgNS4wNzM1NzggLTQuMTEyOTQ1NiA5LjE4NjUyMyAtOS4xODY1NTQgOS4xODY1MjNsLTEzOC43NjA3NyAwYy01LjA3MzU3OCAwIC05LjE4NjUzOSAtNC4xMTI5NDU2IC05LjE4NjUzOSAtOS4xODY1MjN6IiBmaWxsLXJ1bGU9ImV2ZW5vZGQiLz48cGF0aCBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS13aWR0aD0iMi4wIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBzdHJva2UtbGluZWNhcD0iYnV0dCIgc3Ryb2tlLWRhc2hhcnJheT0iOC4wLDYuMCIgZD0ibTIxNC43NzE2NSAxMjUuNjQ1ODVsMCAwYzAgLTUuMDczNTc4IDQuMTEyOTYxIC05LjE4NjUzMSA5LjE4NjUzOSAtOS4xODY1MzFsMTM4Ljc2MDc3IDBjMi40MzY0MzIgMCA0Ljc3MzA3MTMgMC45Njc4NjUgNi40OTU4OCAyLjY5MDY3MzhjMS43MjI4MDg4IDEuNzIyODA4OCAyLjY5MDY3MzggNC4wNTk0NDA2IDIuNjkwNjczOCA2LjQ5NTg1NzJsMCAzNi43NDUwNWMwIDUuMDczNTc4IC00LjExMjk0NTYgOS4xODY1MjMgLTkuMTg2NTU0IDkuMTg2NTIzbC0xMzguNzYwNzcgMGMtNS4wNzM1NzggMCAtOS4xODY1MzkgLTQuMTEyOTQ1NiAtOS4xODY1MzkgLTkuMTg2NTIzeiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PHBhdGggZmlsbD0iIzAwMDAwMCIgZD0ibTI1Ny44OTAxIDEzNS42NDE1bDEuNjU2MjUgLTAuMTQwNjI1cTAuMTI1IDEuMCAwLjU0Njg3NSAxLjY0MDYyNXEwLjQzNzUgMC42NDA2MjUgMS4zNDM3NSAxLjA0Njg3NXEwLjkyMTg3NSAwLjM5MDYyNSAyLjA2MjUgMC4zOTA2MjVxMS4wIDAgMS43ODEyNSAtMC4yOTY4NzVxMC43ODEyNSAtMC4yOTY4NzUgMS4xNTYyNSAtMC44MTI1cTAuMzc1IC0wLjUzMTI1IDAuMzc1IC0xLjE1NjI1cTAgLTAuNjI1IC0wLjM3NSAtMS4wOTM3NXEtMC4zNTkzNzUgLTAuNDY4NzUgLTEuMTg3NSAtMC43OTY4NzVxLTAuNTQ2ODc1IC0wLjIwMzEyNSAtMi4zOTA2MjUgLTAuNjQwNjI1cS0xLjgyODEyNSAtMC40NTMxMjUgLTIuNTYyNSAtMC44NDM3NXEtMC45Njg3NSAtMC41IC0xLjQzNzUgLTEuMjM0Mzc1cS0wLjQ2ODc1IC0wLjc1IC0wLjQ2ODc1IC0xLjY3MTg3NXEwIC0xLjAgMC41NzgxMjUgLTEuODc1cTAuNTc4MTI1IC0wLjg5MDYyNSAxLjY3MTg3NSAtMS4zNDM3NXExLjEwOTM3NSAtMC40NTMxMjUgMi40NTMxMjUgLTAuNDUzMTI1cTEuNDg0Mzc1IDAgMi42MDkzNzUgMC40ODQzNzVxMS4xNDA2MjUgMC40Njg3NSAxLjc1IDEuNDA2MjVxMC42MDkzNzUgMC45MjE4NzUgMC42NTYyNSAyLjA5Mzc1bC0xLjY4NzUgMC4xMjVxLTAuMTQwNjI1IC0xLjI2NTYyNSAtMC45Mzc1IC0xLjkwNjI1cS0wLjc4MTI1IC0wLjY1NjI1IC0yLjMxMjUgLTAuNjU2MjVxLTEuNjA5Mzc1IDAgLTIuMzQzNzUgMC41OTM3NXEtMC43MzQzNzUgMC41OTM3NSAtMC43MzQzNzUgMS40MjE4NzVxMCAwLjcxODc1IDAuNTMxMjUgMS4xNzE4NzVxMC41IDAuNDY4NzUgMi42NTYyNSAwLjk2ODc1cTIuMTU2MjUgMC40ODQzNzUgMi45NTMxMjUgMC44NDM3NXExLjE3MTg3NSAwLjUzMTI1IDEuNzE4NzUgMS4zNTkzNzVxMC41NjI1IDAuODI4MTI1IDAuNTYyNSAxLjkwNjI1cTAgMS4wNjI1IC0wLjYwOTM3NSAyLjAxNTYyNXEtMC42MDkzNzUgMC45Mzc1IC0xLjc1IDEuNDY4NzVxLTEuMTQwNjI1IDAuNTE1NjI1IC0yLjU3ODEyNSAwLjUxNTYyNXEtMS44MTI1IDAgLTMuMDQ2ODc1IC0wLjUzMTI1cS0xLjIxODc1IC0wLjUzMTI1IC0xLjkyMTg3NSAtMS41OTM3NXEtMC42ODc1IC0xLjA2MjUgLTAuNzE4NzUgLTIuNDA2MjV6bTE5LjE0NjY5OCAzLjEwOTM3NXEtMC45MjE4NzUgMC43NjU2MjUgLTEuNzY1NjI1IDEuMDkzNzVxLTAuODI4MTI1IDAuMzEyNSAtMS43OTY4NzUgMC4zMTI1cS0xLjU5Mzc1IDAgLTIuNDUzMTI1IC0wLjc4MTI1cS0wLjg1OTM3NSAtMC43ODEyNSAtMC44NTkzNzUgLTEuOTg0Mzc1cTAgLTAuNzE4NzUgMC4zMjgxMjUgLTEuMjk2ODc1cTAuMzI4MTI1IC0wLjU5Mzc1IDAuODQzNzUgLTAuOTM3NXEwLjUzMTI1IC0wLjM1OTM3NSAxLjE4NzUgLTAuNTQ2ODc1cTAuNDY4NzUgLTAuMTI1IDEuNDUzMTI1IC0wLjI1cTEuOTg0Mzc1IC0wLjIzNDM3NSAyLjkyMTg3NSAtMC41NjI1cTAuMDE1NjI1IC0wLjM0Mzc1IDAuMDE1NjI1IC0wLjQyMTg3NXEwIC0xLjAgLTAuNDY4NzUgLTEuNDIxODc1cS0wLjYyNSAtMC41NDY4NzUgLTEuODc1IC0wLjU0Njg3NXEtMS4xNTYyNSAwIC0xLjcwMzEyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjgxMjUgMS40MjE4NzVsLTEuNjA5Mzc1IC0wLjIxODc1cTAuMjE4NzUgLTEuMDE1NjI1IDAuNzE4NzUgLTEuNjQwNjI1cTAuNSAtMC42NDA2MjUgMS40NTMxMjUgLTAuOTg0Mzc1cTAuOTUzMTI1IC0wLjM0Mzc1IDIuMTg3NSAtMC4zNDM3NXExLjI1IDAgMi4wMTU2MjUgMC4yOTY4NzVxMC43ODEyNSAwLjI4MTI1IDEuMTQwNjI1IDAuNzM0Mzc1cTAuMzc1IDAuNDM3NSAwLjUxNTYyNSAxLjEwOTM3NXEwLjA3ODEyNSAwLjQyMTg3NSAwLjA3ODEyNSAxLjUxNTYyNWwwIDIuMTg3NXEwIDIuMjgxMjUgMC4xMDkzNzUgMi44OTA2MjVxMC4xMDkzNzUgMC41OTM3NSAwLjQwNjI1IDEuMTU2MjVsLTEuNzAzMTI1IDBxLTAuMjY1NjI1IC0wLjUxNTYyNSAtMC4zMjgxMjUgLTEuMTg3NXptLTAuMTQwNjI1IC0zLjY3MTg3NXEtMC44OTA2MjUgMC4zNzUgLTIuNjcxODc1IDAuNjI1cS0xLjAxNTYyNSAwLjE0MDYyNSAtMS40Mzc1IDAuMzI4MTI1cS0wLjQyMTg3NSAwLjE4NzUgLTAuNjU2MjUgMC41MzEyNXEtMC4yMTg3NSAwLjM0Mzc1IC0wLjIxODc1IDAuNzgxMjVxMCAwLjY1NjI1IDAuNSAxLjA5Mzc1cTAuNSAwLjQzNzUgMS40NTMxMjUgMC40Mzc1cTAuOTM3NSAwIDEuNjcxODc1IC0wLjQwNjI1cTAuNzUgLTAuNDIxODc1IDEuMDkzNzUgLTEuMTQwNjI1cTAuMjY1NjI1IC0wLjU2MjUgMC4yNjU2MjUgLTEuNjQwNjI1bDAgLTAuNjA5Mzc1em00LjIwMzgyNyA0Ljg1OTM3NWwwIC05LjY3MTg3NWwxLjQ2ODc1IDBsMCAxLjM1OTM3NXEwLjQ1MzEyNSAtMC43MTg3NSAxLjIwMzEyNSAtMS4xNDA2MjVxMC43NjU2MjUgLTAuNDM3NSAxLjcxODc1IC0wLjQzNzVxMS4wNzgxMjUgMCAxLjc2NTYyNSAwLjQ1MzEyNXEwLjY4NzUgMC40Mzc1IDAuOTY4NzUgMS4yMzQzNzVxMS4xNTYyNSAtMS42ODc1IDIuOTg0Mzc1IC0xLjY4NzVxMS40NTMxMjUgMCAyLjIxODc1IDAuNzk2ODc1cTAuNzgxMjUgMC43OTY4NzUgMC43ODEyNSAyLjQ1MzEyNWwwIDYuNjQwNjI1bC0xLjY0MDYyNSAwbDAgLTYuMDkzNzVxMCAtMC45ODQzNzUgLTAuMTU2MjUgLTEuNDA2MjVxLTAuMTU2MjUgLTAuNDM3NSAtMC41NzgxMjUgLTAuNzAzMTI1cS0wLjQyMTg3NSAtMC4yNjU2MjUgLTAuOTg0Mzc1IC0wLjI2NTYyNXEtMS4wMTU2MjUgMCAtMS42ODc1IDAuNjg3NXEtMC42NzE4NzUgMC42NzE4NzUgLTAuNjcxODc1IDIuMTU2MjVsMCA1LjYyNWwtMS42NDA2MjUgMGwwIC02LjI4MTI1cTAgLTEuMDkzNzUgLTAuNDA2MjUgLTEuNjQwNjI1cS0wLjQwNjI1IC0wLjU0Njg3NSAtMS4zMTI1IC0wLjU0Njg3NXEtMC42ODc1IDAgLTEuMjgxMjUgMC4zNTkzNzVxLTAuNTkzNzUgMC4zNTkzNzUgLTAuODU5Mzc1IDEuMDYyNXEtMC4yNSAwLjcwMzEyNSAtMC4yNSAyLjAzMTI1bDAgNS4wMTU2MjVsLTEuNjQwNjI1IDB6bTE1LjU0MDgwMiAzLjcwMzEyNWwwIC0xMy4zNzVsMS40ODQzNzUgMGwwIDEuMjVxMC41MzEyNSAtMC43MzQzNzUgMS4xODc1IC0xLjA5Mzc1cTAuNjcxODc1IC0wLjM3NSAxLjYyNSAtMC4zNzVxMS4yMzQzNzUgMCAyLjE3MTg3NSAwLjY0MDYyNXEwLjk1MzEyNSAwLjYyNSAxLjQzNzUgMS43OTY4NzVxMC40ODQzNzUgMS4xNTYyNSAwLjQ4NDM3NSAyLjU0Njg3NXEwIDEuNDg0Mzc1IC0wLjUzMTI1IDIuNjcxODc1cS0wLjUzMTI1IDEuMTg3NSAtMS41NDY4NzUgMS44MjgxMjVxLTEuMDE1NjI1IDAuNjI1IC0yLjE0MDYyNSAwLjYyNXEtMC44MTI1IDAgLTEuNDY4NzUgLTAuMzQzNzVxLTAuNjU2MjUgLTAuMzQzNzUgLTEuMDYyNSAtMC44NzVsMCA0LjcwMzEyNWwtMS42NDA2MjUgMHptMS40ODQzNzUgLTguNDg0Mzc1cTAgMS44NTkzNzUgMC43NSAyLjc2NTYyNXEwLjc2NTYyNSAwLjg5MDYyNSAxLjgyODEyNSAwLjg5MDYyNXExLjA5Mzc1IDAgMS44NzUgLTAuOTIxODc1cTAuNzgxMjUgLTAuOTM3NSAwLjc4MTI1IC0yLjg3NXEwIC0xLjg0Mzc1IC0wLjc2NTYyNSAtMi43NjU2MjVxLTAuNzUgLTAuOTIxODc1IC0xLjgxMjUgLTAuOTIxODc1cS0xLjA0Njg3NSAwIC0xLjg1OTM3NSAwLjk4NDM3NXEtMC43OTY4NzUgMC45Njg3NSAtMC43OTY4NzUgMi44NDM3NXptOC44NDQ0ODIgNC43ODEyNWwwIC0xMy4zNTkzNzVsMS42NDA2MjUgMGwwIDEzLjM1OTM3NWwtMS42NDA2MjUgMHptMTAuODE2NjgxIC0zLjEwOTM3NWwxLjY4NzUgMC4yMDMxMjVxLTAuNDA2MjUgMS40ODQzNzUgLTEuNDg0Mzc1IDIuMzEyNXEtMS4wNzgxMjUgMC44MTI1IC0yLjc2NTYyNSAwLjgxMjVxLTIuMTI1IDAgLTMuMzc1IC0xLjI5Njg3NXEtMS4yMzQzNzUgLTEuMzEyNSAtMS4yMzQzNzUgLTMuNjcxODc1cTAgLTIuNDUzMTI1IDEuMjUgLTMuNzk2ODc1cTEuMjY1NjI1IC0xLjM0Mzc1IDMuMjY1NjI1IC0xLjM0Mzc1cTEuOTM3NSAwIDMuMTU2MjUgMS4zMjgxMjVxMS4yMzQzNzUgMS4zMTI1IDEuMjM0Mzc1IDMuNzAzMTI1cTAgMC4xNTYyNSAwIDAuNDM3NWwtNy4yMTg3NSAwcTAuMDkzNzUgMS41OTM3NSAwLjkwNjI1IDIuNDUzMTI1cTAuODEyNSAwLjg0Mzc1IDIuMDE1NjI1IDAuODQzNzVxMC45MDYyNSAwIDEuNTQ2ODc1IC0wLjQ2ODc1cTAuNjQwNjI1IC0wLjQ4NDM3NSAxLjAxNTYyNSAtMS41MTU2MjV6bS01LjM5MDYyNSAtMi42NTYyNWw1LjQwNjI1IDBxLTAuMTA5Mzc1IC0xLjIxODc1IC0wLjYyNSAtMS44MjgxMjVxLTAuNzgxMjUgLTAuOTUzMTI1IC0yLjAzMTI1IC0wLjk1MzEyNXEtMS4xMjUgMCAtMS45MDYyNSAwLjc2NTYyNXEtMC43NjU2MjUgMC43NSAtMC44NDM3NSAyLjAxNTYyNXptOC40ODUxMDcgMi44NzVsMS42MjUgLTAuMjVxMC4xMjUgMC45Njg3NSAwLjc1IDEuNXEwLjYyNSAwLjUxNTYyNSAxLjc1IDAuNTE1NjI1cTEuMTI1IDAgMS42NzE4NzUgLTAuNDUzMTI1cTAuNTQ2ODc1IC0wLjQ2ODc1IDAuNTQ2ODc1IC0xLjA5Mzc1cTAgLTAuNTQ2ODc1IC0wLjQ4NDM3NSAtMC44NzVxLTAuMzI4MTI1IC0wLjIxODc1IC0xLjY3MTg3NSAtMC41NDY4NzVxLTEuODEyNSAtMC40Njg3NSAtMi41MTU2MjUgLTAuNzk2ODc1cS0wLjY4NzUgLTAuMzI4MTI1IC0xLjA0Njg3NSAtMC45MDYyNXEtMC4zNTkzNzUgLTAuNTkzNzUgLTAuMzU5Mzc1IC0xLjMxMjVxMCAtMC42NDA2MjUgMC4yOTY4NzUgLTEuMTg3NXEwLjI5Njg3NSAtMC41NjI1IDAuODEyNSAtMC45MjE4NzVxMC4zNzUgLTAuMjgxMjUgMS4wMzEyNSAtMC40Njg3NXEwLjY3MTg3NSAtMC4yMDMxMjUgMS40MjE4NzUgLTAuMjAzMTI1cTEuMTQwNjI1IDAgMi4wIDAuMzI4MTI1cTAuODU5Mzc1IDAuMzI4MTI1IDEuMjY1NjI1IDAuODkwNjI1cTAuNDIxODc1IDAuNTYyNSAwLjU3ODEyNSAxLjVsLTEuNjA5Mzc1IDAuMjE4NzVxLTAuMTA5Mzc1IC0wLjc1IC0wLjY0MDYyNSAtMS4xNzE4NzVxLTAuNTE1NjI1IC0wLjQyMTg3NSAtMS40Njg3NSAtMC40MjE4NzVxLTEuMTQwNjI1IDAgLTEuNjI1IDAuMzc1cS0wLjQ2ODc1IDAuMzc1IC0wLjQ2ODc1IDAuODc1cTAgMC4zMTI1IDAuMTg3NSAwLjU3ODEyNXEwLjIwMzEyNSAwLjI2NTYyNSAwLjY0MDYyNSAwLjQzNzVxMC4yMzQzNzUgMC4wOTM3NSAxLjQzNzUgMC40MjE4NzVxMS43NSAwLjQ1MzEyNSAyLjQzNzUgMC43NXEwLjY4NzUgMC4yOTY4NzUgMS4wNzgxMjUgMC44NTkzNzVxMC4zOTA2MjUgMC41NjI1IDAuMzkwNjI1IDEuNDA2MjVxMCAwLjgyODEyNSAtMC40ODQzNzUgMS41NDY4NzVxLTAuNDY4NzUgMC43MTg3NSAtMS4zNzUgMS4xMjVxLTAuOTA2MjUgMC4zOTA2MjUgLTIuMDQ2ODc1IDAuMzkwNjI1cS0xLjg3NSAwIC0yLjg3NSAtMC43ODEyNXEtMC45ODQzNzUgLTAuNzgxMjUgLTEuMjUgLTIuMzI4MTI1eiIgZmlsbC1ydWxlPSJub256ZXJvIi8+PHBhdGggZmlsbD0iIzAwMDAwMCIgZD0ibTI1NC42NzgzNiAxNjUuODYwMjRxLTEuMzU5Mzc1IC0xLjcwMzEyNSAtMi4yOTY4NzUgLTQuMHEtMC45Mzc1IC0yLjI5Njg3NSAtMC45Mzc1IC00Ljc2NTYyNXEwIC0yLjE1NjI1IDAuNzAzMTI1IC00LjE0MDYyNXEwLjgyODEyNSAtMi4zMTI1IDIuNTMxMjUgLTQuNTkzNzVsMS4xNzE4NzUgMHEtMS4wOTM3NSAxLjg5MDYyNSAtMS40NTMxMjUgMi43MDMxMjVxLTAuNTQ2ODc1IDEuMjUgLTAuODc1IDIuNjI1cS0wLjM5MDYyNSAxLjcwMzEyNSAtMC4zOTA2MjUgMy40MjE4NzVxMCA0LjM3NSAyLjcxODc1IDguNzVsLTEuMTcxODc1IDB6bTEyLjgyMjAzNyAtOC42MDkzNzVsMS43NjU2MjUgMC40NTMxMjVxLTAuNTYyNSAyLjE3MTg3NSAtMi4wIDMuMzI4MTI1cS0xLjQzNzUgMS4xNDA2MjUgLTMuNTMxMjUgMS4xNDA2MjVxLTIuMTU2MjUgMCAtMy41MTU2MjUgLTAuODc1cS0xLjM0Mzc1IC0wLjg5MDYyNSAtMi4wNjI1IC0yLjU0Njg3NXEtMC43MDMxMjUgLTEuNjcxODc1IC0wLjcwMzEyNSAtMy41OTM3NXEwIC0yLjA3ODEyNSAwLjc5Njg3NSAtMy42MjVxMC43OTY4NzUgLTEuNTYyNSAyLjI2NTYyNSAtMi4zNTkzNzVxMS40ODQzNzUgLTAuODEyNSAzLjI1IC0wLjgxMjVxMi4wIDAgMy4zNTkzNzUgMS4wMTU2MjVxMS4zNzUgMS4wMTU2MjUgMS45MDYyNSAyLjg3NWwtMS43MzQzNzUgMC40MDYyNXEtMC40Njg3NSAtMS40NTMxMjUgLTEuMzU5Mzc1IC0yLjEwOTM3NXEtMC44NzUgLTAuNjcxODc1IC0yLjIwMzEyNSAtMC42NzE4NzVxLTEuNTQ2ODc1IDAgLTIuNTc4MTI1IDAuNzM0Mzc1cS0xLjAzMTI1IDAuNzM0Mzc1IC0xLjQ1MzEyNSAxLjk4NDM3NXEtMC40MjE4NzUgMS4yMzQzNzUgLTAuNDIxODc1IDIuNTYyNXEwIDEuNzAzMTI1IDAuNSAyLjk2ODc1cTAuNSAxLjI2NTYyNSAxLjU0Njg3NSAxLjkwNjI1cTEuMDQ2ODc1IDAuNjI1IDIuMjY1NjI1IDAuNjI1cTEuNDg0Mzc1IDAgMi41MTU2MjUgLTAuODU5Mzc1cTEuMDMxMjUgLTAuODU5Mzc1IDEuMzkwNjI1IC0yLjU0Njg3NXptMy4xMjkyMTE0IC0wLjE1NjI1cTAgLTIuNjg3NSAxLjQ4NDM3NSAtMy45Njg3NXExLjI1IC0xLjA3ODEyNSAzLjA0Njg3NSAtMS4wNzgxMjVxMi4wIDAgMy4yNjU2MjUgMS4zMTI1cTEuMjY1NjI1IDEuMjk2ODc1IDEuMjY1NjI1IDMuNjA5Mzc1cTAgMS44NTkzNzUgLTAuNTYyNSAyLjkzNzVxLTAuNTYyNSAxLjA2MjUgLTEuNjQwNjI1IDEuNjU2MjVxLTEuMDYyNSAwLjU5Mzc1IC0yLjMyODEyNSAwLjU5Mzc1cS0yLjAzMTI1IDAgLTMuMjgxMjUgLTEuMjk2ODc1cS0xLjI1IC0xLjMxMjUgLTEuMjUgLTMuNzY1NjI1em0xLjY4NzUgMHEwIDEuODU5Mzc1IDAuNzk2ODc1IDIuNzk2ODc1cTAuODEyNSAwLjkyMTg3NSAyLjA0Njg3NSAwLjkyMTg3NXExLjIxODc1IDAgMi4wMzEyNSAtMC45MjE4NzVxMC44MTI1IC0wLjkzNzUgMC44MTI1IC0yLjg0Mzc1cTAgLTEuNzk2ODc1IC0wLjgxMjUgLTIuNzE4NzVxLTAuODEyNSAtMC45MjE4NzUgLTIuMDMxMjUgLTAuOTIxODc1cS0xLjIzNDM3NSAwIC0yLjA0Njg3NSAwLjkyMTg3NXEtMC43OTY4NzUgMC45MDYyNSAtMC43OTY4NzUgMi43NjU2MjV6bTkuMjUwNzAyIDQuODQzNzVsMCAtMTMuMzU5Mzc1bDEuNjQwNjI1IDBsMCAxMy4zNTkzNzVsLTEuNjQwNjI1IDB6bTEwLjUxOTgzNiAwbDAgLTEuNDIxODc1cS0xLjEyNSAxLjY0MDYyNSAtMy4wNjI1IDEuNjQwNjI1cS0wLjg1OTM3NSAwIC0xLjYwOTM3NSAtMC4zMjgxMjVxLTAuNzM0Mzc1IC0wLjMyODEyNSAtMS4wOTM3NSAtMC44MjgxMjVxLTAuMzU5Mzc1IC0wLjUgLTAuNSAtMS4yMTg3NXEtMC4xMDkzNzUgLTAuNDY4NzUgLTAuMTA5Mzc1IC0xLjUzMTI1bDAgLTUuOTg0Mzc1bDEuNjQwNjI1IDBsMCA1LjM1OTM3NXEwIDEuMjgxMjUgMC4xMDkzNzUgMS43MzQzNzVxMC4xNTYyNSAwLjY0MDYyNSAwLjY1NjI1IDEuMDE1NjI1cTAuNSAwLjM3NSAxLjIzNDM3NSAwLjM3NXEwLjczNDM3NSAwIDEuMzc1IC0wLjM3NXEwLjY1NjI1IC0wLjM5MDYyNSAwLjkyMTg3NSAtMS4wMzEyNXEwLjI2NTYyNSAtMC42NTYyNSAwLjI2NTYyNSAtMS44OTA2MjVsMCAtNS4xODc1bDEuNjQwNjI1IDBsMCA5LjY3MTg3NWwtMS40Njg3NSAwem00LjA0NzU3NyAwbDAgLTkuNjcxODc1bDEuNDY4NzUgMGwwIDEuMzU5Mzc1cTAuNDUzMTI1IC0wLjcxODc1IDEuMjAzMTI1IC0xLjE0MDYyNXEwLjc2NTYyNSAtMC40Mzc1IDEuNzE4NzUgLTAuNDM3NXExLjA3ODEyNSAwIDEuNzY1NjI1IDAuNDUzMTI1cTAuNjg3NSAwLjQzNzUgMC45Njg3NSAxLjIzNDM3NXExLjE1NjI1IC0xLjY4NzUgMi45ODQzNzUgLTEuNjg3NXExLjQ1MzEyNSAwIDIuMjE4NzUgMC43OTY4NzVxMC43ODEyNSAwLjc5Njg3NSAwLjc4MTI1IDIuNDUzMTI1bDAgNi42NDA2MjVsLTEuNjQwNjI1IDBsMCAtNi4wOTM3NXEwIC0wLjk4NDM3NSAtMC4xNTYyNSAtMS40MDYyNXEtMC4xNTYyNSAtMC40Mzc1IC0wLjU3ODEyNSAtMC43MDMxMjVxLTAuNDIxODc1IC0wLjI2NTYyNSAtMC45ODQzNzUgLTAuMjY1NjI1cS0xLjAxNTYyNSAwIC0xLjY4NzUgMC42ODc1cS0wLjY3MTg3NSAwLjY3MTg3NSAtMC42NzE4NzUgMi4xNTYyNWwwIDUuNjI1bC0xLjY0MDYyNSAwbDAgLTYuMjgxMjVxMCAtMS4wOTM3NSAtMC40MDYyNSAtMS42NDA2MjVxLTAuNDA2MjUgLTAuNTQ2ODc1IC0xLjMxMjUgLTAuNTQ2ODc1cS0wLjY4NzUgMCAtMS4yODEyNSAwLjM1OTM3NXEtMC41OTM3NSAwLjM1OTM3NSAtMC44NTkzNzUgMS4wNjI1cS0wLjI1IDAuNzAzMTI1IC0wLjI1IDIuMDMxMjVsMCA1LjAxNTYyNWwtMS42NDA2MjUgMHptMTUuNTQwODAyIDBsMCAtOS42NzE4NzVsMS40Njg3NSAwbDAgMS4zNzVxMS4wNjI1IC0xLjU5Mzc1IDMuMDc4MTI1IC0xLjU5Mzc1cTAuODc1IDAgMS42MDkzNzUgMC4zMTI1cTAuNzM0Mzc1IDAuMzEyNSAxLjA5Mzc1IDAuODI4MTI1cTAuMzc1IDAuNSAwLjUxNTYyNSAxLjIwMzEyNXEwLjA5Mzc1IDAuNDUzMTI1IDAuMDkzNzUgMS41OTM3NWwwIDUuOTUzMTI1bC0xLjY0MDYyNSAwbDAgLTUuODkwNjI1cTAgLTEuMCAtMC4yMDMxMjUgLTEuNDg0Mzc1cS0wLjE4NzUgLTAuNSAtMC42NzE4NzUgLTAuNzk2ODc1cS0wLjQ4NDM3NSAtMC4yOTY4NzUgLTEuMTQwNjI1IC0wLjI5Njg3NXEtMS4wNDY4NzUgMCAtMS44MTI1IDAuNjcxODc1cS0wLjc1IDAuNjU2MjUgLTAuNzUgMi41MTU2MjVsMCA1LjI4MTI1bC0xLjY0MDYyNSAwem05LjcxOTQ4MiAtMi44OTA2MjVsMS42MjUgLTAuMjVxMC4xMjUgMC45Njg3NSAwLjc1IDEuNXEwLjYyNSAwLjUxNTYyNSAxLjc1IDAuNTE1NjI1cTEuMTI1IDAgMS42NzE4NzUgLTAuNDUzMTI1cTAuNTQ2ODc1IC0wLjQ2ODc1IDAuNTQ2ODc1IC0xLjA5Mzc1cTAgLTAuNTQ2ODc1IC0wLjQ4NDM3NSAtMC44NzVxLTAuMzI4MTI1IC0wLjIxODc1IC0xLjY3MTg3NSAtMC41NDY4NzVxLTEuODEyNSAtMC40Njg3NSAtMi41MTU2MjUgLTAuNzk2ODc1cS0wLjY4NzUgLTAuMzI4MTI1IC0xLjA0Njg3NSAtMC45MDYyNXEtMC4zNTkzNzUgLTAuNTkzNzUgLTAuMzU5Mzc1IC0xLjMxMjVxMCAtMC42NDA2MjUgMC4yOTY4NzUgLTEuMTg3NXEwLjI5Njg3NSAtMC41NjI1IDAuODEyNSAtMC45MjE4NzVxMC4zNzUgLTAuMjgxMjUgMS4wMzEyNSAtMC40Njg3NXEwLjY3MTg3NSAtMC4yMDMxMjUgMS40MjE4NzUgLTAuMjAzMTI1cTEuMTQwNjI1IDAgMi4wIDAuMzI4MTI1cTAuODU5Mzc1IDAuMzI4MTI1IDEuMjY1NjI1IDAuODkwNjI1cTAuNDIxODc1IDAuNTYyNSAwLjU3ODEyNSAxLjVsLTEuNjA5Mzc1IDAuMjE4NzVxLTAuMTA5Mzc1IC0wLjc1IC0wLjY0MDYyNSAtMS4xNzE4NzVxLTAuNTE1NjI1IC0wLjQyMTg3NSAtMS40Njg3NSAtMC40MjE4NzVxLTEuMTQwNjI1IDAgLTEuNjI1IDAuMzc1cS0wLjQ2ODc1IDAuMzc1IC0wLjQ2ODc1IDAuODc1cTAgMC4zMTI1IDAuMTg3NSAwLjU3ODEyNXEwLjIwMzEyNSAwLjI2NTYyNSAwLjY0MDYyNSAwLjQzNzVxMC4yMzQzNzUgMC4wOTM3NSAxLjQzNzUgMC40MjE4NzVxMS43NSAwLjQ1MzEyNSAyLjQzNzUgMC43NXEwLjY4NzUgMC4yOTY4NzUgMS4wNzgxMjUgMC44NTkzNzVxMC4zOTA2MjUgMC41NjI1IDAuMzkwNjI1IDEuNDA2MjVxMCAwLjgyODEyNSAtMC40ODQzNzUgMS41NDY4NzVxLTAuNDY4NzUgMC43MTg3NSAtMS4zNzUgMS4xMjVxLTAuOTA2MjUgMC4zOTA2MjUgLTIuMDQ2ODc1IDAuMzkwNjI1cS0xLjg3NSAwIC0yLjg3NSAtMC43ODEyNXEtMC45ODQzNzUgLTAuNzgxMjUgLTEuMjUgLTIuMzI4MTI1em0xMS4wNjI1IDYuODEyNWwtMS4xODc1IDBxMi43MzQzNzUgLTQuMzc1IDIuNzM0Mzc1IC04Ljc1cTAgLTEuNzE4NzUgLTAuMzkwNjI1IC0zLjM5MDYyNXEtMC4zMTI1IC0xLjM3NSAtMC44NzUgLTIuNjI1cS0wLjM1OTM3NSAtMC44MjgxMjUgLTEuNDY4NzUgLTIuNzM0Mzc1bDEuMTg3NSAwcTEuNzAzMTI1IDIuMjgxMjUgMi41MzEyNSA0LjU5Mzc1cTAuNjg3NSAxLjk4NDM3NSAwLjY4NzUgNC4xNDA2MjVxMCAyLjQ2ODc1IC0wLjkzNzUgNC43NjU2MjVxLTAuOTM3NSAyLjI5Njg3NSAtMi4yODEyNSA0LjB6IiBmaWxsLXJ1bGU9Im5vbnplcm8iLz48cGF0aCBmaWxsPSIjMDAwMDAwIiBmaWxsLW9wYWNpdHk9IjAuMCIgZD0ibTQ1My4zMDQ2IDE1Ny4xMzM4N2wwIDBjLTMuMjkzNDg3NSAwIC01Ljk2MzM3OSAtMi42Njk5MDY2IC01Ljk2MzM3OSAtNS45NjMzNzlsMCAtMTQ1LjIwNzFjMCAtMS41ODE1ODQ5IDAuNjI4MjY1NCAtMy4wOTgzOTIyIDEuNzQ2NjEyNSAtNC4yMTY3NDJjMS4xMTgzNDcyIC0xLjExODM0OTYgMi42MzUxNjI0IC0xLjc0NjYzMTcgNC4yMTY3NjY0IC0xLjc0NjYzMTdsMjMuODUyNzUzIDBjMy4yOTM0ODc1IDAgNS45NjMzNzkgMi42Njk4OTM1IDUuOTYzMzc5IDUuOTYzMzczN2wwIDE0NS4yMDcxYzAgMy4yOTM0NzIzIC0yLjY2OTg5MTQgNS45NjMzNzkgLTUuOTYzMzc5IDUuOTYzMzc5eiIgZmlsbC1ydWxlPSJldmVub2RkIi8+PHBhdGggc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2Utd2lkdGg9IjIuMCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLWxpbmVjYXA9ImJ1dHQiIHN0cm9rZS1kYXNoYXJyYXk9IjguMCw2LjAiIGQ9Im00NTMuMzA0NiAxNTcuMTMzODdsMCAwYy0zLjI5MzQ4NzUgMCAtNS45NjMzNzkgLTIuNjY5OTA2NiAtNS45NjMzNzkgLTUuOTYzMzc5bDAgLTE0NS4yMDcxYzAgLTEuNTgxNTg0OSAwLjYyODI2NTQgLTMuMDk4MzkyMiAxLjc0NjYxMjUgLTQuMjE2NzQyYzEuMTE4MzQ3MiAtMS4xMTgzNDk2IDIuNjM1MTYyNCAtMS43NDY2MzE3IDQuMjE2NzY2NCAtMS43NDY2MzE3bDIzLjg1Mjc1MyAwYzMuMjkzNDg3NSAwIDUuOTYzMzc5IDIuNjY5ODkzNSA1Ljk2MzM3OSA1Ljk2MzM3MzdsMCAxNDUuMjA3MWMwIDMuMjkzNDcyMyAtMi42Njk4OTE0IDUuOTYzMzc5IC01Ljk2MzM3OSA1Ljk2MzM3OXoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIGZpbGw9IiMwMDAwMDAiIGQ9Im00NjcuODU0MSAxMTQuMDE1NDFsLTAuMTQwNjI1IC0xLjY1NjI1cTEuMCAtMC4xMjUgMS42NDA2MjUgLTAuNTQ2ODc1cTAuNjQwNjI1IC0wLjQzNzUgMS4wNDY4NzUgLTEuMzQzNzVxMC4zOTA2MjUgLTAuOTIxODc1IDAuMzkwNjI1IC0yLjA2MjVxMCAtMS4wIC0wLjI5Njg3NSAtMS43ODEyNXEtMC4yOTY4NzUgLTAuNzgxMjUgLTAuODEyNSAtMS4xNTYyNXEtMC41MzEyNSAtMC4zNzUgLTEuMTU2MjUgLTAuMzc1cS0wLjYyNSAwIC0xLjA5Mzc1IDAuMzc1cS0wLjQ2ODc1IDAuMzU5Mzc1IC0wLjc5Njg3NSAxLjE4NzVxLTAuMjAzMTI1IDAuNTQ2ODc1IC0wLjY0MDYyNSAyLjM5MDYyNXEtMC40NTMxMjUgMS44MjgxMjUgLTAuODQzNzUgMi41NjI1cS0wLjUgMC45Njg3NSAtMS4yMzQzNzUgMS40Mzc1cS0wLjc1IDAuNDY4NzUgLTEuNjcxODc1IDAuNDY4NzVxLTEuMCAwIC0xLjg3NSAtMC41NzgxMjVxLTAuODkwNjI1IC0wLjU3ODEyNSAtMS4zNDM3NSAtMS42NzE4NzVxLTAuNDUzMTI1IC0xLjEwOTM3NSAtMC40NTMxMjUgLTIuNDUzMTI1cTAgLTEuNDg0Mzc1IDAuNDg0Mzc1IC0yLjYwOTM3NXEwLjQ2ODc1IC0xLjE0MDYyNSAxLjQwNjI1IC0xLjc1cTAuOTIxODc1IC0wLjYwOTM3NSAyLjA5Mzc1IC0wLjY1NjI1bDAuMTI1IDEuNjg3NXEtMS4yNjU2MjUgMC4xNDA2MjUgLTEuOTA2MjUgMC45Mzc1cS0wLjY1NjI1IDAuNzgxMjUgLTAuNjU2MjUgMi4zMTI1cTAgMS42MDkzNzUgMC41OTM3NSAyLjM0Mzc1cTAuNTkzNzUgMC43MzQzNzUgMS40MjE4NzUgMC43MzQzNzVxMC43MTg3NSAwIDEuMTcxODc1IC0wLjUzMTI1cTAuNDY4NzUgLTAuNSAwLjk2ODc1IC0yLjY1NjI1cTAuNDg0Mzc1IC0yLjE1NjI1IDAuODQzNzUgLTIuOTUzMTI1cTAuNTMxMjUgLTEuMTcxODc1IDEuMzU5Mzc1IC0xLjcxODc1cTAuODI4MTI1IC0wLjU2MjUgMS45MDYyNSAtMC41NjI1cTEuMDYyNSAwIDIuMDE1NjI1IDAuNjA5Mzc1cTAuOTM3NSAwLjYwOTM3NSAxLjQ2ODc1IDEuNzVxMC41MTU2MjUgMS4xNDA2MjUgMC41MTU2MjUgMi41NzgxMjVxMCAxLjgxMjUgLTAuNTMxMjUgMy4wNDY4NzVxLTAuNTMxMjUgMS4yMTg3NSAtMS41OTM3NSAxLjkyMTg3NXEtMS4wNjI1IDAuNjg3NSAtMi40MDYyNSAwLjcxODc1em0zLjEwOTM3NSAtMTkuMTQ2Njk4cTAuNzY1NjI1IDAuOTIxODc1IDEuMDkzNzUgMS43NjU2MjVxMC4zMTI1IDAuODI4MTI1IDAuMzEyNSAxLjc5Njg3NXEwIDEuNTkzNzUgLTAuNzgxMjUgMi40NTMxMjVxLTAuNzgxMjUgMC44NTkzNzUgLTEuOTg0Mzc1IDAuODU5Mzc1cS0wLjcxODc1IDAgLTEuMjk2ODc1IC0wLjMyODEyNXEtMC41OTM3NSAtMC4zMjgxMjUgLTAuOTM3NSAtMC44NDM3NXEtMC4zNTkzNzUgLTAuNTMxMjUgLTAuNTQ2ODc1IC0xLjE4NzVxLTAuMTI1IC0wLjQ2ODc1IC0wLjI1IC0xLjQ1MzEyNXEtMC4yMzQzNzUgLTEuOTg0Mzc1IC0wLjU2MjUgLTIuOTIxODc1cS0wLjM0Mzc1IC0wLjAxNTYyNSAtMC40MjE4NzUgLTAuMDE1NjI1cS0xLjAgMCAtMS40MjE4NzUgMC40Njg3NXEtMC41NDY4NzUgMC42MjUgLTAuNTQ2ODc1IDEuODc1cTAgMS4xNTYyNSAwLjQwNjI1IDEuNzAzMTI1cTAuNDA2MjUgMC41NDY4NzUgMS40MjE4NzUgMC44MTI1bC0wLjIxODc1IDEuNjA5Mzc1cS0xLjAxNTYyNSAtMC4yMTg3NSAtMS42NDA2MjUgLTAuNzE4NzVxLTAuNjQwNjI1IC0wLjUgLTAuOTg0Mzc1IC0xLjQ1MzEyNXEtMC4zNDM3NSAtMC45NTMxMjUgLTAuMzQzNzUgLTIuMTg3NXEwIC0xLjI1IDAuMjk2ODc1IC0yLjAxNTYyNXEwLjI4MTI1IC0wLjc4MTI1IDAuNzM0Mzc1IC0xLjE0MDYyNXEwLjQzNzUgLTAuMzc1IDEuMTA5Mzc1IC0wLjUxNTYyNXEwLjQyMTg3NSAtMC4wNzgxMjUgMS41MTU2MjUgLTAuMDc4MTI1bDIuMTg3NSAwcTIuMjgxMjUgMCAyLjg5MDYyNSAtMC4xMDkzNzVxMC41OTM3NSAtMC4xMDkzNzUgMS4xNTYyNSAtMC40MDYyNWwwIDEuNzAzMTI1cS0wLjUxNTYyNSAwLjI2NTYyNSAtMS4xODc1IDAuMzI4MTI1em0tMy42NzE4NzUgMC4xNDA2MjVxMC4zNzUgMC44OTA2MjUgMC42MjUgMi42NzE4NzVxMC4xNDA2MjUgMS4wMTU2MjUgMC4zMjgxMjUgMS40Mzc1cTAuMTg3NSAwLjQyMTg3NSAwLjUzMTI1IDAuNjU2MjVxMC4zNDM3NSAwLjIxODc1IDAuNzgxMjUgMC4yMTg3NXEwLjY1NjI1IDAgMS4wOTM3NSAtMC41cTAuNDM3NSAtMC41IDAuNDM3NSAtMS40NTMxMjVxMCAtMC45Mzc1IC0wLjQwNjI1IC0xLjY3MTg3NXEtMC40MjE4NzUgLTAuNzUgLTEuMTQwNjI1IC0xLjA5Mzc1cS0wLjU2MjUgLTAuMjY1NjI1IC0xLjY0MDYyNSAtMC4yNjU2MjVsLTAuNjA5Mzc1IDB6bTQuODU5Mzc1IC00LjIwMzg0MmwtOS42NzE4NzUgMGwwIC0xLjQ2ODc1bDEuMzU5Mzc1IDBxLTAuNzE4NzUgLTAuNDUzMTI1IC0xLjE0MDYyNSAtMS4yMDMxMjVxLTAuNDM3NSAtMC43NjU2MjUgLTAuNDM3NSAtMS43MTg3NXEwIC0xLjA3ODEyNSAwLjQ1MzEyNSAtMS43NjU2MjVxMC40Mzc1IC0wLjY4NzUgMS4yMzQzNzUgLTAuOTY4NzVxLTEuNjg3NSAtMS4xNTYyNSAtMS42ODc1IC0yLjk4NDM3NXEwIC0xLjQ1MzEyNSAwLjc5Njg3NSAtMi4yMTg3NXEwLjc5Njg3NSAtMC43ODEyNSAyLjQ1MzEyNSAtMC43ODEyNWw2LjY0MDYyNSAwbDAgMS42NDA2MjVsLTYuMDkzNzUgMHEtMC45ODQzNzUgMCAtMS40MDYyNSAwLjE1NjI1cS0wLjQzNzUgMC4xNTYyNSAtMC43MDMxMjUgMC41NzgxMjVxLTAuMjY1NjI1IDAuNDIxODc1IC0wLjI2NTYyNSAwLjk4NDM3NXEwIDEuMDE1NjI1IDAuNjg3NSAxLjY4NzVxMC42NzE4NzUgMC42NzE4NzUgMi4xNTYyNSAwLjY3MTg3NWw1LjYyNSAwbDAgMS42NDA2MjVsLTYuMjgxMjUgMHEtMS4wOTM3NSAwIC0xLjY0MDYyNSAwLjQwNjI1cS0wLjU0Njg3NSAwLjQwNjI1IC0wLjU0Njg3NSAxLjMxMjVxMCAwLjY4NzUgMC4zNTkzNzUgMS4yODEyNXEwLjM1OTM3NSAwLjU5Mzc1IDEuMDYyNSAwLjg1OTM3NXEwLjcwMzEyNSAwLjI1IDIuMDMxMjUgMC4yNWw1LjAxNTYyNSAwbDAgMS42NDA2MjV6bTMuNzAzMTI1IC0xNS41NDA4MDJsLTEzLjM3NSAwbDAgLTEuNDg0Mzc1bDEuMjUgMHEtMC43MzQzNzUgLTAuNTMxMjUgLTEuMDkzNzUgLTEuMTg3NXEtMC4zNzUgLTAuNjcxODc1IC0wLjM3NSAtMS42MjVxMCAtMS4yMzQzNzUgMC42NDA2MjUgLTIuMTcxODc1cTAuNjI1IC0wLjk1MzEyNSAxLjc5Njg3NSAtMS40Mzc1cTEuMTU2MjUgLTAuNDg0Mzc1IDIuNTQ2ODc1IC0wLjQ4NDM3NXExLjQ4NDM3NSAwIDIuNjcxODc1IDAuNTMxMjVxMS4xODc1IDAuNTMxMjUgMS44MjgxMjUgMS41NDY4NzVxMC42MjUgMS4wMTU2MjUgMC42MjUgMi4xNDA2MjVxMCAwLjgxMjUgLTAuMzQzNzUgMS40Njg3NXEtMC4zNDM3NSAwLjY1NjI1IC0wLjg3NSAxLjA2MjVsNC43MDMxMjUgMGwwIDEuNjQwNjI1em0tOC40ODQzNzUgLTEuNDg0Mzc1cTEuODU5Mzc1IDAgMi43NjU2MjUgLTAuNzVxMC44OTA2MjUgLTAuNzY1NjI1IDAuODkwNjI1IC0xLjgyODEyNXEwIC0xLjA5Mzc1IC0wLjkyMTg3NSAtMS44NzVxLTAuOTM3NSAtMC43ODEyNSAtMi44NzUgLTAuNzgxMjVxLTEuODQzNzUgMCAtMi43NjU2MjUgMC43NjU2MjVxLTAuOTIxODc1IDAuNzUgLTAuOTIxODc1IDEuODEyNXEwIDEuMDQ2ODc1IDAuOTg0Mzc1IDEuODU5Mzc1cTAuOTY4NzUgMC43OTY4NzUgMi44NDM3NSAwLjc5Njg3NXptNC43ODEyNSAtOC44NDQ0NjdsLTEzLjM1OTM3NSAwbDAgLTEuNjQwNjI1bDEzLjM1OTM3NSAwbDAgMS42NDA2MjV6bS0zLjEwOTM3NSAtMTAuODE2Njk2bDAuMjAzMTI1IC0xLjY4NzVxMS40ODQzNzUgMC40MDYyNSAyLjMxMjUgMS40ODQzNzVxMC44MTI1IDEuMDc4MTI1IDAuODEyNSAyLjc2NTYyNXEwIDIuMTI1IC0xLjI5Njg3NSAzLjM3NXEtMS4zMTI1IDEuMjM0Mzc1IC0zLjY3MTg3NSAxLjIzNDM3NXEtMi40NTMxMjUgMCAtMy43OTY4NzUgLTEuMjVxLTEuMzQzNzUgLTEuMjY1NjI1IC0xLjM0Mzc1IC0zLjI2NTYyNXEwIC0xLjkzNzUgMS4zMjgxMjUgLTMuMTU2MjVxMS4zMTI1IC0xLjIzNDM3NSAzLjcwMzEyNSAtMS4yMzQzNzVxMC4xNTYyNSAwIDAuNDM3NSAwbDAgNy4yMTg3NXExLjU5Mzc1IC0wLjA5Mzc1IDIuNDUzMTI1IC0wLjkwNjI1cTAuODQzNzUgLTAuODEyNSAwLjg0Mzc1IC0yLjAxNTYyNXEwIC0wLjkwNjI1IC0wLjQ2ODc1IC0xLjU0Njg3NXEtMC40ODQzNzUgLTAuNjQwNjI1IC0xLjUxNTYyNSAtMS4wMTU2MjV6bS0yLjY1NjI1IDUuMzkwNjI1bDAgLTUuNDA2MjVxLTEuMjE4NzUgMC4xMDkzNzUgLTEuODI4MTI1IDAuNjI1cS0wLjk1MzEyNSAwLjc4MTI1IC0wLjk1MzEyNSAyLjAzMTI1cTAgMS4xMjUgMC43NjU2MjUgMS45MDYyNXEwLjc1IDAuNzY1NjI1IDIuMDE1NjI1IDAuODQzNzV6bTIuODc1IC04LjQ4NTA5MmwtMC4yNSAtMS42MjVxMC45Njg3NSAtMC4xMjUgMS41IC0wLjc1cTAuNTE1NjI1IC0wLjYyNSAwLjUxNTYyNSAtMS43NXEwIC0xLjEyNSAtMC40NTMxMjUgLTEuNjcxODc1cS0wLjQ2ODc1IC0wLjU0Njg3NSAtMS4wOTM3NSAtMC41NDY4NzVxLTAuNTQ2ODc1IDAgLTAuODc1IDAuNDg0Mzc1cS0wLjIxODc1IDAuMzI4MTI1IC0wLjU0Njg3NSAxLjY3MTg3NXEtMC40Njg3NSAxLjgxMjUgLTAuNzk2ODc1IDIuNTE1NjI1cS0wLjMyODEyNSAwLjY4NzUgLTAuOTA2MjUgMS4wNDY4NzVxLTAuNTkzNzUgMC4zNTkzNzUgLTEuMzEyNSAwLjM1OTM3NXEtMC42NDA2MjUgMCAtMS4xODc1IC0wLjI5Njg3NXEtMC41NjI1IC0wLjI5Njg3NSAtMC45MjE4NzUgLTAuODEyNXEtMC4yODEyNSAtMC4zNzUgLTAuNDY4NzUgLTEuMDMxMjVxLTAuMjAzMTI1IC0wLjY3MTg3NSAtMC4yMDMxMjUgLTEuNDIxODc1cTAgLTEuMTQwNjI1IDAuMzI4MTI1IC0yLjBxMC4zMjgxMjUgLTAuODU5Mzc1IDAuODkwNjI1IC0xLjI2NTYyNXEwLjU2MjUgLTAuNDIxODc1IDEuNSAtMC41NzgxMjVsMC4yMTg3NSAxLjYwOTM3NXEtMC43NSAwLjEwOTM3NSAtMS4xNzE4NzUgMC42NDA2MjVxLTAuNDIxODc1IDAuNTE1NjI1IC0wLjQyMTg3NSAxLjQ2ODc1cTAgMS4xNDA2MjUgMC4zNzUgMS42MjVxMC4zNzUgMC40Njg3NSAwLjg3NSAwLjQ2ODc1cTAuMzEyNSAwIDAuNTc4MTI1IC0wLjE4NzVxMC4yNjU2MjUgLTAuMjAzMTI1IDAuNDM3NSAtMC42NDA2MjVxMC4wOTM3NSAtMC4yMzQzNzUgMC40MjE4NzUgLTEuNDM3NXEwLjQ1MzEyNSAtMS43NSAwLjc1IC0yLjQzNzVxMC4yOTY4NzUgLTAuNjg3NSAwLjg1OTM3NSAtMS4wNzgxMjVxMC41NjI1IC0wLjM5MDYyNSAxLjQwNjI1IC0wLjM5MDYyNXEwLjgyODEyNSAwIDEuNTQ2ODc1IDAuNDg0Mzc1cTAuNzE4NzUgMC40Njg3NSAxLjEyNSAxLjM3NXEwLjM5MDYyNSAwLjkwNjI1IDAuMzkwNjI1IDIuMDQ2ODc1cTAgMS44NzUgLTAuNzgxMjUgMi44NzVxLTAuNzgxMjUgMC45ODQzNzUgLTIuMzI4MTI1IDEuMjV6IiBmaWxsLXJ1bGU9Im5vbnplcm8iLz48cGF0aCBmaWxsPSIjZmNlNWNkIiBkPSJtNDM4LjAxMDUgNjIuMjIzMWwtMTYxLjIyMDQ2IDBjLTExLjU5Nzk5MiAwIC0yMS4wMDAwMTUgOS40MDIwMTYgLTIxLjAwMDAxNSAyMS4wbDAgMTUuMGwtNi4wIDBsMTIuMDAwMDE1IDEyLjBsMTIuMCAtMTIuMGwtNi4wIDBsMCAtMTUuMGwwIDBjMCAtNC45NzA1NjYgNC4wMjk0MTkgLTkuMCA5LjAgLTkuMGwxNjEuMjIwNDYgMHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIHN0cm9rZT0iIzQzNDM0MyIgc3Ryb2tlLXdpZHRoPSIyLjAiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS1saW5lY2FwPSJidXR0IiBkPSJtNDM4LjAxMDUgNjIuMjIzMWwtMTYxLjIyMDQ2IDBjLTExLjU5Nzk5MiAwIC0yMS4wMDAwMTUgOS40MDIwMTYgLTIxLjAwMDAxNSAyMS4wbDAgMTUuMGwtNi4wIDBsMTIuMDAwMDE1IDEyLjBsMTIuMCAtMTIuMGwtNi4wIDBsMCAtMTUuMGwwIDBjMCAtNC45NzA1NjYgNC4wMjk0MTkgLTkuMCA5LjAgLTkuMGwxNjEuMjIwNDYgMHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIGZpbGw9IiMwMDAwMDAiIGZpbGwtb3BhY2l0eT0iMC4wIiBkPSJtOC44ODczNTQgNDE2Ljg5ODg2bDAgMGMtNC45MDgzMyAwIC04Ljg4NjY1NSAtMy45Nzg5NzM0IC04Ljg4NTgzODUgLTguODg3Mjk5bDAuMDI4NTM5MDQ1IC0xNzEuNTQ4MmMzLjkyMTI1OTJFLTQgLTIuMzU3MDcxIDAuOTM3MTA3ODYgLTQuNjE3NTg0IDIuNjA0MDgwMiAtNi4yODQyODY1YzEuNjY2OTcyNCAtMS42NjY3MDIzIDMuOTI3NjUyMSAtMi42MDMwNDI2IDYuMjg0NzE1NyAtMi42MDMwNDI2bDM1LjU0ODIwMyAwYzQuOTA4MzI5IDAgOC44ODY2NTQgMy45Nzg5ODg2IDguODg1ODM4IDguODg3MzI5bC0wLjAyODU0MTU2NSAxNzEuNTQ4MmMtOC4xNjM0NTJFLTQgNC45MDgzMjUgLTMuOTgwNDY1IDguODg3Mjk5IC04Ljg4ODc5NCA4Ljg4NzI5OXoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLXdpZHRoPSIyLjAiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS1saW5lY2FwPSJidXR0IiBzdHJva2UtZGFzaGFycmF5PSI4LjAsNi4wIiBkPSJtOC44ODczNTQgNDE2Ljg5ODg2bDAgMGMtNC45MDgzMyAwIC04Ljg4NjY1NSAtMy45Nzg5NzM0IC04Ljg4NTgzODUgLTguODg3Mjk5bDAuMDI4NTM5MDQ1IC0xNzEuNTQ4MmMzLjkyMTI1OTJFLTQgLTIuMzU3MDcxIDAuOTM3MTA3ODYgLTQuNjE3NTg0IDIuNjA0MDgwMiAtNi4yODQyODY1YzEuNjY2OTcyNCAtMS42NjY3MDIzIDMuOTI3NjUyMSAtMi42MDMwNDI2IDYuMjg0NzE1NyAtMi42MDMwNDI2bDM1LjU0ODIwMyAwYzQuOTA4MzI5IDAgOC44ODY2NTQgMy45Nzg5ODg2IDguODg1ODM4IDguODg3MzI5bC0wLjAyODU0MTU2NSAxNzEuNTQ4MmMtOC4xNjM0NTJFLTQgNC45MDgzMjUgLTMuOTgwNDY1IDguODg3Mjk5IC04Ljg4ODc5NCA4Ljg4NzI5OXoiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjxwYXRoIGZpbGw9IiMwMDAwMDAiIGQ9Im0yMi41OTEzMzEgMzU3LjUxNzdsLTEzLjM1OTM3NiAwbDAuMDAxNTAwMTI5NyAtOS4wMTU2MjVsMS41NzgxMjUgMGwtMC4wMDEyMDYzOTggNy4yNWw0LjE0MDYyNSAwbDAuMDAxMDQyMzY2IC02LjI2NTYyNWwxLjU3ODEyNSAwbC0wLjAwMTA0MTQxMjQgNi4yNjU2MjVsNi4wNjI1IDBsLTIuOTM3MzE3RS00IDEuNzY1NjI1em0tMy4xMDY0MjYyIC0xNy43MjQxMjFsMC4yMDM0MDUzOCAtMS42ODc1cTEuNDg0MzA2MyAwLjQwNjI1IDIuMzEyMjUyIDEuNDg0Mzc1cTAuODEyMzIwNyAxLjA3ODEyNSAwLjgxMjA0MDMgMi43NjU2MjVxLTMuNTI4NTk1RS00IDIuMTI1IC0xLjI5NzQzNTggMy4zNzVxLTEuMzEyNzA2IDEuMjM0Mzc1IC0zLjY3MjA4MSAxLjIzNDM3NXEtMi40NTMxMjUgMCAtMy43OTY2NjcgLTEuMjVxLTEuMzQzNTM5MiAtMS4yNjU2MjUgLTEuMzQzMjA2NCAtMy4yNjU2MjVxMy4yMjM0MTkyRS00IC0xLjkzNzUgMS4zMjg2NDk1IC0zLjE1NjI1cTEuMzEyNzA2IC0xLjIzNDM3NSAzLjcwMzMzMSAtMS4yMzQzNzVxMC4xNTYyNSAwIDAuNDM3NSAwbC0wLjAwMTIwMTYyOTYgNy4yMTg3NXExLjU5Mzc2NTMgLTAuMDkzNzUgMi40NTMyNzU3IC0wLjkwNjI1cTAuODQzODg1NCAtMC44MTI1IDAuODQ0MDg1NyAtMi4wMTU2MjVxMS41MDY4MDU0RS00IC0wLjkwNjI1IC0wLjQ2ODQ5MjUgLTEuNTQ2ODc1cS0wLjQ4NDI2ODIgLTAuNjQwNjI1IC0xLjUxNTQ1NTIgLTEuMDE1NjI1em0tMi42NTcxNDg0IDUuMzkwNjI1bDkuMDAyNjg1NUUtNCAtNS40MDYyNXEtMS4yMTg3NjgxIDAuMTA5Mzc1IC0xLjgyODIyOSAwLjYyNXEtMC45NTMyNTU2NSAwLjc4MTI1IC0wLjk1MzQ2MzU1IDIuMDMxMjVxLTEuODY5MjAxN0UtNCAxLjEyNSAwLjc2NTMwODQgMS45MDYyNXEwLjc0OTg3MjIgMC43NjU2MjUgMi4wMTU0ODM5IDAuODQzNzV6bTQuNTgwNjk2IC0xNS40NTM4MjdxMC43NjU0NzI0IDAuOTIxODc1IDEuMDkzNDU2MyAxLjc2NTYyNXEwLjMxMjM2MjY3IDAuODI4MTI1IDAuMzEyMjAyNDUgMS43OTY4NzVxLTIuNjUxMjE0NkUtNCAxLjU5Mzc1IC0wLjc4MTY1ODIgMi40NTMxMjVxLTAuNzgxMzkzMDUgMC44NTkzNzUgLTEuOTg0NTE4IDAuODU5Mzc1cS0wLjcxODc1IDAgLTEuMjk2ODIxNiAtMC4zMjgxMjVxLTAuNTkzNjk0NyAtMC4zMjgxMjUgLTAuOTM3MzU4ODYgLTAuODQzNzVxLTAuMzU5Mjg3MjYgLTAuNTMxMjUgLTAuNTQ2Njc4NTQgLTEuMTg3NXEtMC4xMjQ5MjE4IC0wLjQ2ODc1IC0wLjI0OTc1Nzc3IC0xLjQ1MzEyNXEtMC4yMzQwNDUwMyAtMS45ODQzNzUgLTAuNTYyMDEzNiAtMi45MjE4NzVxLTAuMzQzNzQ4MSAtMC4wMTU2MjUgLTAuNDIxODczMSAtMC4wMTU2MjVxLTAuOTk5OTk5MDUgMCAtMS40MjE5NTIyIDAuNDY4NzVxLTAuNTQ2OTc4OTUgMC42MjUgLTAuNTQ3MTg2ODUgMS44NzVxLTEuOTI2NDIyMUUtNCAxLjE1NjI1IDAuNDA1OTY2NzYgMS43MDMxMjVxMC40MDYxNTg0NSAwLjU0Njg3NSAxLjQyMTczOTYgMC44MTI1bC0wLjIxOTAxNzk4IDEuNjA5Mzc1cS0xLjAxNTU4ODggLTAuMjE4NzUgLTEuNjQwNTA0OCAtMC43MTg3NXEtMC42NDA1NDIwMyAtMC41IC0wLjk4NDEzMzcgLTEuNDUzMTI1cS0wLjM0MzU5MTcgLTAuOTUzMTI1IC0wLjM0MzM4NTcgLTIuMTg3NXEyLjA3OTAxRS00IC0xLjI1IDAuMjk3MjA5NzQgLTIuMDE1NjI1cTAuMjgxMzgwNjUgLTAuNzgxMjUgMC43MzQ1NjQ4IC0xLjE0MDYyNXEwLjQzNzU2Mjk0IC0wLjM3NSAxLjEwOTQ2MDggLTAuNTE1NjI1cTAuNDIxODg4MzUgLTAuMDc4MTI1IDEuNTE1NjM3NCAtMC4wNzgxMjVsMi4xODc1IDBxMi4yODEyNSAwIDIuODkwNjQ0IC0wLjEwOTM3NXEwLjU5Mzc2OTEgLTAuMTA5Mzc1IDEuMTU2MzE2OCAtMC40MDYyNWwtMi44MjI4NzZFLTQgMS43MDMxMjVxLTAuNTE1NjY4ODcgMC4yNjU2MjUgLTEuMTg3NTU1MyAwLjMyODEyNXptLTMuNjcxODk4IDAuMTQwNjI1cTAuMzc0ODUxMjMgMC44OTA2MjUgMC42MjQ1NTU2IDIuNjcxODc1cTAuMTQwNDU1MjUgMS4wMTU2MjUgMC4zMjc4ODY1OCAxLjQzNzVxMC4xODc0Mjk0MyAwLjQyMTg3NSAwLjUzMTEzOTQgMC42NTYyNXEwLjM0MzcxMzc2IDAuMjE4NzUgMC43ODEyMTM3NiAwLjIxODc1cTAuNjU2MjUgMCAxLjA5MzgzMzkgLTAuNXEwLjQzNzU4MzkyIC0wLjUgMC40Mzc3NDIyMyAtMS40NTMxMjVxMS41NDQ5NTI0RS00IC0wLjkzNzUgLTAuNDA1OTczNDMgLTEuNjcxODc1cS0wLjQyMTc0OTExIC0wLjc1IC0xLjE0MDQ0MTkgLTEuMDkzNzVxLTAuNTYyNDU2MTMgLTAuMjY1NjI1IC0xLjY0MDU4MTEgLTAuMjY1NjI1bC0wLjYwOTM3NSAwem0zLjM5MTkyIC03Ljc4MTk4MjRsMS40NTMxNjMxIC0wLjIzNDM3NXEwLjE0MDUxMDU2IDAuNjg3NSAwLjE0MDQyMDkxIDEuMjM0Mzc1cS0xLjQ4NzczMkUtNCAwLjg5MDYyNSAtMC4yODE0ODI3IDEuMzkwNjI1cS0wLjI4MTMzMDEgMC40ODQzNzUgLTAuNzM0NDg5NDQgMC42ODc1cS0wLjQ2ODc4MjQyIDAuMjAzMTI1IC0xLjkzNzUzMjQgMC4yMDMxMjVsLTUuNTc4MTI2IDBsLTIuMDAyNzE2RS00IDEuMjAzMTI1bC0xLjI2NTYyNSAwbDIuMDAyNzE2RS00IC0xLjIwMzEyNWwtMi4zOTA2MjUgMGwtMC45ODQxMDUxIC0xLjYyNWwzLjM3NTAwMSAwbDIuNzQ2NTgyRS00IC0xLjY1NjI1bDEuMjY1NjI1IDBsLTIuNzQ2NTgyRS00IDEuNjU2MjVsNS42NzE4NzQgMHEwLjY4NzUgMCAwLjg5MDYzODM1IC0wLjA3ODEyNXEwLjIwMzE0MDI2IC0wLjA5Mzc1IDAuMzI4MTcyNjggLTAuMjgxMjVxMC4xMDk0MDc0MjUgLTAuMjAzMTI1IDAuMTA5NDcwMzcgLTAuNTc4MTI1cTQuMzg2OTAyRS01IC0wLjI2NTYyNSAtMC4wNjIzNzk4MzcgLTAuNzE4NzV6bTEuNDcwMDY5OSAtNy45MzMyODg2bC0xLjQyMTg3NSAwcTEuNjQwNDM4MSAxLjEyNSAxLjY0MDExNTcgMy4wNjI1cS0xLjQzMDUxMTVFLTQgMC44NTkzNzUgLTAuMzI4MzkzOTQgMS42MDkzNzVxLTAuMzI4MjQ3MDcgMC43MzQzNzUgLTAuODI4MzA2MiAxLjA5Mzc1cS0wLjUwMDA1OTEgMC4zNTkzNzUgLTEuMjE4ODMzOSAwLjVxLTAuNDY4NzY3MTcgMC4xMDkzNzUgLTEuNTMxMjY3MiAwLjEwOTM3NWwtNS45ODQzNzYgMGwyLjcyNzUwODVFLTQgLTEuNjQwNjI1bDUuMzU5Mzc2IDBxMS4yODEyNSAwIDEuNzM0MzkyMiAtMC4xMDkzNzVxMC42NDA2NTE3IC0wLjE1NjI1IDEuMDE1NzM1NiAtMC42NTYyNXEwLjM3NTA4MjAyIC0wLjUgMC4zNzUyMDQxIC0xLjIzNDM3NXExLjIyMDcwMzFFLTQgLTAuNzM0Mzc1IC0wLjM3NDc3MTEyIC0xLjM3NXEtMC4zOTA1MTYyOCAtMC42NTYyNSAtMS4wMzEwOTU1IC0wLjkyMTg3NXEtMC42NTYyMDYxMyAtMC4yNjU2MjUgLTEuODkwNTgxMSAtMC4yNjU2MjVsLTUuMTg3NTAxIDBsMi43MzcwNDUzRS00IC0xLjY0MDYyNWw5LjY3MTg3NSAwbC0yLjQ0MTQwNjJFLTQgMS40Njg3NXptNi42OTQ3OTM3RS00IC00LjAzMTk4MjRsLTkuNjcxODc0IDBsMi40NDE0MDYyRS00IC0xLjQ2ODc1bDEuNDY4NzUgMHEtMS4wMzExNTY1IC0wLjU2MjUgLTEuMzU5MjAzMyAtMS4wMzEyNXEtMC4zMjgwNDQ5IC0wLjQ4NDM3NSAtMC4zMjc5NDg1NyAtMS4wNjI1cTEuMzgyODI3OEUtNCAtMC44MjgxMjUgMC41MzE1MzEzMyAtMS42ODc1bDEuNTE1NTMwNiAwLjU2MjVxLTAuMzU5NDc2MSAwLjYwOTM3NSAtMC4zNTk1NzQzMiAxLjIwMzEyNXEtOS4xNTUyNzM0RS01IDAuNTQ2ODc1IDAuMzI3OTYzODMgMC45Njg3NXEwLjMyODA1NDQzIDAuNDIxODc1IDAuODkwNTIyOTYgMC42MDkzNzVxMC44NzQ5NTMyNyAwLjI4MTI1IDEuOTIxODI4MyAwLjI4MTI1bDUuMDYyNSAwbC0yLjcwODQzNUUtNCAxLjYyNXptLTMuMTA3MjM2OSAtMTIuODUzMzAybDAuMjAzNDA3MjkgLTEuNjg3NXExLjQ4NDMwNjMgMC40MDYyNSAyLjMxMjI1MiAxLjQ4NDM3NXEwLjgxMjMyMDcgMS4wNzgxMjUgMC44MTIwNDAzIDIuNzY1NjI1cS0zLjUyODU5NUUtNCAyLjEyNSAtMS4yOTc0MzU4IDMuMzc1cS0xLjMxMjcwNiAxLjIzNDM3NSAtMy42NzIwODEgMS4yMzQzNzVxLTIuNDUzMTI1IDAgLTMuNzk2NjY3IC0xLjI1cS0xLjM0MzUzOTIgLTEuMjY1NjI1IC0xLjM0MzIwNjQgLTMuMjY1NjI1cTMuMjEzODgyNEUtNCAtMS45Mzc1IDEuMzI4NjQ5NSAtMy4xNTYyNXExLjMxMjcwNSAtMS4yMzQzNzUgMy43MDMzMzEgLTEuMjM0Mzc1cTAuMTU2MjUgMCAwLjQzNzUgMGwtMC4wMDEyMDE2Mjk2IDcuMjE4NzVxMS41OTM3NjUzIC0wLjA5Mzc1IDIuNDUzMjc1NyAtMC45MDYyNXEwLjg0Mzg4NTQgLTAuODEyNSAwLjg0NDA4NTcgLTIuMDE1NjI1cTEuNTA2ODA1NEUtNCAtMC45MDYyNSAtMC40Njg0OTI1IC0xLjU0Njg3NXEtMC40ODQyNjgyIC0wLjY0MDYyNSAtMS41MTU0NTcyIC0xLjAxNTYyNXptLTIuNjU3MTQ2NSA1LjM5MDYyNWw5LjAwMjY4NTVFLTQgLTUuNDA2MjVxLTEuMjE4NzY4MSAwLjEwOTM3NSAtMS44MjgyMjkgMC42MjVxLTAuOTUzMjU1NjUgMC43ODEyNSAtMC45NTM0NjM1NSAyLjAzMTI1cS0xLjg2OTIwMTdFLTQgMS4xMjUgMC43NjUzMDg0IDEuOTA2MjVxMC43NDk4NzIyIDAuNzY1NjI1IDIuMDE1NDgzOSAwLjg0Mzc1em0yLjg3NjQxMTQgLTguNDg1MDc3bC0wLjI0OTcyOTE2IC0xLjYyNXEwLjk2ODc3MSAtMC4xMjUgMS41MDAxMjU5IC0wLjc1cTAuNTE1NzI4IC0wLjYyNSAwLjUxNTkxNDkgLTEuNzVxMS44NjkyMDE3RS00IC0xLjEyNSAtMC40NTI4NDY1MyAtMS42NzE4NzVxLTAuNDY4NjU4NDUgLTAuNTQ2ODc1IC0xLjA5MzY1ODQgLTAuNTQ2ODc1cS0wLjU0Njg3NSAwIC0wLjg3NTA4MiAwLjQ4NDM3NXEtMC4yMTg4MDM0IDAuMzI4MTI1IC0wLjU0NzE1MTU3IDEuNjcxODc1cS0wLjQ2OTA1MTM2IDEuODEyNSAtMC43OTcyOTQ2IDIuNTE1NjI1cS0wLjMyODIzOTQ0IDAuNjg3NSAtMC45MDY0MjM1NyAxLjA0Njg3NXEtMC41OTM4MDkxIDAuMzU5Mzc1IC0xLjMxMjU2MDEgMC4zNTkzNzVxLTAuNjQwNjI1IDAgLTEuMTg3NDUwNCAtMC4yOTY4NzVxLTAuNTYyNDUwNCAtMC4yOTY4NzUgLTAuOTIxNzM5NiAtMC44MTI1cS0wLjI4MTE4OCAtMC4zNzUgLTAuNDY4NTc5MyAtMS4wMzEyNXEtMC4yMDMwMTI0NyAtMC42NzE4NzUgLTAuMjAyODg4NDkgLTEuNDIxODc1cTEuODk3ODExOUUtNCAtMS4xNDA2MjUgMC4zMjg0NTc4MyAtMi4wcTAuMzI4MjY4MDUgLTAuODU5Mzc1IDAuODkwODM1NzYgLTEuMjY1NjI1cTAuNTYyNTcwNiAtMC40MjE4NzUgMS41MDAwOTYzIC0wLjU3ODEyNWwwLjIxODQ4MjAyIDEuNjA5Mzc1cS0wLjc1MDAxODEgMC4xMDkzNzUgLTEuMTcxOTgwOSAwLjY0MDYyNXEtMC40MjE5NjA4MyAwLjUxNTYyNSAtMC40MjIxMjAxIDEuNDY4NzVxLTEuODk3ODExOUUtNCAxLjE0MDYyNSAwLjM3NDczMDEgMS42MjVxMC4zNzQ5MjE4IDAuNDY4NzUgMC44NzQ5MjE4IDAuNDY4NzVxMC4zMTI1IDAgMC41NzgxNTY1IC0wLjE4NzVxMC4yNjU2NTkzMyAtMC4yMDMxMjUgMC40Mzc2MDY4IC0wLjY0MDYyNXEwLjA5Mzc4ODE1IC0wLjIzNDM3NSAwLjQyMjExMzQyIC0xLjQzNzVxMC40NTM0MTY4MiAtMS43NSAwLjc1MDQwNjI3IC0yLjQzNzVxMC4yOTY5ODk0NCAtMC42ODc1IDAuODU5NTU0MyAtMS4wNzgxMjVxMC41NjI1NjQ4NSAtMC4zOTA2MjUgMS40MDYzMTQ4IC0wLjM5MDYyNXEwLjgyODEyNSAwIDEuNTQ2Nzk0OSAwLjQ4NDM3NXEwLjcxODY3MTggMC40Njg3NSAxLjEyNDc3MTEgMS4zNzVxMC4zOTA0NzQzMiAwLjkwNjI1IDAuMzkwMjgzNTggMi4wNDY4NzVxLTMuMTA4OTc4M0UtNCAxLjg3NSAtMC43ODE3Mjg3NCAyLjg3NXEtMC43ODE0MTIxIDAuOTg0Mzc1IC0yLjMyODMzMyAxLjI1eiIgZmlsbC1ydWxlPSJub256ZXJvIi8+PHBhdGggZmlsbD0iIzAwMDAwMCIgZD0ibTQ4LjUxNDg4NSAzNDcuNDE1NjJxLTEuNzAzMzUwMSAxLjM1OTM3NSAtNC4wMDAzODE1IDIuMjk2ODc1cS0yLjI5NzAzMTQgMC45Mzc1IC00Ljc2NTc4MTQgMC45Mzc1cS0yLjE1NjI1IDAgLTQuMTQwNTA2NyAtMC43MDMxMjVxLTIuMzEyMzYyNyAtMC44MjgxMjUgLTQuNTkzMzI4NSAtMi41MzEyNWwxLjk0NTQ5NTZFLTQgLTEuMTcxODc1cTEuODkwNDQzOCAxLjA5Mzc1IDIuNzAyODgyOCAxLjQ1MzEyNXExLjI0OTkwODQgMC41NDY4NzUgMi42MjQ4NTUgMC44NzVxMS43MDMwNjAyIDAuMzkwNjI1IDMuNDIxODEwMiAwLjM5MDYyNXE0LjM3NSAwIDguNzUwNDU0IC0yLjcxODc1bC0xLjk4MzY0MjZFLTQgMS4xNzE4NzV6bS0zLjkyMTMyMTkgLTMuMzIyMDUybC0xMy4zNTkzNzMgMGw5Ljg0MTkxOUUtNCAtNS45MjE4NzVxMi45NTYzOTA0RS00IC0xLjc4MTI1IDAuMzU5ODI1MTMgLTIuNzAzMTI1cTAuMzU5NTMxNCAtMC45Mzc1IDEuMjgxNDk2IC0xLjQ4NDM3NXEwLjkwNjM0NTM3IC0wLjU2MjUgMi4wMTU3MjA0IC0wLjU2MjVxMS40MDYyNSAwIDIuMzkwNDcyNCAwLjkyMTg3NXEwLjk2ODU5MzYgMC45MjE4NzUgMS4yMzM5MDIgMi44NDM3NXEwLjM0Mzg2NDQ0IC0wLjcwMzEyNSAwLjY3MjA1NDMgLTEuMDc4MTI1cTAuNzAzMjUwOSAtMC43NjU2MjUgMS43NjU4NjUzIC0xLjQ1MzEyNWwzLjY0MTAxMDMgLTIuMzI4MTI1bC0zLjY2MjEwOTRFLTQgMi4yMTg3NWwtMi43ODE1NDM3IDEuNzY1NjI1cS0xLjIwMzI1NDcgMC43ODEyNSAtMS44MjgzMzg2IDEuMjgxMjVxLTAuNjQwNzA4OSAwLjUgLTAuODkwNzc3NiAwLjkwNjI1cS0wLjI2NTY4OTg1IDAuMzkwNjI1IC0wLjM1OTUwNDcgMC43OTY4NzVxLTAuMDc4MTc0NTkgMC4yOTY4NzUgLTAuMDc4Mjg5MDMgMC45ODQzNzVsLTMuNDMzMjI3NUUtNCAyLjA0Njg3NWw1LjkzNzUgMGwtMi45MzczMTdFLTQgMS43NjU2MjV6bS03LjQ1MjgzMTMgLTEuNzY1NjI1bDYuMzMyMzk3NUUtNCAtMy43OTY4NzVxMi4wMjE3ODk2RS00IC0xLjIxODc1IC0wLjI0OTY4NzIgLTEuODkwNjI1cS0wLjI2NTUxMDU2IC0wLjY4NzUgLTAuODEyMzI0NSAtMS4wNDY4NzVxLTAuNTQ2ODEzOTYgLTAuMzU5Mzc1IC0xLjE4NzQzOSAtMC4zNTkzNzVxLTAuOTUzMTI1IDAgLTEuNTYyNjE0NCAwLjY4NzVxLTAuNjA5NDg5NDQgMC42ODc1IC0wLjYwOTc0MTIgMi4xODc1bC03LjAxOTA0M0UtNCA0LjIxODc1bDQuNDIxODc1IDB6bTIuNjExMTgzMiAtMTAuODYzNTU2cS0yLjY4NzUgMCAtMy45Njg1MDIgLTEuNDg0Mzc1cS0xLjA3NzkxOSAtMS4yNSAtMS4wNzc2MTc2IC0zLjA0Njg3NXEzLjMxODc4NjZFLTQgLTIuMCAxLjMxMzA0MTcgLTMuMjY1NjI1cTEuMjk3MDg0OCAtMS4yNjU2MjUgMy42MDk1ODQ4IC0xLjI2NTYyNXExLjg1OTM3NSAwIDIuOTM3NDA4NCAwLjU2MjVxMS4wNjI0MDQ2IDAuNTYyNSAxLjY1NTk3NTMgMS42NDA2MjVxMC41OTM1NzQ1IDEuMDYyNSAwLjU5MzM2NDcgMi4zMjgxMjVxLTMuMzk1MDgwNkUtNCAyLjAzMTI1IC0xLjI5NzQyMDUgMy4yODEyNXEtMS4zMTI3MDk4IDEuMjUgLTMuNzY1ODM0OCAxLjI1em0yLjgyMjg3NkUtNCAtMS42ODc1cTEuODU5Mzc1IDAgMi43OTcwMDQ3IC0wLjc5Njg3NXEwLjkyMjAxMjMgLTAuODEyNSAwLjkyMjIxODMgLTIuMDQ2ODc1cTIuMDIxNzg5NkUtNCAtMS4yMTg3NSAtMC45MjE1MzkzIC0yLjAzMTI1cS0wLjkzNzM2MjcgLTAuODEyNSAtMi44NDM2MTI3IC0wLjgxMjVxLTEuNzk2ODc1IDAgLTIuNzE4ODg3MyAwLjgxMjVxLTAuOTIyMDA4NSAwLjgxMjUgLTAuOTIyMjEwNyAyLjAzMTI1cS0yLjA1OTkzNjVFLTQgMS4yMzQzNzUgMC45MjE1MzE3IDIuMDQ2ODc1cTAuOTA2MTIwMyAwLjc5Njg3NSAyLjc2NTQ5NTMgMC43OTY4NzV6bTQuODQ1NTkyNSAtMTEuMDc4ODU3bC05LjY3MjM3MSAyLjk2ODc1bDIuODYxMDIzRS00IC0xLjcwMzEyNWw1LjU3ODM3NyAtMS41MzEyNWwyLjA3ODIyNDIgLTAuNTc4MTI1cS0wLjE1NjI0MjM3IC0wLjA0Njg3NSAtMS45OTk5MTk5IC0wLjVsLTUuNjU1OTkwNiAtMS41NDY4NzVsMi43ODQ3MjlFLTQgLTEuNjg3NWw1LjYwOTYxNTMgLTEuNDM3NWwxLjg0MzgzMDEgLTAuNDg0Mzc1bC0xLjg1OTI3OTYgLTAuNTYyNWwtNS41OTM0NzUzIC0xLjY1NjI1bDIuNjcwMjg4RS00IC0xLjU5Mzc1bDkuNjcxMzY4IDMuMDMxMjVsLTIuODIyODc2RS00IDEuNzAzMTI1bC01Ljc5NzEzMDYgMS41MzEyNWwtMS42NDA2ODYgMC4zNzVsNy40MzcxNzU4IDEuOTUzMTI1bC0yLjg2MTAyM0UtNCAxLjcxODc1em0tMi44ODg3OTAxIC0xMS4wMzU0MzFsLTAuMjQ5NzI5MTYgLTEuNjI1cTAuOTY4NzY5MSAtMC4xMjUgMS41MDAxMjU5IC0wLjc1cTAuNTE1NzI4IC0wLjYyNSAwLjUxNTkxNDkgLTEuNzVxMS44NjkyMDE3RS00IC0xLjEyNSAtMC40NTI4NDY1MyAtMS42NzE4NzVxLTAuNDY4NjU4NDUgLTAuNTQ2ODc1IC0xLjA5MzY1ODQgLTAuNTQ2ODc1cS0wLjU0Njg3NSAwIC0wLjg3NTA4MDEgMC40ODQzNzVxLTAuMjE4ODA3MjIgMC4zMjgxMjUgLTAuNTQ3MTUzNSAxLjY3MTg3NXEtMC40NjkwNTEzNiAxLjgxMjUgLTAuNzk3Mjk0NiAyLjUxNTYyNXEtMC4zMjgyMzk0NCAwLjY4NzUgLTAuOTA2NDI1NSAxLjA0Njg3NXEtMC41OTM4MDcyIDAuMzU5Mzc1IC0xLjMxMjU1NzIgMC4zNTkzNzVxLTAuNjQwNjI1IDAgLTEuMTg3NDUwNCAtMC4yOTY4NzVxLTAuNTYyNDUwNCAtMC4yOTY4NzUgLTAuOTIxNzQxNSAtMC44MTI1cS0wLjI4MTE4ODk2IC0wLjM3NSAtMC40Njg1NzgzNCAtMS4wMzEyNXEtMC4yMDMwMTQzNyAtMC42NzE4NzUgLTAuMjAyODg4NDkgLTEuNDIxODc1cTEuOTA3MzQ4NkUtNCAtMS4xNDA2MjUgMC4zMjg0NTY4OCAtMi4wcTAuMzI4MjY5OTYgLTAuODU5Mzc1IDAuODkwODM0OCAtMS4yNjU2MjVxMC41NjI1NzI1IC0wLjQyMTg3NSAxLjUwMDA5OTIgLTAuNTc4MTI1bDAuMjE4NDc5MTYgMS42MDkzNzVxLTAuNzUwMDE1MjYgMC4xMDkzNzUgLTEuMTcxOTc4IDAuNjQwNjI1cS0wLjQyMTk2Mjc0IDAuNTE1NjI1IC0wLjQyMjEyMjk2IDEuNDY4NzVxLTEuODY5MjAxN0UtNCAxLjE0MDYyNSAwLjM3NDczMjk3IDEuNjI1cTAuMzc0OTE5OSAwLjQ2ODc1IDAuODc0OTE5OSAwLjQ2ODc1cTAuMzEyNSAwIDAuNTc4MTU1NSAtMC4xODc1cTAuMjY1NjU5MzMgLTAuMjAzMTI1IDAuNDM3NjA2OCAtMC42NDA2MjVxMC4wOTM3OTE5NiAtMC4yMzQzNzUgMC40MjIxMTUzMyAtMS40Mzc1cTAuNDUzNDE0OTIgLTEuNzUgMC43NTA0MDQzNiAtMi40Mzc1cTAuMjk2OTg5NDQgLTAuNjg3NSAwLjg1OTU1NDMgLTEuMDc4MTI1cTAuNTYyNTY0ODUgLTAuMzkwNjI1IDEuNDA2MzE0OCAtMC4zOTA2MjVxMC44MjgxMjUgMCAxLjU0Njc5NDkgMC40ODQzNzVxMC43MTg2NzM3IDAuNDY4NzUgMS4xMjQ3NzExIDEuMzc1cTAuMzkwNDc2MjMgMC45MDYyNSAwLjM5MDI4NTUgMi4wNDY4NzVxLTMuMTI4MDUxOEUtNCAxLjg3NSAtMC43ODE3MjY4NCAyLjg3NXEtMC43ODE0MTQwMyAwLjk4NDM3NSAtMi4zMjgzMzQ4IDEuMjV6bTYuODE0MzQyNSAtMTEuMDYyNWwtMS45ODM2NDI2RS00IDEuMTg3NXEtNC4zNzQ1NDYgLTIuNzM0Mzc1IC04Ljc0OTU0NiAtMi43MzQzNzVxLTEuNzE4NzUgMCAtMy4zOTA2ODk4IDAuMzkwNjI1cS0xLjM3NTA1MzQgMC4zMTI1IC0yLjYyNTE0NSAwLjg3NXEtMC44MjgxODYwNCAwLjM1OTM3NSAtMi43MzQ2MjEgMS40Njg3NWwxLjk4MzY0MjZFLTQgLTEuMTg3NXEyLjI4MTUzNDIgLTEuNzAzMTI1IDQuNTk0MTcxNSAtMi41MzEyNXExLjk4NDQ4OTQgLTAuNjg3NSA0LjE0MDczOTQgLTAuNjg3NXEyLjQ2ODc1IDAgNC43NjU0Njg2IDAuOTM3NXEyLjI5NjcxODYgMC45Mzc1IDMuOTk5NjIyMyAyLjI4MTI1eiIgZmlsbC1ydWxlPSJub256ZXJvIi8+PC9nPjwvc3ZnPg==)

https://bioconductor.org/packages/release/bioc/vignettes/SummarizedExperiment/inst/doc/SummarizedExperiment.html

```R
```

```R
```

```R
```

```R
```

```R
```

```R
```
