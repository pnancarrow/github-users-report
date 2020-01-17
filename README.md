# Intro

Inspired by work by [jdennes](]ttps://gist.github.com/jdennes/11404512) and [jsimpson](https://github.com/jsimpson/github-organization-reports). 

# Usage:

Get set up:

```shell
$ git clone https://gist.github.com/11404512.git export-members; cd export-members 
```

Bundle (we're going to use [Octokit](https://github.com/octokit/octokit.rb)):

```shell
$ bundle install
```

Set `ORG` with the name of your organization in `export-all-members.rb`.

Then export all members:

```shell
$ OCTOKIT_ACCESS_TOKEN=<yourtoken> bundle exec ruby export-members.rb
$ cat export-all.csv
```

or, export members with 2FA disabled:

```shell
$ OCTOKIT_ACCESS_TOKEN=<yourtoken> bundle exec ruby export-all-members-with-2fa-disabled.rb
$ cat export-2fa-disabled.csv
```
