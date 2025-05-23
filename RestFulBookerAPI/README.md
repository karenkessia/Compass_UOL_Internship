<table>
  <tr>
    <!-- Imagem à esquerda -->
    <td>
      <img src="../Img/robot_framework_frame.webp" alt="Imagem Esquerda" width="250"/>
    </td>
    <!-- Texto central -->
    <td align="center">
      <h2>RestFul Booker API - Testes com Robot Framework</h2>
      <p>
        <img src="https://img.shields.io/badge/status-em%20desenvolvimento-black" />
        <img src="https://img.shields.io/badge/testes-automatizados-black" />
        <img src="https://img.shields.io/badge/robot-framework-black" />
      </p>
    </td>
    <!-- Imagem à direita -->
    <td>
      <img src="../Img/robot2.webp" alt="Imagem Direita" width="250"/>
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
├── resources/
│   ├── Auth.robot           
│   ├── CreateBooking.robot 
│   ├── DeleteBooking.robot  
│   ├── GetBooking.robot     
│   ├── UpdateBooking.robot  
│   └── _base.robot          
├── tests/
│   ├── tests.robot 
│   └── results/
│       ├── log.html
│       ├── output.xml
│       └── report.html
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



