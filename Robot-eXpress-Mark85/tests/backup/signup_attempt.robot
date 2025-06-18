# *** Settings ***
# Documentation    scenery with signup attemption with short passwords

# Resource    .../resources/base.resource

# Test Template    Short password
# Test Setup    Start Session
# Test Teardown    Take Screenshot

# *** Test Cases ***
# Not allowed password with 1 characters    1
# Not allowed password with 2 characters    12
# Not allowed password with 3 characters    123
# Not allowed password with 4 characters    1234
# Not allowed password with 5 characters    12345

# *** Keywords *** 
# Short password
#     [Arguments]    ${short_pass}
#     ${user}    Create Dictionary
#     ...    name=InvalidPassowrd
#     ...    email=InvalidPassowrd@gmail.com
#     ...    password=${short_pass}
    
#     Go to signup Page
#     Submit signup from    ${user}

#     Alert should be    Informe uma senha com pelo menos 6 digitos