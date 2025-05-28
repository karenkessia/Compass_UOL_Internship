*** Settings ***
Documentation     Main test suite for RestFul Booker API
Resource          ../resources/Auth.robot
Resource          ../resources/CreateBooking.robot
Resource          ../resources/GetBooking.robot
Resource          ../resources/UpdateBooking.robot
Resource          ../resources/DeleteBooking.robot
Suite Setup       Create Session With Base URL
Test Teardown     Delete Session    BookerAPI

*** Test Cases ***
Authentication Should Succeed
    [Documentation]    Verifies that authentication works correctly
    [Tags]    auth    smoke
    Verify Authentication Success

Create And Verify New Booking
    [Documentation]    Creates a new booking and verifies its creation
    [Tags]    booking    smoke
    ${booking_response}=    Create New Booking    
    ...    John    
    ...    Doe    
    ...    100    
    ...    ${TRUE}    
    ...    2024-01-01    
    ...    2024-01-05    
    ...    Breakfast
    Verify Booking Creation    ${booking_response}
    Set Suite Variable    ${BOOKING_ID}    ${booking_response}[bookingid]

Get And Verify Existing Booking
    [Documentation]    Retrieves and verifies an existing booking
    [Tags]    booking
    ${booking}=    Get Booking By ID    ${BOOKING_ID}
    Verify Booking Details    ${booking}

Update And Verify Booking
    [Documentation]    Updates an existing booking and verifies changes
    [Tags]    booking
    ${original_booking}=    Get Booking By ID    ${BOOKING_ID}
    ${updated_booking}=    Update Booking    
    ...    ${BOOKING_ID}    
    ...    Jane    
    ...    Smith    
    ...    150    
    ...    ${TRUE}    
    ...    2024-02-01    
    ...    2024-02-05    
    ...    Dinner
    Verify Booking Update    ${original_booking}    ${updated_booking}

Delete And Verify Booking
    [Documentation]    Deletes a booking and verifies deletion
    [Tags]    booking
    Delete Booking    ${BOOKING_ID}
    Verify Booking Deletion    ${BOOKING_ID}