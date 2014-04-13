# CMS 2012 Data Explorer
This project makes the CMS 2012 payment dataset more accessible by exposing a web-based front-end to specific queries.


## Requirements
You must download the original dataset separately. It is available from http://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Physician-and-Other-Supplier.html. It is not included here because it contains CPT data copyrighted by the American Medical Association.

You'll need to have Ruby 2.0.0-p451 and Rails 4.0.0.

You will also need access to a PostgresQL database instance. If you have MySQL or another RDBMS, you should be able to make minor modifications in `config/database.yml` to use your RDBMS.
##Setup
* Download the payment data file from the link mentioned above and save it locally.
* Set your CMS_DB_URL environment variable to contain your database conneciton information
* Open a terminal window, change to the project directory
* Execute `rake db:setup` to create and populate the database
* Execute `rake import:cms_data[path/to/your/cms/file]` to import the CMS data. This make take up to a few hours.
* Execute `rails s` to start the server
