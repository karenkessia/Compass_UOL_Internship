*** Variables ***
# ╭────────────────────────────╮
# │      URL da API            │
# ╰────────────────────────────╯
${base_url}                    https://compassuol.serverest.dev

# ╭────────────────────────────╮
# │  Usuário Válido (Padrão)   │
# ╰────────────────────────────╯
${nome_do_usuario}             Usuário Válido
${email_do_usuario}            usuariovalido@testes.com
${senha_do_usuario}            user1

# ╭────────────────────────────╮
# │   Usuário Administrador    │
# ╰────────────────────────────╯
${nome_admin}                  Admin1
${email_admin}                 admin1@testes.com
${senha_admin}                 euadm

# ╭────────────────────────────╮
# │      Usuário Comum         │
# ╰────────────────────────────╯
${nome_nao_admin}              User not admin
${email_nao_admin}             user.notadmin@testes.com
${senha_nao_admin}             user2

# ╭────────────────────────────╮
# │      E-mails Inválidos     │
# ╰────────────────────────────╯
${email_gmail}                 teste1@gmail.com
${email_hotmail}               teste2@hotmail.com
${email_malformado}            email-not-arroba.com
${email_inexistente}           inexistente@testee.com

# ╭────────────────────────────────────────╮
# │ Testes de Limite de Tamanho            │
# ╰────────────────────────────────────────╯
${senha_limite_min}            12345
${senha_limite_max}            1234567890

# ╭────────────────────────────╮
# │     Produto Válido         │
# ╰────────────────────────────╯
${nome_produto}                Nome Produto X
${preco_produto}               168
${descricao_produto}           Produto X para testes
${quantidade_produto}          14

# ╭────────────────────────────────╮
# │ Produto com Nome Duplicado     │
# ╰────────────────────────────────╯
${nome_produto_duplicado}      Produto Test Duplicado

# ╭────────────────────────────╮
# │   Variáveis de Controle    │
# ╰────────────────────────────╯
${USUARIO_ID}                  ${EMPTY}
${PRODUTO_ID}                  ${EMPTY}
${TOKEN_ADMIN}                 ${EMPTY}
${TOKEN_REGULAR}               ${EMPTY}
${ID_INEXISTENTE}              1234567899906444
