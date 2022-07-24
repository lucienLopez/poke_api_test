# Used stack

+ [Ruby](http://ruby-lang.org), => `2.7.0`
+ [Rails](http://rubyonrails.org), => `6.1.6`
+ [PostgreSQL](http://www.postgresql.org), => `12.11`

# Usage

* Installation:
  - Install gems: `bundle install`
  - Import pokemons data (see below)
* Import/update pokemons data: `bundle exec rake pokemons:import`
* Start server: `bundle exec rails s`
* Using this API: See `http://localhost:3000/api-docs` after starting the server

# Work remaining

- Retrieve more data, like types damage relations
- Finish specs
