# Letterbox

Autor: Nino Fabrizio Tiriticco Lizardo

O estilo Letterbox feito em Lua 5.1.4.

------------------------------

Funcionamento e lógica:

O estilo é baseado em Orientação a Objetos, usando a lógica da troca de mensagens entre componentes de Sistemas Distribuídos em que tarefas são divididas entre várias componentes para alcançar uma finalidade.

O arquivo mandado de entrada para a execução é lido e tem seu conteúdo guardado em uma string e depois dividido em uma lista de palavras.

As palavras extraídas são comparadas a palavras contidas em outro arquivo (**stop_words.txt**), as equivalentes não passam através de um filtro.

As palavras restantes são contabilizadas por frequência de aparição no arquivo original de entrada e organizadas das de maior frequência para as de menor. Como resultado, as 25 mais frequentes são mostradas no console.

As etapas principais do programa foram divididas em objetos de classes (representadas por tabelas globais) que só se comunicam entre si através de um método em comum (**dispatchMessage**), que trata a ação requerida ao chamar outros métodos(todos eles representados por funções tratadas como chaves nas suas respectivas tabelas/classes), pelo objeto de uma classe principal (**WordFrequencyController**) que é quem controla a ordem de execução das tarefas e mostra no console o resultado final.

------------------------------

As 6 Regras do Engenheiro de Software:

- **Não invente nomes**: Os nomes das variáveis, dos métodos e os identificadores das mensagens foram adaptados para se encaixarem melhor na lógica do programa e facilitar a leitura do mesmo.
- **Intervalo Mágico**: A regra já era aplicada originalmente pelo estilo ao ver que a divisão da tarefa principal é feita entre 4 classes, assim estando entre o intervalo [3, 6] definido.
- **Desenho Limpo**:
- **Identificação**: O Github identifica a autoria e informações das versões pelos commits feitos. Também é possível verificar esta regra pelo início da documentação no código.
- **Verificação e Validação**: As pré e pós condições dos métodos são inicialmente especificadas na documentação quando há parâmetros de entrada e se há retorno, respectivamente. Espera-se que os arquivos lidos tenham conteúdo dentro deles. A própria execução do programa serve como verificação quando se obtém o resultado esperado (uma listagem de palavras seguidas por valores numéricos representando frequências). Mais especificações abaixo.
* Classe **DataStorageManager**
	* Método **dispatchMessage**: Se o parâmetro **thisObject** passado não é da classe esperada ou não possui valor, o programa acusa erro de execução ao tentar chamar um de seus métodos. O conteúdo de id do parâmetro **message** é avaliado em um bloco if-else, se correto chama o respectivo método, se incorreto é mostrada uma mensagem de que a mensagem é inválida e o programa é interrompido.
	* Método **_getFileContent**: Se o parâmetro **thisObject** passado não é da classe esperada ou não possui valor, o programa acusa erro de execução ao tentar chamar o atributo atribuído à classe. Se o parâmetro **path_to_file** não for String o programa acusa erro e termina a execução ao executar a função **io.open**, se o arquivo não é aberto corretamente o programa acusa erro ao lê-lo em **file:read**. Se o conteúdo de **_fileData** não é uma String, o programa acusa erro ao chamar **gsub**, que é função do Lua que lida exclusivamente com String.
	* Método **_getWords**: Se o parâmetro **thisObject** passado não é da classe esperada ou não possui valor, o programa acusa erro de execução ao tentar chamar o atributo atribuído à classe. Se o conteúdo de **_fileData** não é uma String, o programa acusa erro ao chamar **gmatch**, que é função do Lua que lida exclusivamente com String.
* Classe **StopWordManager**
	* Método **dispatchMessage**: Idem à classe **DataStorageManager**.
	* Método **_getStopWords**: Se o parâmetro **thisObject** passado não é da classe esperada ou não possui valor, o programa acusa erro de execução ao tentar chamar o atributo atribuído à classe.
	* Método  **_is_stop_word**: Se o parâmetro **thisObject** passado não é da classe esperada ou não possui valor, o programa acusa erro de execução ao tentar chamar o atributo atribuído à classe.
* Classe **WordFrequencyManager**
	* Método **dispatchMessage**: Idem à classe **DataStorageManager**.	* Método **_increment_word_frequency**: Se o parâmetro **thisObject** passado não é da classe esperada ou não possui valor, o programa acusa erro de execução ao tentar chamar o atributo atribuído à classe.
	* Método **_get_sorted_table**: Se o parâmetro **thisObject** passado não é da classe esperada ou não possui valor, o programa acusa erro de execução ao tentar chamar o atributo atribuído à classe.
* Classe **WordFrequencyController**
	* Método **dispatchMessage**: Idem à classe **DataStorageManager**.
	* Método **_initiate_all**: Os objetos das outras classes existem ao serem atribuídos a **thisObject** por serem tabelas globais criadas antes desta classe no código. Os métodos chamados são executados com sucesso quando **dispatchMessage** não acusa erro de mensagem inválida ao ser chamado nos seus respectivos objetos.
	* Método **_execute**:  Se o parâmetro **thisObject** passado não é da classe esperada ou não possui valor, o programa acusa erro de execução ao tentar chamar os atributos atribuídos à classe. Os métodos chamados são executados com sucesso quando **dispatchMessage** não acusa erro de mensagem inválida ao ser chamado nos seus respectivos objetos.
- **Livro Diário**: Presente no arquivo **Diario_Nino.md**

------------------------------

Para executar:

- Abrir janela do CMD (Windows) ou Terminal (Linux/Mac)
- Posicionar a linha de comando no endereço **../11-letterbox**
- Digitar **lua Letterbox.lua ../pride-and-prejudice.txt**

------------------------------

Referências:

1 - https://github.com/crista/exercises-in-programming-style/tree/master/11-letterbox

2 - https://rosettacode.org/wiki/Generate_lower_case_ASCII_alphabet#Lua

3 - http://stackoverflow.com/questions/2038418/associatively-sorting-a-table-by-value-in-lua