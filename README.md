# Booking API Example

## Overview

### Rails Setup
It's typical rails applcation and you need the follwoing steps to run it.

#### Basic Setup

```
bundle install
bundle exec rake db:create db:migrate
```

#### Run Tests (Rspec)

```
bundle exec rspec
```

#### Run API server

```
bundle exec rails s
```

## Current API end-points
To CREATE new reservation the following end-point should be used:

```
POST: /api/v1/reservation
```

To UPDATE existing reservation (for example set new status) the following end-point should be used:

```
PUT: /api/v1/reservation
```

All supported payloads can be found in [docs](docs) folder.

## Scalable
I've decied to use naming __Airbnb__ (for [payload exmaple 1](docs/payload_example_1.json)) and __Booking__ (for [payload example 2](docs/payload_example_2.json)).

Current solution based on two major models: __Guest__ and __Reservation__. __Reservation__ model uses STI (Single Table Inheritance) pattern to support mutliple bookings format and it has two classes __Reservations::Airbnb__ and __Reservations::Booking__.

__Reservation__ model also has some mapping methods `.reservations_fields_mapping` and `.guest_fields_mapping` to help mapping data from JSON payload to db columns, plus it has `original_json` column which stores original JSON payload request for future debug puproses.

Also all prices are stored in cents, just to avoid issues with float numbers, this this why concern module __Currency__ is used for. 

If we need to extend our solution to suport new reservation format, for example from [Hotels.com](https://hotels.com), we need to do the following things:
1. Create new child class __Reservations::Hotel__
1. Define mapping fields methods `.reservations_fields_mapping` and `.guest_fields_mapping` based on Holes.com payload.
1. Add new class to __ReservationsManager__.
1. Profit!

## Potential Future Improvements
1. Adding `AccessToken` checking for security matter.
1. Add ability have multiple currencies. Currently it supports only `AUD`.
1. Add validation to `status` column. Currently it supports any status.
1. Different JSON render to different Reservation types.
1. New end-point to show all existing bookings for __Guest__.
