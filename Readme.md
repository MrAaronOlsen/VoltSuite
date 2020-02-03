# Volt Suite
### A simple 2d physics engine built to see how such a thing works.
***__This project is no longer being updated. As one might expect Ruby makes a terrible language to write a physics engine with. Lesson learned I guess. Regardless, a fun project with some valuable experience. RIP VoltSuite__***

# Getting up and running
### Prerequisites

##### You must have Ruby 2.6.5 installed.

I personally use RVM. [Install RVM](https://rvm.io/rvm/install).<br>
Then install Ruby `$ rvm install 2.5.6`.

Rbenv is a fine option too. [Install Rbenv](https://github.com/rbenv/rbenv).<br>
Then install Ruby `$ rbenv install 2.5.6`.

##### You must have Bundler installed.
Install with `$ gem install bundler`

### Install Volt
```Bash
# Clone Repo
$ git clone https://github.com/MrAaronOlsen/VoltSuite

# Step into directory and run bundle
$ cd VoltSuite
$ bundle install
```
That should do it.<br>
To run the Contact Test Arena: `$ ruby examples/contact_tests/run.rb`<br>
To run the GJK Visualizer: `$ ruby examples/contact_visualizer/run.rb`
