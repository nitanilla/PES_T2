# Pipeline

Autor: Eduardo Tiomno Tolmasquim

O estilo Pipeline feito em Lua 5.1.4.

------------------------------

Funcionamento e lógica:

- O estilo recebe o nome de "Duto", pois assim como os dutos de água, ou petróleo, a informação flui em um sentido único.

- Cada passo do algorítmo é uma função.

- A saíde de uma função serve como argumento para a próxima função.

- Todos os passos do algorítmos são chamados encadeadamente na função principal (main) 

------------------------------

As 6 Regras do Engenheiro de Software:

- **Não invente nomes**: 
    Os nomes das variáveis seguem o mesmo padrão e mantém coerência por todo o programa.
- **Intervalo Mágico**: 
    O programa é bem modularizado, pois as funções só têm acesso à suas variáveis locais.
- **Desenho Limpo**: 
    Há um passo-a-passo bem definido, que facilita a compreensão.
- **Identificação**: 
    O Github identifica a autoria e informações das versões pelos commits feitos. Também é possível verificar esta regra pelo início da documentação no código.
- **Verificação e Validação**:
    O próprio tipo dos parâmetros e dos valores de retorno são uma espécie de verificação.
    
- **Livro Diário**: Presente no arquivo **Diario_Eduardo.md**

------------------------------

Para executar:

- Abrir janela do CMD (Windows) ou Terminal (Linux/Mac)
- Posicionar a linha de comando no endereço **../05-pipeline**
- Digitar **lua pipeline.lua ../pride-and-prejudice.txt**

------------------------------

Referências:

1 - https://github.com/crista/exercises-in-programming-style/tree/master/05-pipeline
