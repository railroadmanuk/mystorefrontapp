# Connect to MySQL and check tables

## Create Tables
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

## Add Records
```
mysql>  INSERT INTO items (Name, Description)
    VALUES ('Nice Spade','This is a damn good spade');
mysql>  INSERT INTO items (Name, Description)
    VALUES ('Crappy Spade','This is an awful spade');
```

## Delete Records
```
mysql>  DELETE FROM items WHERE Name='Crappy Spade';
```

## Update Records
```
mysql>  UPDATE items SET Description='This is a damn awful spade' WHERE Name='Crappy Spade';
```

## Select Records
```
mysql>  SELECT * FROM items;
mysql>  SELECT * FROM items WHERE Name='Crappy Spade';
mysql>  SELECT ItemID,Name FROM items WHERE Name='Crappy Spade';
```

## Enable remote bind
Edit `/etc/mysql/mysql.conf.d/mysqld.cnf`, replacing: `bind-address            = 127.0.0.1` with `bind-address            = 192.168.1.236`, and then restarting mysql service with `service mysql restart`.

Then we need to add our web host (or subnet) into the allowed list in MySQL:
```
mysql>  GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.1.235' IDENTIFIED BY 'VMware1!' WITH GRANT OPTION;
```
We can now connect from our remote host using:
```
:~$     mysql -h 192.168.1.236 -uroot -pVMware1!
```
NOTE: We could revoke this access with:
```
mysql>  REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'root'@'192.168.1.235';
```
We can check the outcome of each of these with:
```
mysql>  SELECT * from information_schema.user_privileges;
```
We could create a new user for the remote server with:
```
mysql>  GRANT ALL PRIVILEGES ON *.* TO 'dbuser'@'192.168.1.235' IDENTIFIED BY 'VMware1!' WITH GRANT OPTION;
```

## Remote commands via bash
We should be able to now run remote commands against the DB, like:
```
:~$ mysql -h192.168.1.236 -uroot -pVMware1! -e 'USE sfapp; SELECT * FROM items;'
```
And get output like this:
```
mysql: [Warning] Using a password on the command line interface can be insecure.
+--------+--------------+---------------------------+
| ItemID | Name         | Description               |
+--------+--------------+---------------------------+
|      1 | Nice Spade   | This is a damn good spade |
|      3 | Crappy Spade | This is an awful spade    |
+--------+--------------+---------------------------+
```

## Create a non-root user
We can create another account if we wanted to by doing this when connected to the instance:
```
mysql>  CREATE USER 'testuser' IDENTIFIED BY 'somepass';
```
And kill it with:
```
mysql>  DROP USER 'testuser';
```
We can make a user which is specific to a host with:
```
mysql>  CREATE USER 'testuser'@'192.168.1.236' IDENTIFIED BY 'somepass';
```
Or we can do this when setting up the remote access privilege as above.
