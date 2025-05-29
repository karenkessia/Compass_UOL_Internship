*** Settings ***
Resource    ../resources/UpdateBooking.robot
Resource    test_base.robot

*** Test Cases ***
Update Existing Booking
    [Documentation]    Test updating an existing booking with valid data
    Update Booking    ${booking_id}    ${valid_booking_data}
    Validate Response Status Code    ${VALID_STATUS_CODE}
    Validate Updated Booking Data    ${valid_booking_data}

Update Booking Without Authentication
    [Documentation]    Test updating a booking without authentication token
    Update Booking Without Token    ${booking_id}    ${valid_booking_data}
    Validate Response Status Code    403

Partial Update Booking
    [Documentation]    Test partial update of a booking
    Partial Update Booking    ${booking_id}    ${partial_update_data}
    Validate Response Status Code    ${VALID_STATUS_CODE}
    Validate Partial Update    ${partial_update_data}

*** Keywords ***
Validate Updated Booking Data
    [Arguments]    ${expected_data}
    ${response_body}=    Set Variable    ${response.json()}
    Dictionaries Should Be Equal    ${response_body}    ${expected_data}

Validate Partial Update
    [Arguments]    ${expected_partial_data}
    ${response_body}=    Set Variable    ${response.json()}
    FOR    ${key}    IN    @{expected_partial_data.keys()}
        Should Be Equal    ${response_body}[${key}]    ${expected_partial_data}[${key}]
    END