# Virtual Mails

[![Build Status](https://api.travis-ci.org/emn178/virtual_mails.png)](https://travis-ci.org/emn178/virtual_mails)
[![Coverage Status](https://coveralls.io/repos/emn178/virtual_mails/badge.svg?branch=master)](https://coveralls.io/r/emn178/virtual_mails?branch=master)

A rails plugin that provides a virtual mail box and action mailer delivery method. You can send mail to this virtual mail box instead of real email service in development environment, and you can preview the emails in this virtual mail box in web page.

![image](https://cloud.githubusercontent.com/assets/3477613/13945269/e3e73f18-f046-11e5-9294-efcdba74b33c.png)  
![image](https://cloud.githubusercontent.com/assets/3477613/13945579/6addb7fc-f049-11e5-8af0-91b92cae542e.png)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'virtual_mails', group: :development
```
Make sure you have:
```ruby
gem 'jquery-rails'
```

And then execute:

    bundle

### Route
Add virtual mail box route in your `config/route.rb`
```Ruby
mount VirtualMails::Engine => "/virtual_mails" if Rails.env.development?
```

### Delivery Method
Set up delivery method of action mailer in your `config/environments/developmnet.rb`
```Ruby
config.action_mailer.delivery_method = :virtual
```

## Usage
Now, you can go to http://localhost:3000/virtual_mails and check the emails!

## Rails 5
You have to enable caching in development in Rails 5

  rails dev:cache

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Contact
The project's website is located at https://github.com/emn178/virtual_mails  
Author: Chen, Yi-Cyuan (emn178@gmail.com)
