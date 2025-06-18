*** Settings ***
# ╭────────────────────────────────────────────────────────────╮
# │                    Configurações Globais                   │
# ╰────────────────────────────────────────────────────────────╯
Documentation       Variáveis globais utilizadas nos testes da API ServeRest


*** Variables ***
# ╭────────────────────────────────────────────────────────────╮
# │                        API Endpoints                       │
# ╰────────────────────────────────────────────────────────────╯
${BASE_URL}             https://compassuol.serverest.dev/
${AUTH_ENDPOINT}        /login
${USERS_ENDPOINT}       /usuarios
${PRODUCTS_ENDPOINT}    /produtos
${CARTS_ENDPOINT}       /carrinhos


# ╭────────────────────────────────────────────────────────────╮
# │                         Credenciais                        │
# ╰────────────────────────────────────────────────────────────╯
${NOME_VALIDO}          Karen
${EMAIL_VALIDO}         karenherrcompass@compasso.com
${SENHA_VALIDA}         senha03
${EMAIL_INVALIDO}       karenherrcompass3@gmail.com
${SENHA_INVALIDA}       XXXXXXXXX


# ╭────────────────────────────────────────────────────────────╮
# │               Headers e Autenticação JWT                   │
# ╰────────────────────────────────────────────────────────────╯
&{HEADERS}              Content-Type=application/json    Accept=application/json
${TOKEN}                None


# ╭────────────────────────────────────────────────────────────╮
# │                       Tags para Testes                     │
# ╰────────────────────────────────────────────────────────────╯
# HTTP Methods:    get, post, put, delete, patch
# Features:        usuarios, login, produtos, carrinhos
# Test Types:      positive, negative, validation, smoke, regression
