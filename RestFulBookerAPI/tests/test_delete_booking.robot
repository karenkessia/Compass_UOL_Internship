*** Settings ***
Resource    ../resources/DeleteBooking.robot
Resource    test_base.robot

*** Test Cases ***
Delete Existing Booking
    [Documentation]    Test deleting an existing booking
    Delete Booking    ${booking_id}
    Validate Response Status Code    201
    Verify Booking No Longer Exists    ${booking_id}

Delete Non-Existent Booking
    [Documentation]    Test deleting a booking that doesn't exist
    Delete Booking    999999
    Validate Response Status Code    404

Delete Booking Without Authentication
    [Documentation]    Test deleting a booking without authentication token
    Delete Booking Without Token    ${booking_id}
    Validate Response Status Code    403

*** Keywords ***
Verify Booking No Longer Exists
    [Arguments]    ${booking_id}
    Get Booking    ${booking_id}
    Validate Response Status Code    404