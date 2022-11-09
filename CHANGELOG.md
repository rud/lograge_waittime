# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## Unreleased

- BREAKING: Rename this gem to "lograge-waittime". The old name was unwieldy and even had a typo to prove it.
- Removing explicit Rails 4.2.x testing

## 0.2.1 - 2018-07-01

- Loosening Rails version dependency, previously only allowed Rails 5.2+, now tested with Rails 4.2+

## 0.2.0 - 2018-06-29

### New features

- New gem, new project.
- Added `LogrageRailsRequestQueuing::SilenceExceptionLogging` to optionally quiet down exception logging.
- Added `LogrageRailsRequestQueuing::ExceptionDetails` to compactly report exception details in the log.
- Added support for Heroku request started timestamps that are given in ms not seconds.
