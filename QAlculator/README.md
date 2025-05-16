

<table>
  <tr>
    <td><img src="https://sdmntprwestcentralus.oaiusercontent.com/files/00000000-9200-61fb-a49d-90d587f04d1e/raw?se=2025-05-16T04%3A09%3A23Z&sp=r&sv=2024-08-04&sr=b&scid=00000000-0000-0000-0000-000000000000&skoid=e9d2f8b1-028a-4cff-8eb1-d0e66fbefcca&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2025-05-15T21%3A20%3A31Z&ske=2025-05-16T21%3A20%3A31Z&sks=b&skv=2024-08-04&sig=xmQhOWrop8Ap7u6T%2BmyNpef%2B459SUE4/9GQUO/8Ye0A%3D" alt="Image" width="250" height="auto"></td>
</table>

##  Calculator

Este projeto foi desenvolvido como parte da Semana de Estudos sobre **Git, TDD (Test Driven Development)** e **Pytest**. A proposta principal foi criar uma **Calculadora em Python**, aplicando o conceito de desenvolvimento guiado por testes desde o início do processo de construção.


>  **Objetivo:** Desenvolver uma calculadora robusta utilizando Python e TDD, contendo as quatro operações básicas, mais duas adicionais à minha escolha, e com testes utilizando a biblioteca Pytest.

---

##  Conteúdos aplicados
-  Git e versionamento com commits descritivos
-  Estrutura de projeto com organização por responsabilidade
-  Testes com Pytest
-  Criação de código robusto com base em testes (TDD)
-  Python puro, **sem uso da biblioteca `math`**

---

##  Funcionalidades implementadas

A classe `Calculadora` foi desenvolvida com os seguintes métodos:

| Operação              | Método         | Descrição                                       |
|-----------------------|----------------|-------------------------------------------------|
| ➕ Adição             | `somar()`      | Soma dois números                              |
| ➖ Subtração          | `subtrair()`   | Subtrai o segundo número do primeiro           |
| ✖️ Multiplicação     | `multiplicar()`| Multiplica dois números                         |
| ➗ Divisão            | `dividir()`     | Divide o primeiro número pelo segundo           |
| 📊 Média              | `media()`       | Calcula a média entre dois números              |
|  Verificar se par  | `eh_par()`      | Retorna `True` se o número for par, senão `False`|

> ℹ️ Nenhuma operação utilizou a biblioteca `math`, conforme solicitado no desafio.

---

##  Testes 

Os testes foram escritos **antes da implementação dos métodos**, utilizando a abordagem TDD. Eles estão localizados na pasta `test/` e cobrem todos os métodos da classe `Calculadora`.

## Estrutura do projeto

PyTestCalc/
├── calculadora/         # Código fonte
│   ├── __init__.py
│   ├── engine.py        # Lógica da Calculadora
│   └── cli.py           # Interface de Linha de Comando (usuário)
│
├── tests/               # Testes com Pytest
│   ├── __init__.py
│   └── test_engine.py
│
├── dependencies.txt     # Lista de dependências (pytest)
├── README.md            # Documentação clara e objetiva


Como executar o projeto
1. Clone o repositório


git clone https://github.com/karenkessia/Compass_UOL_Intership.git
cd QAlculator

2. Crie e ative o ambiente virtual

python -m venv venv
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows

3. Instale as dependências

pip install -r requirements.txt
4. Execute os testes

pytest
🚀 Branches e Commits
A branch principal utilizada foi main, com commits diários e descritivos seguindo boas práticas:

feat: novas funcionalidades

test: criação de testes

refactor: alterações estruturais

style: indentação e ajustes visuais

chore: tarefas gerais
