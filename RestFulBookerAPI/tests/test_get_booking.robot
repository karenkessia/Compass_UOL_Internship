*** Settings ***
Resource    ../resources/GetBooking.robot
Resource    test_base.robot

*** Test Cases ***
Get Existing Booking
    [Documentation]    Test retrieving an existing booking
    Get Booking    ${booking_id}
    Validate Response Status Code    ${VALID_STATUS_CODE}
    Validate Booking Details

Get Non-Existent Booking
    [Documentation]    Test retrieving a non-existent booking
    Get Booking    999999
    Validate Response Status Code    404

Get All Bookings
    [Documentation]    Test retrieving all bookings
    Get All Bookings
    Validate Response Status Code    ${VALID_STATUS_CODE}
    Validate Bookings List

*** Variables ***
${response}    

*** Keywords ***
Validate Booking Details
    Dictionary Should Contain Key    ${response.json()}    firstname
    Dictionary Should Contain Key    ${response.json()}    lastname
    Dictionary Should Contain Key    ${response.json()}    totalprice

Get All Bookings
    

Validate Bookings List
    ${response_body}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${response_body}

        Get All Bookings
    

