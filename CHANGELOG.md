# Changelog

All notable changes to this project will be documented in this file.

## [1.4.0](https://github.com/edelwud/terrafrom-aws-alb/compare/v1.3.0...v1.4.0) (2022-02-18)


### Features

* `complete-alb` security groups and `fixed_response` creation ([18a3243](https://github.com/edelwud/terrafrom-aws-alb/commit/18a32433cdf817f91d2f9d4a1cc57e6c0bc1da1c))
* added `http_header`, `http_request_method`, `query_string`, `source_ip` conditions ([e6e454f](https://github.com/edelwud/terrafrom-aws-alb/commit/e6e454fc79c09e93ae17288837fff1d6b8538b84))


### Bug Fixes

* example `complete-alb` vpc azs ([f240a02](https://github.com/edelwud/terrafrom-aws-alb/commit/f240a02671a8f6b24457cde7797d759ec4d08e92))
* listener and listener rule `fixed_response` action ([5b06d8e](https://github.com/edelwud/terrafrom-aws-alb/commit/5b06d8e720ec21019106d68dd1117ff1c59d29c1))

## [1.3.0](https://github.com/edelwud/terrafrom-aws-alb/compare/v1.2.0...v1.3.0) (2022-02-18)


### Features

* add default values for variables ([2e4d20c](https://github.com/edelwud/terrafrom-aws-alb/commit/2e4d20c4750fe23e5bab11dd785073d2aef17956))
* replace `project_name`, `environment`, `application` with `name` ([67f5d0c](https://github.com/edelwud/terrafrom-aws-alb/commit/67f5d0c47b02a1977508abac45db5deb79d7cdda))


### Bug Fixes

* alb resources tags ([ab9aa0e](https://github.com/edelwud/terrafrom-aws-alb/commit/ab9aa0e8977c127beb0c587397cbc14a27521e2d))

## [1.2.0](https://github.com/edelwud/terrafrom-aws-alb/compare/v1.1.0...v1.2.0) (2022-02-18)


### Features

* initial complete alb ([7ec2d46](https://github.com/edelwud/terrafrom-aws-alb/commit/7ec2d46f239b9fd534580d5a8fa53ff9e8f05e99))

## [1.1.0](https://github.com/edelwud/terrafrom-aws-alb/compare/v1.0.0...v1.1.0) (2022-02-18)


### Features

* alb implementation ([7582cfd](https://github.com/edelwud/terrafrom-aws-alb/commit/7582cfd452cfca9a850a666deb8458ac12ed509e))
* input & output variables ([0de6a94](https://github.com/edelwud/terrafrom-aws-alb/commit/0de6a9400b5c72573cc6eb24cf2f236634fcad1a))
* parse listeners with locals ([147862e](https://github.com/edelwud/terrafrom-aws-alb/commit/147862ed371d9dc21cbf9c29dacf1e599162bdd1))

## 1.0.0 (2022-02-18)


### Features

* initial commit ([454ca1b](https://github.com/edelwud/terrafrom-aws-alb/commit/454ca1b702fb81cc4f31d3581415a1d61f144f73))


### Bug Fixes

* workflows folder name ([8944c23](https://github.com/edelwud/terrafrom-aws-alb/commit/8944c23738e94d0b085fb7151193fd76282e85f6))
