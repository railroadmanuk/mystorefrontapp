# Connect to MySQL and check tables
```
:~$     mysql -h 127.0.0.1 -uroot -pVMware1!
mysql>  select sfapp;
mysql>  show tables;
mysql>  CREATE TABLE orders (
    OrderID INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    PostCode VARCHAR(20) NOT NULL,
    ItemRefs VARCHAR(2000) NOT NULL
  );
mysql>  desc orders;
mysql>  CREATE TABLE items (
    ItemID INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Description VARCHAR(200) NOT NULL
  );
mysql>  desc items;
```
