#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with opengrok](#setup)
    * [What opengrok affects](#what-opengrok-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with opengrok](#beginning-with-opengrok)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module installs and configures a basic [OpenGrok](https://opengrok.github.io/OpenGrok/) instance. Currently it is only tested with Puppet > 4.2 and CentOS 7.x but with a little work it should be easily extendable to other systems. (Pull requests welcome!)

## Module Description

The basic class ::opengrok will install and configure OpenGrok at `http://${::fqdn}:8080/source` it is reccomended to use a profile/role to put a reverse proxy infront of this.

You can add source repos to browse with OpenGrok by defining them with the `opengrok::projects` parameter hash or adding them with the `opengrok::project` defined type.

## Setup

### What opengrok affects

* A list of files, packages, services, or operations that the module will alter, impact, or execute on the system it's installed on.
* Created Files/Directories:
  * `/var/opengrok`
  * `/opt/opengrok`
* Default installed packages:
  * `ctags` (CentOS)
* Other modules included with default options:
  * `::git` [puppetlabs-git](https://forge.puppet.com/puppetlabs/git)
  * `::tomcat` [puppetlabs-tomcat](https://forge.puppet.com/puppetlabs/tomcat)

### Setup Requirements

You should have pluginsync enabled in your Puppet environment.

### Beginning with opengrok

All you need to do to get a running OpenGrok instance is

`include ::opengrok`

and to define at least one source either with the `::opengrok::projects` parameter hash or with the `opengrok::project` defined type

#### Parameter Hash Examples
##### Puppet DSL
```
opengrok::projects {
  puppet-opengrok => {
    source        => 'https://github.com/jordanconway/puppet-opengrok.git',
    ensure        => 'latest',
  },
  opengrok        => {
    source        => 'https://github.com/OpenGrok/OpenGrok.git',
    ensure        => 'latest',
  }
}
```
#### Hiera
#####
```
opengrok::projects:
  puppet-opengrok:
    source: 'https://github.com/jordanconway/puppet-opengrok.git'
    ensure: 'latest'
  opengrok:
    source: 'https://github.com/OpenGrok/OpenGrok.git'
    ensure: 'latest'
```

#### Defined type Examples

```
  opengrok::project{ 'puppet-opengrok':
    source => 'https://github.com/jordanconway/puppet-opengrok.git',
    ensure => 'latest',
  }
```

## Usage

Pretty straight forward and explained in the above section.

## Reference

This module is documented with puppet-strings you can build the documentation yourself with puppet-strings or see it on my [github pages](https://jordanconway.github.io/puppet-opengrok/)

## Limitations

Currently only tested and expected to work with Puppet > 4.2 and CentOS 7.x

## Development

Pull request welcome at https://github.com/jordanconway/puppet-opengrok/ (DCO commits are appreciated)
