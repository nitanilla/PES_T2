# Letterbox

Autor: Nino Fabrizio Tiriticco Lizardo

O estilo Letterbox feito em Lua 5.1.4.

------------------------------

Funcionamento:

O estilo é baseado em Orientação a Objetos, usando a lógica de sistemas distribuídos em que tarefas são divididas entre várias componentes para alcançar uma finalidade.

O arquivo mandado de entrada para a execução é lido e tem seu conteúdo dividido em uma lista de palavras.

As palavras extraídas são comparadas a palavras contidas em outro arquivo (**stop_words.txt**), as equivalentes são então eliminadas da lista original.

As que permanecem são contabilizadas por frequência no arquivo original de entrada e organizadas das de maior frequência para as de menor. Como resultado, as 25 mais frequentes são mostradas no console.

As etapas principais do programa foram divididas em objetos que só se comunicam entre si através de um método em comum (**dispatch**) que trata a ação requerida pelo objeto de chamada.

------------------------------

Para executar:

- Abrir janela do CMD (Windows) ou Terminal (Linux)
- Posicionar a linha de comando no endereço onde se encontra o arquivo
- Digitar **lua Letterbox.lua ../pride-and-prejudice.txt**

------------------------------

Referência:

https://github.com/crista/exercises-in-programming-style/tree/master/11-letterbox