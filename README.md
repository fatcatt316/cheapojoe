# CheapoJoe

Finding nearby yard sales so you can stay one step ahead of the competitive yard-salers competition.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [What Can This Do?](#what-can-this-do)
  - [As of now...](#as-of-now)
  - [Big Plans...](#big-plans)
- [Development](#development)
- [Tests](#tests)
- [Installation](#installation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## What Can This Do?
### As of now...
This will find you yard sales around Durham that are listed at [yardsalesearch.com](https://www.yardsalesearch.com).

### Big Plans...
* Compile yard sale locations and information from multiple sources
* Allow optional args specifying city, date, etc.
* Create an optimized route to hit up these yard sales
* Maybe this will have a front-end or API, one day... one day...
* Get bigger than Facebook and Google (combined)

## Development
While developing and testing, you can run commands like this:

```bash
mix run -e 'CheapoJoe.CLI.main(["--cities"])'
```

When you're ready to create a `cheapojoe` executable, just run this puppy:

```
mix escript.build
```

Voíla! You should now be able to run `./cheapojoe --help` from your electronic computer terminal console area box.

## Tests
These would be a great idea!

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cheapojoe` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cheapojoe, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/cheapojoe](https://hexdocs.pm/cheapojoe).

