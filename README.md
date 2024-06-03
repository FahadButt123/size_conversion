# README

Ruby Version: 3.1.2

Rails Version: 7.1.2

Project Setup:

* bundle install

* rails db:create

* rails assets:precompile

* rails s

Run Test Cases

* bundle exec rspec

NOTE: Our CSV file is not too big that's why we are reading the CSV file directly without storing this in database. If the file would be big then we will first store data then compare it for size 
conversion.

We would have used dropdowns for countries. But we did error handling instead of using dropdowns for all the scenarios. Input wrong country and size will show proper erros.
