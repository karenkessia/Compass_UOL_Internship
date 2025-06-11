*** Settings ***
Documentation            Cenários de testes de remoção de tarefas

Resource        ../../resources/base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Shall exclude not wanted task
    ${data}    Get fixtures    Tasks    delete
    Remove user from database   ${data}[user]

    POST user session  ${data}[user]
    POST a new task    ${data}[task]

    Submit login form    ${data}[user]
    User should be logged in    ${data}[user][name]

    Request removal    ${data}[task][name]
    Task should not exist    ${data}[task][name]