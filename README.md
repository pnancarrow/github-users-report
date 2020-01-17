# Github Users Report

This can be used to generate a report of users with access to your Github organization into a csv file. It includes user role (member, admin, or outside collaborator) and team membership.

Inspired by and adpated from work by [jdennes](https://gist.github.com/jdennes/11404512) and [jsimpson](https://github.com/jsimpson/github-organization-reports). 

## Setup

Install [Octokit](https://github.com/octokit/octokit.rb):

```bash
$ bundle install
```

Set `ORG` with the name of your Github organization:

```
# Add you Github organization name here
ORG = "[ORG NAME HERE]"
```

Generate a Github API token if you don't already have one. It will need admin read permissions to your organization. A token can be created by navigating to `Settings` > `Developer settings` > `Personal access tokens` > `Generate new token`. 

## Use

```bash
$ OCTOKIT_ACCESS_TOKEN=[YOUR API TOKEN HERE] bundle exec ruby github-users-report.rb
```
