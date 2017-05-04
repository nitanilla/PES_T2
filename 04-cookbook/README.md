# Cookbook

Autor: Eduardo Tiomno Tolmasquim

O estilo Cookbook feito em Lua 5.1.4.

------------------------------

Funcionamento e lógica:

- O estilo recebe o nome de "Receita de Bolo", pois assim como seu homônimo, é uma sequência bem definida de passos.

- Os estados do algorítmo são definidos por variáveis globais.

- Todos os passos do algorítmos são chamados na função principal (main) 

------------------------------

As 6 Regras do Engenheiro de Software:

- **Não invente nomes**: 
    Os nomes das variáveis seguem o mesmo padrão e mantém coerência por todo o programa.
- **Intervalo Mágico**: 
    Como os estados são definidos por variáveis globais, a modularização não é boa. Nada impede que uma função mexa em uma variável indevida, causando comportamentos inesperados no programa.
- **Desenho Limpo**: 
    Há um passo-a-passo bem definido, que facilita a compreensão.
- **Identificação**: 
    O Github identifica a autoria e informações das versões pelos commits feitos. Também é possível verificar esta regra pelo início da documentação no código.
- **Verificação e Validação**:
    Este estilo não faz verificações.
    
- **Livro Diário**: Presente no arquivo **Diario_Eduardo.md**

------------------------------

Para executar:

- Abrir janela do CMD (Windows) ou Terminal (Linux/Mac)
- Posicionar a linha de comando no endereço **../04-cookbook**
- Digitar **lua cookbook.lua ../pride-and-prejudice.txt**

------------------------------

Referências:

1 - https://github.com/crista/exercises-in-programming-style/tree/master/04-cookbook
