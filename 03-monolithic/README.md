# Monolithic

Autor: Nino Fabrizio Tiriticco Lizardo

O estilo Monolithic feito em Lua 5.1.4.

------------------------------

Funcionamento e lógica:

O estilo segue a base de programas construídos de forma monolítica, ou seja, um bloco inteiro que faz todos os processos necessários para alcançar a finalidade. A autora não faz uso de bibliotecas que façam tarefas muito complexas, reforçando a ideia do código ser monolítico.

O programa usa uma estrutura global para guardar palavras e suas frequências. Ele começa abrindo o arquivo **stop_words.txt** e guardando seu conteúdo em uma outra estrutura.

Em seguida inicia um loop onde pega uma linha do arquivo de leitura a ser analisado a cada iteração. Dentro desse loop existe um outro loop onde se procura identificar o início e fim de palavras na respectiva linha lida, atualizando na estrutura global a frequência de cada palavra se não for stop word.

Se a palavra identificada se encontra na estrutura global, sua frequência é aumentada em 1. Se não se encontra, a palavra é simplesmente adicionada na estrutura e tem atribuída a ela o valor 1 como frequência.

O programa sempre se certifica de que a estrutura esteja em ordem decrescente de frequência, rearrumando a estrutura global quando necessário.

Depois de terminar o loop principal, o programa simplesmente mostra as 25 primeiras entradas da estrutura global.

------------------------------

As 6 Regras do Engenheiro de Software:

- **Não invente nomes**: Os nomes das variáveis foram adaptados para se encaixarem melhor na lógica do programa e facilitar a leitura do mesmo.
- **Intervalo Mágico**: Não é possível empregar esta regra no estilo, pois ele tem como lógica executar todas as tarefas do código em um único bloco. Ou seja, ele não faz uso de modularização.
- **Desenho Limpo**: Presente no arquivo **Monolithic_Architecture.pdf**.
- **Identificação**: O Github identifica a autoria e informações das versões pelos commits feitos. Também é possível verificar esta regra pelo início da documentação no código.
- **Verificação e Validação**:

Se os arquivos lidos não existem ou o endereço especificado está errado, o programa acusa erro e intorrompe a execução ao tentar executar **file:read** (linha 18) e **io.lines** (linha 28). Espera-se que os arquivos lidos tenham conteúdo dentro deles.

Cada caracter é lido um a um (linha 82 atualiza o índice do caracter) da respectiva linha por esta estar contida dentro de uma String e se usa o seu tamanho como referência (atenção para o caracter de fim de String ser incluído) (linha 32).

Uma String equivalendo a uma palavra é inserida na variável **word** (linha 43) através de uma subtring da respectiva linha quando são guardados índices anteriormente ao se identificar um character como alfanumérico (linha 35) para incício de palavra e um character como não-alfanumérico (linha 40) como fim dessa palavra.

A palavra lida é verificada como não sendo stop word (linha 47) pelo conteúdo da estrutura preenchida anteriormente ao ler **stop_words.txt**.

Quando a palavra está na tabela global (inicializada na linha 13) contendo {palavra, frequência} (linha 52), sua frequência é aumentada em 1 (linha 53) e uma flag especificada anteriormente (linha 42) é ativada. Quando a flag acusa que não está (linha 59), é incluída na tabela e tem atribuída a frequência 1.

Se verifica que a tabela global seja reorganizada quando uma palavra já presente (condição if-else da linha 59) tem sua frequência aumentada (linha 53) e a tabela possui mais de uma palavra (linha 61). A tabela só é verificada a partir do índice dessa palavra (linha 57 ajusta seu valor) até o topo da tabela (linha 64). São comparadas as frequências de uma palavra pela a que está diretamente acima dela na tabela (linha 65) e caso a de baixo seja maior, elas trocam de lugar na tabela (da linha 67 à linha 72).

Os passos acima garantem que a tabela global possui os dados esperados ao serem mostrados na sequência final do código (linha 87).
- **Livro Diário**: Presente no arquivo **Diario_Nino.md**

------------------------------

Para executar:

- Abrir janela do CMD (Windows) ou Terminal (Linux/Mac)
- Posicionar a linha de comando no endereço **../03-monolithic**
- Digitar **lua Monolithic.lua ../pride-and-prejudice.txt**

------------------------------

Referências:

1 - https://github.com/crista/exercises-in-programming-style/tree/master/03-monolith