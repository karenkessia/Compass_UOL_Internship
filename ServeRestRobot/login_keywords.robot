# ╭────────────────────────────────────────╮
# │ Configurações e Recursos Utilizados    │
# ╰────────────────────────────────────────╯

*** Settings ***
Library         RequestsLibrary
Resource        ../variables/serverest_vars.robot


# ╭────────────────────────────────────────╮
# │ Keyword: Realizar Login                │
# ╰────────────────────────────────────────╯

*** Keywords ***
Realizar Login
    [Arguments]    ${email}    ${senha}
    
    ${body}=       Create Dictionary
    ...            email=${email}
    ...            password=${senha}
    
    ${response}=   POST On Session
    ...            alias=api-session
    ...            url=${AUTH_ENDPOINT}
    ...            json=${body}
    ...            expected_status=any
    
    RETURN         ${response}
