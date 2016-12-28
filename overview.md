# Microservice AWS Application

## Application makeup

### MySQL

Database of order numbers
- OrderID,Name,Address,PostCode,ItemRefs

Database of items
- ItemID,Name,Description

### Storefront

* JS code which creates orders based on input form, pushes to SQS queue in JSON format

* Python service which watches SQS queue, and pulls orders, writing them to database, flags them for fulfilment

* Python service which takes orders awaiting fulfilment by polling database, fires off SNS notification via email, marks as fulfilled

* Python service which takes fulfilled order and generates an invoice, placing this in S3 bucket

## Requirements
* CloudFormation template to create databases in RDS
* CloudFormation template to create SQS queue
* CloudFormation template to create S3 bucket for invoices
* IAM roles for MySQL access, S3 access, SNS, SQS access
* JS and HTML for frontend storefront, to run in EC2 instance
* Python code for service to watch SQS and write orders to databases, to run in EC2 instance initially, probably Lambda (and/or ECS) later
* Python code for service to take orders and "fulfil" them, to run in EC2 instance initially, probably Lambda (and/or ECS) later
* Python service to generate invoice and place in S3 bucket, to run in EC2 instance initially, probably Lambda (and/or ECS) later

## Notes

* MySQL node.js driver available from https://github.com/mysqljs/mysql, this link includes example code:

```
var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'me',
  password : 'secret',
  database : 'my_db'
});

connection.connect();

connection.query('SELECT 1 + 1 AS solution', function(err, rows, fields) {
  if (err) throw err;

  console.log('The solution is: ', rows[0].solution);
});

connection.end();
```
This should be useful in interfacing between node.js front end server side code, and MySQL back end
