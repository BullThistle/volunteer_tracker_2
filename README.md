# _Volunteer Tracker_

#### By Rafael Furry

## Technologies Used

Application: Ruby, Sinatra
Testing: Rspec, Capybara
Database: Postgres

Installation
------------

```
$ git clone https://github.com/BullThistle/volunteer_tracker_2.git
```

Install required gems:
```
$ bundle install
```

Create databases:
```
$ createdb -T template0 volunteer_tracker
$ psql volunteer_tracker < my_database.sql
```

Start the webserver:
```
$ ruby app.rb
```

Navigate to `localhost:4567` in browser.

License
-------

GNU GPL v2. Copyright 2017 **Rafael Furry**
