*** Settings ***
Documentation    Signing up an user
Resource    ../resources/base.resource
Resource    ../resources/pages/SignupPage.resource
Library    Process
Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Signup a valid user

    ${user}    Create Dictionary    
    ...    name=QaTester   
    ...    email=QaTester@gmail.com    
    ...    password=123456

    Remove user from database    ${user}[email]

    Go To    ${BASE_URL}/signup

    # Checkpoint
    Wait For Elements State    css=h1    visible    5
    Get Text    css=h1    equal    Faça seu cadastro
    
    Fill Text    css=input[name=name]     ${user}[name]
    Fill Text    css=input[name=email]     ${user}[email]
    Fill Text    css=input[name=password]    ${user}[password]

    Click    css=button[type=submit] >> text=Cadastrar

    Wait For Elements State    css=.notice p    visible
    Get Text    css=.notice p    equal    Boas vindas ao Mark85, o seu gerenciador de tarefas.

    Sleep    4

Not allowing duplicated email
    [Tags]    dup

    ${user}    Create Dictionary    
    ...    name=QaTester    
    ...    email=QaTester@gmail.com    
    ...    password=123456

    Remove user from database     ${user}[email]
    Insert user into database     ${user}

    Go to signup Page
    Submit signup from    ${user}
    Notice should be    Oops! Já existe uma conta com o e-mail informado.

Not allowed with invalid email
    ${user}    Create Dictionary    
    ...    name=QaTester    
    ...    email=invalidemail.com    
    ...    password=123456

    Go to signup Page
    Submit signup from    ${user}
    Alert should be    Digite um e-mail válido

Not allowed with short password
    [Tags]    Temp
    @{password_list}    Create List    1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}
        ${user}    Create Dictionary    
    ...    name=QaTester    
    ...    email=invalidemail.com    
    ...    password=${password}
    
    Go to signup Page
    Submit signup from    ${user}
    Alert should be    Informe uma senha com pelo menos 6 digitos
        
    END

Mandatory fiels
    [Tags]    required
    ${user}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=${EMPTY}
    
    Go to signup Page
    Submit signup from    ${user}

    Alert should be    Informe seu nome completo
    Alert should be    Informe seu e-email
    Alert should be    Informe uma senha com pelo menos 6 digitos

*** Keywords *** 
Short password
    [Arguments]    ${short_pass}
    ${user}    Create Dictionary
    ...    name=InvalidPassowrd
    ...    email=InvalidPassowrd@gmail.com
    ...    password=${short_pass}
    
    Go to signup Page
    Submit signup from    ${user}

    Alert should be    Informe uma senha com pelo menos 6 digitos