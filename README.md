##Job Application Tracker 

It is a 'Job application Tracking System' which allows user to create/maintain a log of job applications to keep track of his job search. It gives ability to upload the documents like resumes, cover letters etc..User can use those uploaded documents to create/edit the job application log. It sends remainder mails about the positions which close in another 3 days to know of its status every night. 

It is live [here](https://job-application-tracker.herokuapp.com/).

Features of the app:

* Authentication mechanism

* User can choose different payment plans based on his requirement

* Documents uploading

* View the documents inline to web page

* Logging of job applications

* View documents used on every job application inline to the page

* Gets e-mail every night about the positions which close in other 3 days

Implementation details of the app:

* Used Devise for authentication system

* Customized Devise for adding attributes for user model

* Bootstrap for styling the app and to be mobile friendly

* Followed TDD methodologies

* Used rspec, capybara, factory girl, faker, shoulda-matchers, guard

* Configured SMTP Transcational Email(Gmail) 

* Used Stripe API to accept payments details from users 

* Used custom credit card form along with devise sign up form

* Customized devise registration controller for processing the payment while user is signing up

* Used 'carrierwave-dropbox' gem to store the user documents like resumes, cover letter etc..

* Used iframe tag to embed the documents from dropbox folder into webpages

* Created a rake task to fire off the remainder email to users

* Scheduled cron job to send remainder mail every night about the positions which close in other 3 days using 'whenever' gem

Issues encountered while building:

* When using 'paperclip-googledrive' gem for file storage, got error upon the deletion of the document which is in the google drive as paperclip and Google APIClient(Rails app) sends delete request separately. Hence used carrierwave-dropbox gem for documents storage which complies with all RESTFUL action on the documents in the dropbox. 

Extra Notes:

* Auto mailing feature of the app using 'whenever' gem works only in development as heroku does not support linux cron job. Heroku needs to use new add-on called 'Scheduler' to run the background job at scheduled time intervals which requires activated heroku account and hence this feature is not available in the production version of the app.