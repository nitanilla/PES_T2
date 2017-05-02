# Letterbox

Autor: Nino Fabrizio Tiriticco Lizardo

O estilo Letterbox feito em Lua 5.1.4.

------------------------------

Funcionamento e lógica:

O estilo é baseado em Orientação a Objetos, usando a lógica da troca de mensagens entre componentes de Sistemas Distribuídos em que tarefas são divididas entre várias componentes para alcançar uma finalidade.

O arquivo mandado de entrada para a execução é lido e tem seu conteúdo guardado em uma string e depois dividido em uma lista de palavras.

As palavras extraídas são comparadas a palavras contidas em outro arquivo (**stop_words.txt**), as equivalentes não passam através de um filtro.

As palavras restantes são contabilizadas por frequência de aparição no arquivo original de entrada e organizadas das de maior frequência para as de menor. Como resultado, as 25 mais frequentes são mostradas no console.

As etapas principais do programa foram divididas em objetos que só se comunicam entre si através de um método em comum (**dispatchMessage**) que trata a ação requerida pelo objeto de uma classe principal (**WordFrequencyController**) que é quem controla a ordem de execução das tarefas e mostra no console o resultado final.

------------------------------

As 6 Regras do Engenheiro de Software:

- **Não invente nomes**:
- **Intervalo Mágico**:
- **Desenho Limpo**:
- **Identificação**:
- **Verificação e Validação**:
- **Livro Diário**: Presente no arquivo **Diario_Nino.md**

------------------------------

Para executar:

- Abrir janela do CMD (Windows) ou Terminal (Linux)
- Posicionar a linha de comando no endereço onde se encontra o arquivo
- Digitar **lua Letterbox.lua ../pride-and-prejudice.txt**

------------------------------

Referências:

1 - https://github.com/crista/exercises-in-programming-style/tree/master/11-letterbox

2 - https://rosettacode.org/wiki/Generate_lower_case_ASCII_alphabet#Lua

3 - http://stackoverflow.com/questions/2038418/associatively-sorting-a-table-by-value-in-lua