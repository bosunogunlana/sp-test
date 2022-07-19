# Smart Pension Technical Test

# Installation

- Clone Repository: `$ git clone https://github.com/bosunogunlana/sp-test.git`
- Install Rbenv: [Rbenv](https://github.com/rbenv/rbenv)
- Install Ruby 3.1.2 using Rbenv
  - `$ rbenv install 3.1.2`
  - `$ rbenv local 3.1.2`
- Install app dependency: `$ bundle install`
- Run Test: `$ bundle exec rspec`

# Usage

Run the script with the command below
```bash
$ ruby ./lib/parser.rb ./logs/webserver.log
```

Script Output

```
/about/2 90 visits
/contact 89 visits
/index 82 visits
/about 81 visits
/help_page/1 80 visits
/home 78 visits
------------------------------
/help_page/1 23 unique views
/contact 23 unique views
/home 23 unique views
/index 23 unique views
/about/2 22 unique views
/about 21 unique views
```
