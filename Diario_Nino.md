# Livro Diário
## Autor: Nino Fabrizio Tiriticco Lizardo



Data: 18/04/2017

No final da aula de Princípios de Engenharia de Software, conversei com o Eduardo sobre o que cada um pode ir fazendo em relação ao trabalho até a próxima aula. Concordamos em cada um dar uma olhada no repositório da Cristina Lopes para ver quais estilos trabalhar sobre e discutir no próximo encontro. Como são 4 estilos, pensamos que 2 para cada um é uma boa estratégia.

-----------------------------------------

Data: 19/04/2017

Baixei o repositório da autora Cristina Lopes do livro referente ao trabalho para poder analisar seu conteúdo e como funciona. Baixei também a versão 2.7.13 de Python para ver os resultados que os códigos retornam ao executá-los.

Através do livro, escolhi como um dos estilos a trabalhar o Letterbox (Capítulo 11 no livro). De início, já vi que ele é baseado em Orientação a Objetos. Como ainda não estou muito bem familiarizado com Lua, ainda preciso ver como representar OO nessa linguagem.

Criei este arquivo para registrar o que vou fazendo referente ao trabalho.

-----------------------------------------

Data: 20/04/2017

Comecei a ler o capítulo 11 do livro para entender melhor o estilo Letterbox. Pela explicação da autora, o estilo é baseado em comunicação por mensagens similar a sistemas distribuídos (onde tarefas são divididas entre componentes para chegar a uma finalidade).

Como ainda preciso entender como representar OO em Lua, penso que escolher um outro estilo mais simples como segundo estilo a trabalhar sobre seja o mais ideal. Com isso, escolhi o Monolith (Capítulo 3 no livro).

Informei ao Eduardo na aula sobre os estilos que escolhi, ele ainda está por escolher os outros 2 estilos.

-----------------------------------------

Data: 22/04/2017

Pesquisei na internet como montar um programa em OO em Lua, achei um código exemplo explicado. A princípio achei o modelo similar a Java e C++.

Executei o arquivo **tf-11.py** que contém o código sobre o estilo Letterbox para ver o resultado e tentar entender o que faz durante a execução. Aparentemente, ele abre o arquivo que mando por parâmetro de execução (**pride-and-prejudice.txt**), o lê e me retorna as primeiras 25 palavras consideradas não stop-words (pelo arquivo **stop_words.txt**) mais frequentes encontradas no arquivo original.

-----------------------------------------

Data: 23/04/2017

Implementei uma tradução direta da classe **DataStorageManager** de Python para Lua, tentando manter a tradução o mais direta possível. Fiquei em dúvida se os métodos **_init** e **_words** fazem em Lua o que é feito em Python, depois farei alguns testes simples com a classe. Por enquanto foquei em só fazer a tradução.

Criei o repositório para poder guardar o que foi feito referente ao trabalho. Penso em separar por pastas dentro dele os arquivos referentes a cada estilo, visto que alguns deles criam arquivos ao serem executados (estilo Good Old Times, por exemplo). Assim fica tudo mais organizado.

Arquivos como os de Livro Diário e os de leitura necessários para a execução dos programas inicialmente ficarão soltos no repositório.

-----------------------------------------

Data: 25/04/2017

Implementei a classe **StopWordManager** em Lua, tentando seguir processos similares ao código original. Vi que a autora fez uso de uma uma função que já faz parte da biblioteca original do Python para conseguir uma string contendo o alfabeto em ASCII, para resolver em Lua fiz uma implementação baseada em um link que achei (item 2 na parte de **Referências**).

Vi também uma melhor forma de popular minha tabela que me permite navegar melhor nela para procurar palavras usando as próprias palavras como chaves da tabela, implementei no meu código.

Após finalizar o código da classe, fiz testes simples no bloco de execução principal chamando os métodos da mesma forma que a autora faz (chamando o método **dispatch** com a mensagem do que me interessa fazer no objeto). Isso me possibilitou achar e corrigir erros simples no código da classe. Ela parece funcionar bem após as correções.

Aproveitei para testar também minha classe **DataStorageManager** anteriormente implementada, constatei alguns erros. O método **_init** não gera a string como planejava. Depois tentarei ver como fazer a correção, mas acredito que esteja fazendo o uso errado das funções auxiliares que chamo do Lua dentro do método. Deixarei por enquanto o código de teste que fiz.