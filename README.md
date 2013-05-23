Canmöia
=======

<!---

TODO Add badges of this services

[![Travis](https://api.travis-ci.org/indefinido/canmoia.png)](http://travis-ci.org/indefinido/canmoia)
[![Coverage Status](https://coveralls.io/repos/indefinido/canmoia/badge.png?branch=master)](https://coveralls.io/r/indefinido/canmoia)
[![Code Climate](https://codeclimate.com/github/indefinido/canmoia.png)](https://codeclimate.com/github/indefinido/canmoia)
![project status](http://stillmaintained.com/indefinido/canmoia.png)

-->

Summary
-------

Canmöia (can = order, möia = work, work order). The core functionality of the  [Order domain](http://en.wikipedia.org/wiki/Work_order)

Requirements
------------

  ruby 2.0.0
  workflow
  currently only support mongoid models

Getting Started
---------------

Add to your Gemfile:

```ruby
gem 'canmoia'
```

You must have a **model named User** and a **model named Item** for this to
work properly. Then add the concern you want to your model:

```ruby
class Order
  include Mongoid::Document
  include Canmoia::Order
end
```


You now have a fully working Order:

```ruby
order = Order.new
order.items << Item.new(value: 100)
order.items << Item.new(value: 150)

# Automatically computes total upon validation
order.valid?
order.total      # 250.00

# Manage basic order states (workflow gem basics)
# To override behaviour just define close! method on model
order.close!
order.closed?    # true

order.accept!
order.accepted?  # true
order.state      # accepted


# Automagically generated associations
order.client    # your User model
order.items      # your Item model
```

You might also try the Work Order concern:

```ruby
class Order
  include Mongoid::Document
  # Canmoia::Order is automatically included
  include Canmoia::Work
end

# Automagically generated associations
order.responsible

# Autmatically notifications!
# When closing a order:
order.close!

# Canmoia will automatically try to notify
# the domain resposables for the event
# Trigerring this methods:
# OrderMailer.close_notification_to_responsible(order, order.responsible).deliver
# OrderMailer.close_notification_to_client(order, order.client).deliver
#
# Generalizing:
# #{YourModel}Mailer.#{event}_notification_to_#{recipient}

```

Documentation
-------------

Sometime on the future might be a wiki page

### Concerns
#### Order (Canmoia::Order)

The current states and transitions are:
<sup>Order will always start at opened state (italics)</sup>

| state       | event    | transitions to |
|:-----------:|:--------:|:--------------:|
| *opened*    | close    | reviewing      |
| *opened*    | cancel   | canceled       |
| reviewing   | accept   | accepted       |
| reviewing   | reject   | rejected       |
| reviewing   | cancel   | canceled       |
| accepted    | complete | completed      |
| accepted    | cancel   | canceled       |
| rejected    | complete | completed      |
| rejected    | cancel   | canceled       |
| completed   | -        | -              |
| canceled    | -        | -              |


#### Work Order (Canmoia::Work)


You can specify to which events canmöia should send notifications:

```ruby
class Order
  include Mongoid::Document
  # Canmoia::Order is automatically included
  include Canmoia::Work

  # BTW this are the defaults!
  notify :responsible, :on => [:open, :close]
  notify :client     , :on => [:open, :accept, :reject, :cancel]
end
```
### Features


#### Notification (Canmoia::Notification)
 Include workflow and rock with only notification functionalities!

```ruby
class Order
  include Mongoid::Document
  include Workflow
  include Canmoia::Notification

  workflow do

    state :opened do
        event :close, :transitions_to => :checkout
    end

    state :checkout

  end

  #  Remember, will trigger: OrderMailer.close_notification_to_responsible(order, order.responsible).deliver
  notify :responsible, :on => :close
end
```


TODO
----

### Mail Generator
Automatically add default mail templates for notification kinds to the view_path

### Purchase Order
Add suport for Purchase Order Concern    (Canmoia::Purchasable)

### Reviewable Feature
Extract review order feature from Order concern (Canmoia::Reviewable)





This project rocks and uses WTFPL-LICENSE.
