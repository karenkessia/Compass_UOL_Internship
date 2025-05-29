*** Settings ***
Documentation     Keywords for retrieving bookings
Resource         _base.robot

*** Keywords ***
Get Booking By ID
    [Documentation]    Retrieves a booking by its ID
    [Arguments]    ${booking_id}
    ${response}=    GET On Session    
    ...    BookerAPI    
    ...    /booking/${booking_id}
    ...    expected_status=any
    
    Run Keyword If    ${response.status_code} == 404    
    ...    Fail    Booking with ID ${booking_id} not found
    
    Should Be Equal As Numbers    ${response.status_code}    200
    [Return]    ${response.json()}

Verify Booking Details
    [Documentation]    Verifies that the booking details are complete
    [Arguments]    ${booking}
    Dictionary Should Contain Keys    ${booking}    
    ...    firstname    
    ...    lastname    
    ...    totalprice    
    ...    depositpaid    
    ...    bookingdates
    
    Dictionary Should Contain Keys    ${booking}[bookingdates]    
    ...    checkin    
    ...    checkout