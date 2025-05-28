<table width="70%" align="center">
  <tr>
    <td align="center">
      <img src="../Img/collage_robot_aws.png" alt="Imagem Principal" width="80%" />
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://img.shields.io/badge/status-%20concluído-black" />
      <img src="https://img.shields.io/badge/testes-automatizados-black" />
      <img src="https://img.shields.io/badge/robot-framework-black" />
    </td>
  </tr>
</table>


<div align="center">
  <p>
    Este projeto tem como objetivo automatizar testes da 
    <a href="https://restful-booker.herokuapp.com/apidoc/index.html" target="_blank">
      Restful Booker API
    </a> 
    utilizando <strong>Robot Framework</strong>, focando em autenticação, criação, consulta, atualização e remoção de reservas (bookings).
  </p>
</div>


<blockquote>
  <strong> Sobre a API:</strong><br>
  A <strong>Restful Booker</strong> é uma API para fins educacionais que permite testar operações <strong>CRUD</strong> com autenticação.<br>


</blockquote>

---

<h3> Estrutura do Projeto</h3>

 <pre style="background: #eee; padding: 10px; border-left: 5px solid #3e64ff;">
 RestFulBookerAPI/
├── keywords/
│   ├── Auth.robot
│   ├── CreateBooking.robot
│   ├── DeleteBooking.robot
│   ├── GetBooking.robot
│   ├── UpdateBooking.robot
│   └── _base.robot
│
├── resources/      # versão melhorada
│   ├── Auth.robot
│   ├── CreateBooking.robot
│   ├── DeleteBooking.robot
│   ├── GetBooking.robot
│   ├── UpdateBooking.robot
│   └── _base.robot
│
├── support/
│   └── common/
│       └── common_file.robot
│
├── tests/
│   └── tests.robot
│
├── requirements.txt
└── README.md
  </pre>


---

<h3>
  <img src="https://cdn.simpleicons.org/robotframework/white" alt="Robot Framework" width="24" style="vertical-align: middle;"/>
     Como Executar o Projeto</h3>


<h4>1. Pré-requisitos</h4>
<ul>
  <li>Python 3.8 ou superior</li>
  <li>Pip</li>
  <li>Git (opcional)</li>
</ul>

<h4>2. Clonar o repositório</h4>
<pre><code>git clone https://github.com/karenkessia/Compass_UOL_Intership.git
cd Compass_UOL_Intership/RestFulBookerAPI
</code></pre>

<h4>3. Instalar dependências</h4>
<p><strong>Com <code>requirements.txt</code>:</strong></p>
<pre><code>pip install -r requirements.txt
</code></pre>

<p><strong>Ou manualmente:</strong></p>
<pre><code>pip install robotframework
pip install robotframework-requests
</code></pre>

<h4>4. Executar os testes</h4>
<p><strong>Execução padrão:</strong></p>
<pre><code>robot tests/
</code></pre>

<p><strong>Com saída customizada (relatórios em <code>results/</code>):</strong></p>
<pre><code>robot -d results tests/
</code></pre>

---

<table>
  <tr>
    <td style="vertical-align: top; padding-right: 20px;">
      <h3> Relatórios Gerados</h3>
      <ul>
        <li><code>log.html</code> — Log detalhado da execução</li>
        <li><code>report.html</code> — Relatório geral</li>
        <li><code>output.xml</code> — Saída para integrações</li>
      </ul>
      <p><strong>✅ Todos os 5 testes passaram com sucesso.</strong></p>
    </td>
    <td>
      <img src="../Img/Captura de Tela (270).png" alt="Relatórios" width="600">
    </td>
  </tr>
</table>

<h3> Funcionalidades Testadas</h3>
<ul>
  <li> <strong>Autenticação</strong> e obtenção de token</li>
  <li> <strong>Criação</strong> de reservas (POST)</li>
  <li> <strong>Consulta</strong> de reservas (GET)</li>
  <li> <strong>Atualização</strong> de reservas (PUT)</li>
  <li> <strong>Exclusão</strong> de reservas (DELETE)</li>
</ul>

---

<h3> Referências</h3>
<ul>
  <li><strong>Documentação da Restful Booker API</strong> — <a href="https://restful-booker.herokuapp.com/apidoc/index.html" target="_blank">Ver API</a></li>
  <li><strong>Robot Framework</strong> — Ferramenta de automação de testes</li>
  <li><strong>RequestsLibrary</strong> — Biblioteca para testes HTTP com Robot Framework</li>
</ul>

---

<h3> Créditos Visuais</h3>
<p>Algumas imagens foram geradas com auxílio de inteligência artificial (Sora, by OpenAI).</p>

---

<h3>Autora</h3>
<p>
  <strong>Karen Késsia</strong><br>
  Estagiária em QA <br>
  GitHub: <a href="https://github.com/karenkessia" target="_blank">@karenkessia</a>
</p>


<p align="center">
  <br>
<img src="../Img/logo_compass02.png" alt="Logo Compass Uol" width="130">
</p>
