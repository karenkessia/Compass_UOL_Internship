<h2> RestFul Booker API - Testes com Robot Framework</h2>

<p>Este projeto tem como objetivo automatizar testes da <a href="https://restful-booker.herokuapp.com/apidoc/index.html" target="_blank">Restful Booker API</a> utilizando <strong>Robot Framework</strong>, focando em autenticação, criação, consulta, atualização e remoção de reservas (bookings).</p>

<blockquote>
  <strong>ℹ️ Sobre a API:</strong><br>
  A <strong>Restful Booker</strong> é uma API para fins educacionais que permite testar operações <strong>CRUD</strong> com autenticação.<br>

</blockquote>

---

<h3> Estrutura do Projeto</h3>

 <pre style="background: #eee; padding: 10px; border-left: 5px solid #3e64ff;">
 RestFulBookerAPI/ 🗂
├── resources/
│ ├── Auth.robot           
│ ├── CreateBooking.robot 
│ ├── DeleteBooking.robot  
│ ├── GetBooking.robot     
│ ├── UpdateBooking.robot  
│ └── _base.robot          
└── tests/ 🗂
└── tests.robot 
│
└── requirements.txt      
└── README.md              
  </pre>


---



