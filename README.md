# Ekto

Ekto is a provisioning system focused on creating testable cloud
deployment strategies.

## Getting Started

Well, still getting started myself here.

### Dependencies

Vagrant 1.1 or higher (not the rubygems version)
Sahara - used for snapshot/rollback of virtual instances, sahara must be
bundle installed, built as a gem and then added to vagrant:
- go to your installed sahara gem location
    gem build sahara.gemspec # => sahara-0.1.xx.gem
    vagrant plugin add sahara-0.1.xx.gem

### LICENSE

Ekto is distributed under the Apache 2.0 license


### Contributing

Pull requests welcome
