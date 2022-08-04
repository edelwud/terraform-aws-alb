# Changelog

All notable changes to this project will be documented in this file.

### [1.8.1](https://github.com/edelwud/terraform-aws-alb/compare/v1.8.0...v1.8.1) (2022-08-04)


### Bug Fixes

* output namings ([b6f9177](https://github.com/edelwud/terraform-aws-alb/commit/b6f91773d7716a5248be93e13183f0d3dd5605ed))
* README.md input variables ([750a295](https://github.com/edelwud/terraform-aws-alb/commit/750a295a6109113f149a7862bd637dce12f1152a))
* terraform module path ([ccf1db4](https://github.com/edelwud/terraform-aws-alb/commit/ccf1db4f77e434068b2ba02c04f148e1c9df01bb))

## [1.8.0](https://github.com/edelwud/terraform-aws-alb/compare/v1.7.2...v1.8.0) (2022-02-21)


### Features

* add access logs implementation ([e03a26b](https://github.com/edelwud/terraform-aws-alb/commit/e03a26be5723f6793652f07742775701a11de63a))
* add access logs variable ([6637507](https://github.com/edelwud/terraform-aws-alb/commit/663750769ec477090dfdd3d0cda7cfbe976c8505))
* add terraform-aws-alb module documentation ([40b349c](https://github.com/edelwud/terraform-aws-alb/commit/40b349c834adab78e8ba2d5accadd0757de5213a))

### [1.7.2](https://github.com/edelwud/terrafrom-aws-alb/compare/v1.7.1...v1.7.2) (2022-02-21)


### Bug Fixes

* outputs variables mapping ([1922296](https://github.com/edelwud/terrafrom-aws-alb/commit/1922296de6ef2be65821ae9528a70d9c48deb5c2))

### [1.7.1](https://github.com/edelwud/terrafrom-aws-alb/compare/v1.7.0...v1.7.1) (2022-02-21)


### Bug Fixes

* `subnet_mapping` variable null check ([a484602](https://github.com/edelwud/terrafrom-aws-alb/commit/a484602caf4debec941fe7c653390269a105b86f))

## [1.7.0](https://github.com/edelwud/terrafrom-aws-alb/compare/v1.6.0...v1.7.0) (2022-02-21)


### Features

* add dynamic block with subnet_mapping ([d1dde78](https://github.com/edelwud/terrafrom-aws-alb/commit/d1dde78b46316d2adc7a6e7d0549d9eaacbbbae9))
* add subnet mapping variable ([f5fe43e](https://github.com/edelwud/terrafrom-aws-alb/commit/f5fe43e9e7e4c5496c056254df4ebcf901ea4d0e))

## [1.6.0](https://github.com/edelwud/terrafrom-aws-alb/compare/v1.5.1...v1.6.0) (2022-02-21)


### Features

* add `versions.tf` with required `aws` provider ([70ee3a5](https://github.com/edelwud/terrafrom-aws-alb/commit/70ee3a58f6aff049de149867a920a72eff71e6f5))
* add empty `variables.tf` and `outputs.tf` files ([c9d6cf0](https://github.com/edelwud/terrafrom-aws-alb/commit/c9d6cf0c4173e485844663ba1aa2c1f84435f91e))
* add newline at the end of file ([8d79d3c](https://github.com/edelwud/terrafrom-aws-alb/commit/8d79d3c92977ad6e8b37bdac22ef6726ca310057))
* add pre-commit workflow ([7f01366](https://github.com/edelwud/terrafrom-aws-alb/commit/7f01366cb3d90e094d70e0fccc360da835196a31))
* add useful outputs variables ([8d9c0d7](https://github.com/edelwud/terrafrom-aws-alb/commit/8d9c0d7d441fa556fd92479f657bd59483abea7a))
* remove `vpc_id` variable from `complete-alb` ([01107fa](https://github.com/edelwud/terrafrom-aws-alb/commit/01107fa3b13a0d8ceec9dffdf6ff271c814c55c5))
* remove unused `vpc_id` variable ([ffd7e8b](https://github.com/edelwud/terrafrom-aws-alb/commit/ffd7e8bc37f1f88bf30cf745d6862566dd6210ef))


### Bug Fixes

* add Apache 2.0 LICENSE ([807b956](https://github.com/edelwud/terrafrom-aws-alb/commit/807b9564619f659301f5bdf0948df8f0a3d0e70a))

### [1.5.1](https://github.com/edelwud/terrafrom-aws-alb/compare/v1.5.0...v1.5.1) (2022-02-18)


### Bug Fixes

* listener rule condition patterns ([db00dea](https://github.com/edelwud/terrafrom-aws-alb/commit/db00dea3af30f848ab1a2fb68b8dcb9b1e5846e6))

## [1.5.0](https://github.com/edelwud/terrafrom-aws-alb/compare/v1.4.0...v1.5.0) (2022-02-18)


### Features

* add `authenticate_cognito` and `authenticate_oidc` listener implementation ([01ccda8](https://github.com/edelwud/terrafrom-aws-alb/commit/01ccda8a72b9791e790cad734d4dc42504952630))
* add `authenticate_cognito` and `authenticate_oidc` listener rule implementation ([27310f7](https://github.com/edelwud/terrafrom-aws-alb/commit/27310f75415f22f9e4b4260c8b7935beb244ef5f))
* complete `authenticate_*` example ([39f0960](https://github.com/edelwud/terrafrom-aws-alb/commit/39f0960edafc38a42d7e671c46aadd942a9ad71c))


### Bug Fixes

* local sub-rule `authenticate_cognito` and `authenticate_oidc` identify ([6021b92](https://github.com/edelwud/terrafrom-aws-alb/commit/6021b92016578e073a8755ba7902ef9c8f1854f8))

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
