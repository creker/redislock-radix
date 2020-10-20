# redislock

[![Build Status](https://travis-ci.org/creker/redislock-radix.png?branch=master)](https://travis-ci.org/creker/redislock-radix)
[![GoDoc](https://godoc.org/github.com/creker/redislock-radix?status.png)](http://godoc.org/github.com/creker/redislock-radix)
[![Go Report Card](https://goreportcard.com/badge/github.com/creker/redislock-radix)](https://goreportcard.com/report/github.com/creker/redislock-radix)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This is a fork of [https://github.com/bsm/redislock](https://github.com/bsm/redislock) that replaces go-redis with radix.

Simplified distributed locking implementation using [Redis](http://redis.io/topics/distlock).
For more information, please see examples.

## Examples

```go
import (
  "fmt"
  "time"

  redislock "github.com/creker/redislock-radix"
	"github.com/mediocregopher/radix/v3"
)

func main() {{ "Example" | code }}
```

## Documentation

Full documentation is available on [GoDoc](https://godoc.org/github.com/creker/redislock-radix)
