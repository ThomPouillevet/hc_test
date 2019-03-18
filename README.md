## Admin commands the Client could use in rails console :
### Required
* request.accept! - method that will allow accepting a request (request being an instance of the class Request)
* list the requests by their status using class methods or scopes:
> * Request.unconfirmed - requests for which the email address has not been confirmed
> * Request.confirmed - requests in the waiting list
> * Request.accepted - requests that have been accepted by the client
> * Request.expired - requests that have not been reconfirmed


### Added
* request.refuse! - method that will allow refusing a request and set its state to 'expired'. It can be called manually if needed. It is also automaticaly called when the request is in the waiting list and its owner has not confirm its interest in the specified time frame.
