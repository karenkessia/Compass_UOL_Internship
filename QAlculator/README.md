<table width="100%">
  <tr>
    <td width="60%" align="center" align="middle">
      <div align="center">
        <h1 style="display: inline-flex; align-items: center; gap: 10px;">
          QAlculator
        </h1>
        <p>
          Projeto desenvolvido aplicando <strong>TDD com Python</strong> e <strong>testes com Pytest</strong>.<br>
          Foram implementadas operações matemáticas com foco em boas práticas, versionamento com Git e organização de código.
        </p>
        <div>
          <img src="https://skillicons.dev/icons?i=python,git,github,vscode" alt="Ferramentas" />
        </div>
      </div>
    </td>
    <td align="center" valign="middle">
      <img src="https://sdmntprwestcentralus.oaiusercontent.com/files/00000000-9200-61fb-a49d-90d587f04d1e/raw?se=2025-05-16T04%3A09%3A23Z&sp=r&sv=2024-08-04&sr=b&scid=00000000-0000-0000-0000-000000000000&skoid=e9d2f8b1-028a-4cff-8eb1-d0e66fbefcca&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2025-05-15T21%3A20%3A31Z&ske=2025-05-16T21%3A20%3A31Z&sks=b&skv=2024-08-04&sig=xmQhOWrop8Ap7u6T%2BmyNpef%2B459SUE4/9GQUO/8Ye0A%3D" alt="Imagem Calculadora" width="250px"/>
    </td>
  </tr>
</table>

  <h2> Conteúdos Aplicados</h2>
  <ul>
    <li>Git e versionamento com commits descritivos</li>
    <li>Estrutura de projeto com organização por responsabilidade</li>
    <li>Testes automatizados com <strong>Pytest</strong></li>
    <li>Desenvolvimento guiado por testes (<strong>TDD</strong>)</li>
    <li>Uso de <strong>Python puro</strong> (sem <code>math</code>)</li>
  </ul>

  <h2>⚙️ Funcionalidades Implementadas</h2>
  <p>A classe <code>Calculadora</code> contém os seguintes métodos:</p>
  <table style="width: 100%; border-collapse: collapse; margin-top: 10px;">
    <thead style="background-color: #3e64ff; color: white;">
      <tr>
        <th style="padding: 10px; border: 1px solid #ccc;">Operação</th>
        <th style="padding: 10px; border: 1px solid #ccc;">Método</th>
        <th style="padding: 10px; border: 1px solid #ccc;">Descrição</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td style="padding: 10px; border: 1px solid #ccc;">➕ Adição</td>
        <td style="padding: 10px; border: 1px solid #ccc;">somar()</td>
        <td style="padding: 10px; border: 1px solid #ccc;">Soma dois números</td>
      </tr>
      <tr>
        <td style="padding: 10px; border: 1px solid #ccc;">➖ Subtração</td>
        <td style="padding: 10px; border: 1px solid #ccc;">subtrair()</td>
        <td style="padding: 10px; border: 1px solid #ccc;">Subtrai o segundo número do primeiro</td>
      </tr>
      <tr>
        <td style="padding: 10px; border: 1px solid #ccc;">✖️ Multiplicação</td>
        <td style="padding: 10px; border: 1px solid #ccc;">multiplicar()</td>
        <td style="padding: 10px; border: 1px solid #ccc;">Multiplica dois números</td>
      </tr>
      <tr>
        <td style="padding: 10px; border: 1px solid #ccc;">➗ Divisão</td>
        <td style="padding: 10px; border: 1px solid #ccc;">dividir()</td>
        <td style="padding: 10px; border: 1px solid #ccc;">Divide o primeiro número pelo segundo</td>
      </tr>
      <tr>
        <td style="padding: 10px; border: 1px solid #ccc;">📊 Média</td>
        <td style="padding: 10px; border: 1px solid #ccc;">media()</td>
        <td style="padding: 10px; border: 1px solid #ccc;">Calcula a média entre dois números</td>
      </tr>
      <tr>
        <td style="padding: 10px; border: 1px solid #ccc;">🔍 Verifica paridade</td>
        <td style="padding: 10px; border: 1px solid #ccc;">eh_par()</td>
        <td style="padding: 10px; border: 1px solid #ccc;">Retorna True se o número for par</td>
      </tr>
    </tbody>
  </table>

  <p><strong>ℹ️ Observação:</strong> Nenhuma operação utilizou a biblioteca <code>math</code>.</p>

  <h2> Testes com Pytest</h2>
  <p>Os testes foram escritos antes da implementação usando <strong>TDD</strong>. Eles estão localizados na pasta <code>tests/</code> e cobrem todos os métodos da classe.</p>

  <h2>📁 Estrutura do Projeto</h2>
  <pre style="background: #eee; padding: 10px; border-left: 5px solid #3e64ff;">
QAlculator/
├── calculadora/          # Código fonte
│   ├── __init__.py
│   ├── engine.py         # Lógica da calculadora
│   └── cli.py            # Interface de linha de comando
│
├── tests/                # Testes com Pytest
│   ├── __init__.py
│   └── test_engine.py
│
├── requirements.txt      # Dependências
└── README.md             # Documentação
  </pre>

  <h2> Como Executar o Projeto</h2>
  <ol>
    <li><strong>Clone o repositório:</strong>
      <pre>git clone https://github.com/karenkessia/Compass_UOL_Intership.git
cd QAlculator</pre>
    </li>
    <li><strong>Crie e ative o ambiente virtual:</strong>
      <pre># Linux/macOS
python -m venv venv
source venv/bin/activate

## Windows
venv\Scripts\activate</pre>
    </li>
    <li><strong>Instale as dependências:</strong>
      <pre>pip install -r requirements.txt</pre>
    </li>
    <li><strong>Execute os testes:</strong>
      <pre>pytest</pre>
    </li>
  </ol>

  <h2>🧭 Branches & Commits</h2>
  <p>Foi utilizada a branch <code>main</code> com commits frequentes e descritivos, seguindo as seguintes convenções:</p>
  <ul>
    <li><code>feat:</code> novas funcionalidades</li>
    <li><code>test:</code> criação ou manutenção de testes</li>
    <li><code>refactor:</code> refatorações no código</li>
    <li><code>style:</code> ajustes de formatação e estilo</li>
    <li><code>chore:</code> tarefas auxiliares (configs, etc.)</li>
  </ul>

  <h2>👩‍💻 Autora</h2>
  <p><strong>Karen Késsia</strong> – Estagiária em QA</p>
  <p>
    <a href="https://github.com/karenkessia" target="_blank">GitHub: @karenkessia</a>
  </p>
</body>
</html>

