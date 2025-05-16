# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## Unreleased

* Testing: Added Rails 8.0 on Ruby 3.4 to test matrix
* Removing support for Ruby versions prior to 3.1.7, and Rails versions prior to 8.0

## 0.4.2 - 2024-11-10

* Testing: Added Rails 7.0 on Ruby 3.2 to test matrix
* Testing: Added Rails 7.1 and 8.0 on Ruby 3.3 to test matrix

## 0.4.1 - 2023-02-09

* Testing: Added Rails 7.0 on Ruby 3.1 to test matrix

## 0.4.0 - 2022-11-18

* Zeitwerk did not work seamlessly with the previous gem name, switching to `lograge_waittime`.
* Code simplified further.

## 0.3.1 - 2022-11-18

- Actually bumping version.rb to match

## 0.3.0 - 2022-11-18

- BREAKING: Rename this gem to "lograge-waittime". The old name was unwieldy and even had a typo to prove it.
- BREAKING: Removed exception silencing to focus the code more narrowly.
- Removing explicit testing of Rails before 5.2. 
- Added CI testing of Rails version up to and including Rails 6.1.x with Ruby 3.0.x

## 0.2.1 - 2018-07-01

- Loosening Rails version dependency, previously only allowed Rails 5.2+, now tested with Rails 4.2+

## 0.2.0 - 2018-06-29

### New features

- New gem, new project.
- Added `LogrageRailsRequestQueuing::SilenceExceptionLogging` to optionally quiet down exception logging.
- Added `LogrageRailsRequestQueuing::ExceptionDetails` to compactly report exception details in the log.
- Added support for Heroku request started timestamps that are given in ms not seconds.
